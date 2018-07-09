#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery:10397696:46b772064a3ec8a0a8b1703ab1bc8a19aac247a2; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/msm_sdcc.1/by-name/boot:9441280:e2bd0e3df1ae45ed53cf0a90b8c37021b94db7c0 EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery 46b772064a3ec8a0a8b1703ab1bc8a19aac247a2 10397696 e2bd0e3df1ae45ed53cf0a90b8c37021b94db7c0:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
