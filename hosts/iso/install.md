# Install Guide
Replace `/dev/DISK` with name of disk

### Partition & Format Disk
```bash
  sudo parted /dev/DISK -- mklabel gpt
  sudo parted /dev/DISK -- mkpart root ext4 512MB 100%
  sudo parted /dev/DISK -- mkpart ESP fat32 0% 512MB
  sudo parted /dev/DISK -- set 2 esp on

  sudo mkfs.ext4 -L nixos /dev/DISK1
  sudo mkfs.fat -F 32 -n boot /dev/DISK2

  mount /dev/disk/by-label/nixos /mnt
  mkdir -p /mnt/boot
  mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
```

### Useful Commands
```bash
  # Get UUID of disk
  lsblk -dno UUID /dev/DISK1

  # Get hardware config
  nixos-generate-config --show-hardware-config
```

### Install
```bash
  # Add host and hardware config to flake first
  sudo nixos-install --no-root-passwd --flake PATH#hostname
```


