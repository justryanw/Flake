# Install Guide
Replace `/dev/sda` with name of disk

### Install to USB
```bash
  sudo nix run 'github:nix-community/disko#disko-install' -- --flake .#usb --disk main /dev/sda
```

### Run USB with QEMU
```bash
  sudo nix run nixpkgs#qemu_kvm -- -enable-kvm -smp cores=4,threads=2 -m 8G -hda /dev/sda
```

### Useful Commands
```bash
  # Get UUID of disk
  lsblk -dno UUID /dev/DISK1

  # Get hardware config
  nixos-generate-config --root /mnt --show-hardware-config
```

### Install
```bash
  # Add host and hardware config to flake first
  sudo nix run 'github:nix-community/disko#disko-install' -- --write-efi-boot-entries --flake .#hostname --disk main /dev/sda
```


