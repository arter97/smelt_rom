#!/system/bin/sh

exec > /dev/kmsg 2>&1

export PATH=/system/xbin:$PATH

# Sleep for 3 seconds to allow charging animation to start
busybox sleep 3

if busybox pgrep e4defrag > /dev/null; then
  echo "charge.sh: previous run didn't finish yet"
  exit 1
fi

if [[ $(busybox cat /sys/class/power_supply/max170xx_battery/status) != "Charging" ]]; then
  exit 1
fi
echo "chsh" > /sys/power/wake_lock

busybox sync
echo "3" > /proc/sys/vm/drop_caches

echo "charge.sh: trimming /data"
busybox fstrim -v /data
echo "charge.sh: trimming done"

echo "charge.sh: defragging /data"
e4defrag /data | busybox tail -n2
echo "charge.sh: defragging done"

busybox sync
echo "3" > /proc/sys/vm/drop_caches

echo "chsh" > /sys/power/wake_unlock
