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

# Re-open the container with the keyfile and start btrfs setup
sudo cryptsetup luksOpen /dev/{{disk}} luks-{{disk}} --key-file {{path to keyfile}}
# Create file system
sudo mkfs.btrfs -L luks-{{disk}} /dev/mapper/luks-{{disk}}
```