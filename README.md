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
  # Get IDS of disks
  lsblk -o +ID-LINK

  # Get hardware config
  nixos-generate-config --no-filesystems --show-hardware-config

  # List previous generations
  sudo nix-env --list-generations -p /nix/var/nix/profiles/system

  # Live switch to any generation
  sudo nix-env --switch-generation 12345 -p /nix/var/nix/profiles/system
  sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch

```

### Install
```bash
  # Note: this installs the flake curently loaded in the shell, refresh with direnv reload after changes
  # Add host and hardware config to flake first
  install-nixos hostname /dev/sda
```


