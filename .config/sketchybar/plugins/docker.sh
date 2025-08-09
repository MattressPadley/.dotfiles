#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"

# Set PATH to include common Docker locations
export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"

# Check if Docker is running
if ! /usr/local/bin/docker info >/dev/null 2>&1; then
    sketchybar --set docker.count label="Offline" \
                                 label.color=$RED \
               --set docker.cpu label="" \
               --set docker.ram label=""
    exit 0
fi

# Get container count
CONTAINER_COUNT=$(/usr/local/bin/docker ps -q | wc -l | tr -d ' ')

if [ "$CONTAINER_COUNT" -eq 0 ]; then
    sketchybar --set docker.count label="0" \
                                 label.color=$LABEL_COLOR \
               --set docker.cpu label="" \
               --set docker.ram label=""
    exit 0
fi

# Get Docker stats
DOCKER_STATS=$(/usr/local/bin/docker stats --no-stream --format "{{.CPUPerc}},{{.MemUsage}}" 2>/dev/null)

if [ -z "$DOCKER_STATS" ]; then
    sketchybar --set docker.count label="$CONTAINER_COUNT" \
                                 label.color=$LABEL_COLOR \
               --set docker.cpu label="--" \
               --set docker.ram label="--"
    exit 0
fi

# Calculate total CPU and memory
TOTAL_CPU=0
TOTAL_MEM_USED=0

while IFS=',' read -r cpu mem; do
    # Extract CPU percentage (remove % sign)
    cpu_num=$(echo "$cpu" | sed 's/%//')
    if [ -n "$cpu_num" ] && [ "$cpu_num" != "--" ]; then
        TOTAL_CPU=$(echo "$TOTAL_CPU + $cpu_num" | bc -l 2>/dev/null || echo "$TOTAL_CPU")
    fi
    
    # Extract memory usage (e.g., "123.4MiB" -> 123.4)
    mem_used=$(echo "$mem" | awk '{print $1}' | sed 's/[^0-9.]//g')
    mem_unit=$(echo "$mem" | awk '{print $1}' | sed 's/[0-9.]//g')
    
    # Convert to MB for consistent calculation
    if [ "$mem_unit" = "GiB" ]; then
        mem_used=$(echo "$mem_used * 1024" | bc -l 2>/dev/null || echo "$mem_used")
    fi
    
    if [ -n "$mem_used" ]; then
        TOTAL_MEM_USED=$(echo "$TOTAL_MEM_USED + $mem_used" | bc -l 2>/dev/null || echo "$TOTAL_MEM_USED")
    fi
done <<< "$DOCKER_STATS"

# Round CPU to nearest integer
TOTAL_CPU=$(printf "%.0f" "$TOTAL_CPU" 2>/dev/null || echo "0")

# Format memory display
if [ $(echo "$TOTAL_MEM_USED > 1024" | bc -l 2>/dev/null || echo "0") -eq 1 ]; then
    TOTAL_MEM_DISPLAY=$(echo "scale=1; $TOTAL_MEM_USED / 1024" | bc -l 2>/dev/null)GB
else
    TOTAL_MEM_DISPLAY=$(printf "%.0f" "$TOTAL_MEM_USED" 2>/dev/null || echo "0")MB
fi

# Determine colors based on usage
CPU_COLOR=$YELLOW
case "$TOTAL_CPU" in
    [5-9][0-9]|[1-9][0-9][0-9]) CPU_COLOR=$RED ;;
    [3-4][0-9]) CPU_COLOR=$PEACH ;;
    [2][0-9]) CPU_COLOR=$YELLOW ;;
esac

# Update all items
sketchybar --set docker.count label="$CONTAINER_COUNT " \
                             label.color=$LABEL_COLOR \
           --set docker.cpu label="${TOTAL_CPU}%" \
                           label.color=$CPU_COLOR \
           --set docker.ram label="$TOTAL_MEM_DISPLAY" \
                           label.color=$BLUE
