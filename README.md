# NixOS Configuration

## Rebuild NixOS

To rebuild your NixOS configuration, run the following command:

```
sudo nixos-rebuild switch --flake /etc/nixos/#default
```
## Adding Configuration for Another OS

  1.Locate the EFI partition of the other OS.
  2.Mount the EFI partition using the following commands:
```
sudo mkdir -p /mnt/esp
sudo mount /dev/nvme0n1p1 /mnt/esp
```
**⚠️ Warning:** The device path `/dev/nvme0n1p1` is an example. Make sure to replace it with the correct path for your EFI partition.

  3. Copy the EFI files to the NixOS boot directory. For example, if the files are located in EFI/Microsoft, copy them as follows:
```
sudo cp -r /mnt/esp/EFI/Microsoft /boot/EFI/
```
