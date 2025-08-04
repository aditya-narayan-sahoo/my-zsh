#install acpi to run this
#!/bin/bash

# Get battery percentage using acpi
battery_level=$(acpi -b | grep -o '[0-9]\+%' | head -n 1)

# Get the current time in 12-hour format with AM/PM
current_time=$(date +"%I:%M %p")

# Append the battery level and current time to the file
echo "$battery_level $current_time" >> ~/Desktop/battery.txt
