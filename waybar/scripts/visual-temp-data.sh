watch -n 2 '
echo "=== Thermal Zones ===";
for zone in /sys/class/thermal/thermal_zone*; do 
  if [ -f "$zone/temp" ]; then 
    temp=$(cat "$zone/temp" 2>/dev/null); 
    type=$(cat "$zone/type" 2>/dev/null);
    if [ -n "$temp" ] && [ "$temp" -gt 0 ]; then
      echo "$type: $((temp/1000))°C";
    fi
  fi
done;
echo -e "\n=== Sensors Output ===";
sensors 2>/dev/null | grep -E "(°C|temp)" | head -20
'