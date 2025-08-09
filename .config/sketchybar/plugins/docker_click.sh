#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"

# Set PATH to include common Docker locations
export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"

# Check if Docker is running
if ! /usr/local/bin/docker info >/dev/null 2>&1; then
    exit 0
fi

# Get running containers (just names for initial popup)
CONTAINERS=$(/usr/local/bin/docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}" | tail -n +2)

# Create popup items immediately
args=(--remove '/docker\.container\.*/' --remove '/docker\.refresh/' --remove '/docker\.close/' --set docker.icon popup.drawing=toggle)

if [ -z "$CONTAINERS" ]; then
    # No containers running
    args+=(--add item docker.no_containers popup.docker.icon \
           --set docker.no_containers label="No containers running" \
                                      label.color=$LABEL_COLOR \
                                      icon.drawing=off \
                                      background.color=$BACKGROUND_2 \
                                      background.corner_radius=8 \
                                      padding_left=10 \
                                      padding_right=10)
else
    COUNTER=0
    
    # Add header
    args+=(--add item docker.header popup.docker.icon \
           --set docker.header label="Running Containers" \
                                label.color=$HIGHLIGHT_COLOR \
                                label.font="$FONT:Bold:18.0" \
                                icon.drawing=off \
                                background.color=$BACKGROUND_1 \
                                background.corner_radius=8 \
                                padding_left=10 \
                                padding_right=10)
    
    # Add each container with loading placeholders first
    while IFS=$'\t' read -r name image status; do
        if [ -n "$name" ]; then
            # Extract just the container name (first column)
            name=$(echo "$name" | awk '{print $1}')
            
            # Format the container name (truncate if needed) - allow longer names
            DISPLAY_NAME="$name"
            if [ ${#DISPLAY_NAME} -gt 35 ]; then
                DISPLAY_NAME=$(echo "$DISPLAY_NAME" | cut -c1-32)...
            fi
            
            # Create initial item with loading placeholder
            PADDED_LABEL=$(printf "%-40s %s" "$DISPLAY_NAME" "Loading...")
            
            args+=(--add item docker.container.$COUNTER popup.docker.icon \
                   --set docker.container.$COUNTER label="$PADDED_LABEL" \
                                                   label.color=$LABEL_COLOR \
                                                   label.font="$FONT:Regular:13.0" \
                                                   icon.drawing=off \
                                                   background.drawing=off \
                                                   height=0 \
                                                   padding_left=10 \
                                                   padding_right=10 \
                                                   width=400 \
                                                   click_script="/usr/local/bin/docker exec -it $name sh 2>/dev/null || /usr/local/bin/docker logs --tail 20 $name | tail -10")
            
            COUNTER=$((COUNTER+1))
        fi
    done <<< "$CONTAINERS"
    
    # Add close option
    args+=(--add item docker.close popup.docker.icon \
           --set docker.close label="✕ Close" \
                              label.color=$RED \
                              icon.drawing=off \
                              background.drawing=off \
                              height=0 \
                              padding_left=10 \
                              padding_right=10 \
                              click_script="sketchybar --set docker.icon popup.drawing=off")
fi

sketchybar -m "${args[@]}" > /dev/null

# Now update each container with real stats in the background
if [ -n "$CONTAINERS" ]; then
    COUNTER=0
    while IFS=$'\t' read -r name image status; do
        if [ -n "$name" ]; then
            # Extract just the container name (first column)
            name=$(echo "$name" | awk '{print $1}')
            
            # Get real-time stats for this container
            CONTAINER_STATS=$(/usr/local/bin/docker stats --no-stream --format "{{.CPUPerc}} {{.MemUsage}}" "$name" 2>/dev/null)
            
            if [ -n "$CONTAINER_STATS" ]; then
                CPU_PERC=$(echo "$CONTAINER_STATS" | awk '{print $1}')
                # Extract just the used memory part (before the " / ")
                MEM_USAGE=$(echo "$CONTAINER_STATS" | awk '{print $2}' | cut -d'/' -f1 | xargs)
                
                # Determine CPU color based on usage
                CPU_NUM=$(echo "$CPU_PERC" | sed 's/%//')
                CPU_COLOR=$LABEL_COLOR
                case "$CPU_NUM" in
                    [5-9][0-9]*|[1-9][0-9][0-9]*) CPU_COLOR=$RED ;;
                    [3-4][0-9]*) CPU_COLOR=$PEACH ;;
                    [2][0-9]*) CPU_COLOR=$YELLOW ;;
                esac
                
                STATS_LABEL="${CPU_PERC} ${MEM_USAGE}"
            else
                STATS_LABEL="-- --"
                CPU_COLOR=$LABEL_COLOR
            fi
            
            # Format the container name (truncate if needed)
            DISPLAY_NAME="$name"
            if [ ${#DISPLAY_NAME} -gt 35 ]; then
                DISPLAY_NAME=$(echo "$DISPLAY_NAME" | cut -c1-32)...
            fi
            
            # Update the container item with real stats
            PADDED_LABEL=$(printf "%-40s %s" "$DISPLAY_NAME" "$STATS_LABEL")
            
            sketchybar --set docker.container.$COUNTER label="$PADDED_LABEL" \
                                                     label.color=$LABEL_COLOR
            
            COUNTER=$((COUNTER+1))
        fi
    done <<< "$CONTAINERS"
fi
