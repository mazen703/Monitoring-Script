#!/bin/bash

# Default values
DISK_THRESHOLD=80
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
LOG_FILE="system_monitor.log"

# Parse command-line arguments
parse_arguments() {
  while getopts "t:f:" opt; do
    case "$opt" in
      t) DISK_THRESHOLD=$OPTARG ;;
      f) LOG_FILE=$OPTARG ;;
      ?) echo "Usage: $0 [-t threshold] [-f log_file]"; exit 1 ;;
    esac
  done
}

# Get current date and time
get_current_datetime() {
  DATE=$(date "+%Y-%m-%d %H:%M:%S")
}

# Define colors for warnings
define_colors() {
  RED=$(tput setaf 1)
  RESET=$(tput sgr0)
}

# Collect disk usage
collect_disk_usage() {
  DISK_USAGE=$(df -h | awk 'NR==1 || $5+0 > 0 {print}')
 # DISK_ALERTS=$(df -h | awk -v t="$DISK_THRESHOLD" 'NR>1 && $5+0 >= t {print "Warning: "$1" is above "t"% usage!"}')
  #DISK_ALERTS=$(df -h | awk -v t="$DISK_THRESHOLD" '$1 == "/" && $5+0 >= t {print "Warning: Root partition is above "t"% usage!"}')
DISK_ALERTS=$(df / | awk -v t="$DISK_THRESHOLD" 'NR==2 && $5+0 >= t {print "Warning: Root partition is above "t"% usage!"}')
}

# Collect CPU usage
collect_cpu_usage() {
  CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
  if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
    CPU_ALERT="Warning: CPU usage is above $CPU_THRESHOLD% (Current: $CPU_USAGE%)"
  fi
}

# Collect memory usage
collect_memory_usage() {
  MEMORY_INFO=$(free -h | awk 'NR==2 {print "Total Memory:", $2, "\nUsed Memory:", $3, "\nFree Memory:", $4}')
  USED_MEMORY=$(free -m | awk 'NR==2 {print $3}')
  TOTAL_MEMORY=$(free -m | awk 'NR==2 {print $2}')
  
  # Calculate percentage of memory used
  MEMORY_USAGE_PERCENT=$(echo "$USED_MEMORY / $TOTAL_MEMORY * 100" | bc)
  
  if (( $(echo "$MEMORY_USAGE_PERCENT > $MEMORY_THRESHOLD" | bc -l) )); then
    MEMORY_ALERT="Warning: Memory usage is above $MEMORY_THRESHOLD% (Current: $MEMORY_USAGE_PERCENT%)"
  fi
}

# Collect top 5 memory-consuming processes
collect_top_processes() {
  TOP_PROCESSES=$(ps aux --sort=-%mem | head -n 6)
}

# Generate the report
generate_report() {
  REPORT="System Monitoring Report - $DATE
======================================
Disk Usage:
$DISK_USAGE

$DISK_ALERTS

CPU Usage:
Current CPU Usage: $CPU_USAGE%
$CPU_ALERT

Memory Usage:
$MEMORY_INFO
$MEMORY_ALERT

Top 5 Memory-Consuming Processes:
$TOP_PROCESSES
"

  # Save to log file
  echo "$REPORT" > "$LOG_FILE"

  # Send email if any warnings exist
  if [[ -n "$DISK_ALERTS" ]] || [[ -n "$CPU_ALERT" ]] || [[ -n "$MEMORY_ALERT" ]]; then
    echo "$REPORT" | mail -s "System Monitoring Alert - $DATE" mazenelbialy1010@gmail.com
fi

}

# Main script
parse_arguments "$@"
get_current_datetime
define_colors
collect_disk_usage
collect_cpu_usage
collect_memory_usage
collect_top_processes
generate_report
