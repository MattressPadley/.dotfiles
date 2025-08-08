#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"

# Check if we can use the locally built CCUsage or need npx
CCUSAGE_CMD=""
if [ -f "$HOME/Dev/ccusage/dist/index.js" ]; then
    CCUSAGE_CMD="/opt/homebrew/bin/node $HOME/Dev/ccusage/dist/index.js"
elif command -v /opt/homebrew/bin/npx >/dev/null 2>&1; then
    CCUSAGE_CMD="/opt/homebrew/bin/npx ccusage@latest"
else
    # No CCUsage available, show N/A
    sketchybar --set claude_usage.session_bar label="░░░░░░░░░░" \
               --set claude_usage.session_value label="N/A" \
               --set claude_usage.usage_bar label="░░░░░░░░░░" \
               --set claude_usage.usage_value label="N/A" \
               --set claude_usage.projection_bar label="░░░░░░░░░░" \
               --set claude_usage.projection_value label="N/A"
    exit 0
fi

# Get current usage data using CCUsage CLI with max token limit (like the dashboard)
USAGE_DATA=$($CCUSAGE_CMD blocks --active --token-limit max --json 2>/dev/null)

# Parse the JSON result and calculate percentages  
if [ -n "$USAGE_DATA" ] && echo "$USAGE_DATA" | grep -q '"blocks"' && echo "$USAGE_DATA" | grep -q '"isActive"'; then
    # Extract block data using node (more reliable than shell JSON parsing)
    BLOCK_DATA=$(echo "$USAGE_DATA" | /opt/homebrew/bin/node -e "
        const data = JSON.parse(require('fs').readFileSync(0, 'utf8'));
        const block = data.blocks && data.blocks[0];
        if (block && block.isActive) {
            const now = new Date();
            const startTime = new Date(block.startTime);
            const endTime = new Date(block.endTime);
            const elapsed = (now.getTime() - startTime.getTime()) / (1000 * 60);
            const total = (endTime.getTime() - startTime.getTime()) / (1000 * 60);
            const sessionPercent = Math.min(elapsed / total, 1);
            
            // Use the actual token limit and percentages from CCUsage
            let usagePercent = 0;
            let projectionPercent = 0;
            let tokenLimit = 500000; // fallback
            
            if (block.tokenLimitStatus) {
                tokenLimit = block.tokenLimitStatus.limit;
                // Calculate actual current usage percentage from totalTokens
                usagePercent = Math.min(block.totalTokens / tokenLimit, 1);
                
                // Use the projected usage from tokenLimitStatus
                projectionPercent = Math.min(block.tokenLimitStatus.projectedUsage / tokenLimit, 1);
            }
            
            // Format session end time
            const sessionEndTime = new Date(block.endTime);
            const endTimeStr = sessionEndTime.toLocaleTimeString([], {hour: 'numeric', minute: '2-digit', hour12: true}).replace(/\s?(AM|PM)$/i, '');
            
            console.log(JSON.stringify({
                sessionPercent,
                usagePercent,
                projectionPercent,
                usagePercentDisplay: Math.round((block.totalTokens / tokenLimit) * 100),
                projectionPercentDisplay: Math.round((block.tokenLimitStatus.projectedUsage / tokenLimit) * 100),
                sessionEndTime: endTimeStr,
                totalTokens: block.totalTokens,
                projectedTokens: block.projection ? block.projection.totalTokens : block.totalTokens,
                cost: block.costUSD,
                burnRate: block.burnRate ? Math.round(block.burnRate.tokensPerMinute) : 0,
                tokenLimit
            }));
        } else {
            console.log('{}');
        }
    ")

    # Extract calculated values
    SESSION_PERCENT=$(echo "$BLOCK_DATA" | /opt/homebrew/bin/node -e "const d=JSON.parse(require('fs').readFileSync(0,'utf8')); console.log(d.sessionPercent || 0);")
    USAGE_PERCENT=$(echo "$BLOCK_DATA" | /opt/homebrew/bin/node -e "const d=JSON.parse(require('fs').readFileSync(0,'utf8')); console.log(d.usagePercent || 0);")
    PROJECTION_PERCENT=$(echo "$BLOCK_DATA" | /opt/homebrew/bin/node -e "const d=JSON.parse(require('fs').readFileSync(0,'utf8')); console.log(d.projectionPercent || 0);")
    USAGE_PERCENT_DISPLAY=$(echo "$BLOCK_DATA" | /opt/homebrew/bin/node -e "const d=JSON.parse(require('fs').readFileSync(0,'utf8')); console.log(d.usagePercentDisplay || 0);")
    PROJECTION_PERCENT_DISPLAY=$(echo "$BLOCK_DATA" | /opt/homebrew/bin/node -e "const d=JSON.parse(require('fs').readFileSync(0,'utf8')); console.log(d.projectionPercentDisplay || 0);")
    SESSION_END_TIME=$(echo "$BLOCK_DATA" | /opt/homebrew/bin/node -e "const d=JSON.parse(require('fs').readFileSync(0,'utf8')); console.log(d.sessionEndTime || '00:00');")

    # Function to create a text-based progress bar
    create_progress_bar() {
        local percent=$1
        local width=10
        local filled=$(echo "$percent * $width" | bc -l | awk '{printf "%.0f", $1}')
        
        # Ensure we don't exceed the width and handle negative values
        if [ "$filled" -gt "$width" ]; then
            filled=$width
        elif [ "$filled" -lt 0 ]; then
            filled=0
        fi
        
        local empty=$((width - filled))
        
        # Create the bar using solid block characters
        local bar=""
        local i=0
        while [ $i -lt $filled ]; do
            bar="${bar}█"
            i=$((i + 1))
        done
        while [ $i -lt $width ]; do
            bar="${bar}░"
            i=$((i + 1))
        done
        
        echo "$bar"
    }

    # Create progress bars
    SESSION_BAR=$(create_progress_bar $SESSION_PERCENT)
    USAGE_BAR=$(create_progress_bar $USAGE_PERCENT)
    PROJECTION_BAR=$(create_progress_bar $PROJECTION_PERCENT)

    # Determine colors based on percentages
    SESSION_COLOR=$BLUE
    
    USAGE_COLOR=$GREEN
    if [ "$USAGE_PERCENT_DISPLAY" -gt 80 ]; then
        USAGE_COLOR=$YELLOW
    fi
    if [ "$USAGE_PERCENT_DISPLAY" -gt 100 ]; then
        USAGE_COLOR=$RED
    fi
    
    PROJECTION_COLOR=$GREEN
    if [ "$PROJECTION_PERCENT_DISPLAY" -gt 80 ]; then
        PROJECTION_COLOR=$YELLOW
    fi
    if [ "$PROJECTION_PERCENT_DISPLAY" -gt 100 ]; then
        PROJECTION_COLOR=$RED
    fi

    # Update the separate bar and value labels
    sketchybar --set claude_usage.session_bar \
                     label="$SESSION_BAR" \
                     label.color=$SESSION_COLOR \
               --set claude_usage.session_value \
                     label="$SESSION_END_TIME" \
                     label.color=$SESSION_COLOR \
               --set claude_usage.usage_bar \
                     label="$USAGE_BAR" \
                     label.color=$USAGE_COLOR \
               --set claude_usage.usage_value \
                     label="${USAGE_PERCENT_DISPLAY}%" \
                     label.color=$USAGE_COLOR \
               --set claude_usage.projection_bar \
                     label="$PROJECTION_BAR" \
                     label.color=$PROJECTION_COLOR \
               --set claude_usage.projection_value \
                     label="${PROJECTION_PERCENT_DISPLAY}%" \
                     label.color=$PROJECTION_COLOR

else
    # No active session, show empty bars
    sketchybar --set claude_usage.session_bar label="░░░░░░░░░░" \
               --set claude_usage.session_value label="--:--" \
               --set claude_usage.usage_bar label="░░░░░░░░░░" \
               --set claude_usage.usage_value label="0%" \
               --set claude_usage.projection_bar label="░░░░░░░░░░" \
               --set claude_usage.projection_value label="0%"
fi