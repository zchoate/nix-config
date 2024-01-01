# CHNAS01

## Disk setup
```bash
# Generate RSA key and set permissions
openssl genrsa 4096 > {{path to keyfile}}
sudo chmod 0400 {{path to keyfile}}
sudo chown root:root {{path to keyfile}}
# LUKS setup
sudo cryptsetup luksFormat /dev/{{disk}}
# Enter passphrase
sudo cryptsetup luksAddKey /dev/{{disk}} {{path to keyfile}}
# Enter passphrase again

# To validate passphrase
sudo cryptsetup luksOpen /dev/{{disk}} temp
# Check /dev/mapper for temp
ls /dev/mapper/
# Close the container
sudo cryptsetup close temp
# To validate keyfile
sudo cryptsetup luksOpen /dev/{{disk}} temp --key-file {{path to keyfile}}
# Check /dev/mapper for temp
ls /dev/mapper/
# Close the container
sudo cryptsetup close temp

## Repeat the above steps for the physical disks, then proceed to setup btrfs with raid1

# Re-open the container with the keyfile and start btrfs setup
sudo cryptsetup luksOpen /dev/{{disk}} luks-{{disk}} --key-file {{path to keyfile}}
# Open container for the second disk
sudo cryptsetup luksOpen /dev/{{disk2}} luks-{{disk2}} --key-file {{path to keyfile}}
# Create file system spanning both disks
sudo mkfs.btrfs -L data-{{storage array number}} -m raid1 -d raid1 /dev/mapper/luks-{{disk}}
# Create folder for the mount point
sudo mkdir -p /data/data-{{storage array number}}
# Get UUID of the file system
sudo btrfs filesystem show
# Mount the fs using the UUID
sudo mount -o compress=zstd,noatime /dev/disk/by-uuid/{{fs uuid}} /data/data-{{storage array number}}

## Update the hardware-configuration.nix file
```