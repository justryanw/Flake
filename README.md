# Install Guide
Replace `/dev/sda` with name of disk

### Install to USB
```bash
  write-usb /dev/sda
```

### Run USB with QEMU
```bash
  run-usb /dev/sda
```

### Useful Commands
```bash
  # Get UUID of disk
  lsblk -dno UUID /dev/DISK1

  # Get hardware config
  nixos-generate-config --no-filesystems --show-hardware-config
```

### Install
```bash
  # Add host and hardware config to flake first
  install-nixos hostname /dev/sda
```


