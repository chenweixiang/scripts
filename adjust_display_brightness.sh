# 可以这样设置: 首选项 > 电源管理 > 亮度 > 屏幕亮度 > 100%
cat /sys/class/backlight/intel_backlight/max_brightness > /sys/class/backlight/intel_backlight/brightness
