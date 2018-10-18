## ASUS P8P67 PRO (REV3.0)

### Info

Guide how to install OS X Mojave on ASUS P8P67 PRO (REV3.0)

---

### Install OS X Mojave

#### 1. Create clover USB-Drive

##### a) Format USB flash drive

- Format USB-Drive with GUID and HFS+
	- Find the correct disk number of USB-Drive:
	```
	diskutil list
	```
	- Replace {#} with corresponding disk number and {Volume} with desired Name:
	```
	diskutil partitionDisk /dev/disk{#} 1 GPT HFS+ {Volume} R
	```
- Download Clover: [sourceforge.net](https://sourceforge.net/projects/cloverefiboot/)

##### b) Install clover [clover-wiki](https://clover-wiki.zetam.org/Installation)

- Run clover installer
	- Select USB-Drive as install target
	- Open custom install settings
		- Select `Install Clover for UEFI`
    	- Select Drivers64UEFI
	- Install

##### c) Add drivers and kexts

- Copy `EFI/BOOT/BOOTX64.efi` to USB-Drive root and rename it to `SHELLX64.efi`
- Copy kexts from folder `Other` to `EFI/CLOVER/kexts/Other/`
- Add clover boot args: `-v npci=0x2000 nv_disable=1`
	- Depending on graphics card add boot arg `-no_compat_check`
- As SMBIOS select `iMac17.1`
- On `Error loading kernel cache (0x9)` reboot

Note:
- Adding `apfs.efi` or `ApfsDriverLoader-64` to `EFI/CLOVER/drivers64UEFI/` causes Clover to hang on load, so use HFS+ filesystem
- Adding `HFSPlus-64` to `EFI/CLOVER/drivers64UEFI/` causes Clover to hang on load, use `VBoxHfs-64` instead

---

#### 2. Create Mojave USB-Drive

To create a working macOS Mojave installer boot drive, you will need the following:
- A free USB flash drive (minimum 8GB)
- A device already running OS X with access to the App Store

##### a) Download OS X Installer

- Open the Mac App Store on your device already running OS X
- Download `Install macOS Mojave` application
- Close when it opens automatically

##### b) Format USB flash drive

- Insert USB flash drive
- Open Disk Utility and format flash drive
	- Select `GUID` as partition scheme
	- Select `Mac OS Extended (Journaled)` as file format

##### c) Create Installer

Use [DiskMaker X](http://diskmakerx.com/) or [Install Disk Creator](https://macdaddy.io/install-disk-creator/)
<br>Special case to force Mojave Install to keep HFS+ during install:
- download [14MBRinstallerMaker](https://www.insanelymac.com/forum/files/file/944-mojave-mbr-hfs-firmware-check-patch/)
- Connect target HDD and Mojave USB drive
- Open `14MBRinstallerMaker` and follow the instructions
	- Enter password to grant admin privileges
	- Drag `Install macOS Mojave.app` to terminal
	- Drag USB flash drive to terminal
	- Drag target HDD to terminal
- Wait for installation process to finish

---

#### 3. Install Mojave

- Connect target HDD, Mojave USB drive and Clover USB drive to your target machine
- Boot from Clover USB drive and select Mojave USB drive (`Install OS X Mojave`)
- The installation should start automatically (dont worry about reboot after one minute)

---

#### 4. Install Clover in EFI partition on Mojave Disk

- After successfully install repeat steps 1b - 1c but with EFI on Mojave HDD as target

---

#### 5. Post Install

##### Clover Configurator

Download and install Clover Configurator [Link](http://mackie100projects.altervista.org/download-clover-configurator/)

##### nVidia WebDriver

- Install latest nVidia WebDrivers using [nVidia Update](https://github.com/Benjamin-Dobell/nvidia-update)

  ```sh
  bash <(curl -s https://raw.githubusercontent.com/Benjamin-Dobell/nvidia-update/master/nvidia-update.sh)
  ```

- Open config.plist in clover configurator
	- In section `Boot` remove `nv_disable=1` and add `nvda_drv=1` as boot args
	- In section `System Parameters` check `Injext System ID` and `NvidiaWeb`
- Save config.plist

---

### Update OS X

- Make a full backup
- Check [hackintosher.com](https://hackintosher.com/guides/) for the latest OS X Update Guide
- Check all kexts for updates
- Make a new clover USB drive for testing purpose
	- Use updated kexts and drivers in post install
- Boot from new clover USB drive
- If system boots
	- Mount EFI partition of OS X HDD
	- Backup `EFI` to `EFI-Backups`
	- Install new clover version to EFI partition
	- Copy updated kexts and drivers during post install
	- Don't forget to copy `Microsoft` folder (it contains the windows bootloader)
- Eject clover USB drive and reboot
- If system boots
	- Start OS X Update
	- On restart select newly added `Install OS X ...` partition
	- Disable all BCRM kexts to prevent loop at the end of boot
	- After reboot select normal OS X partition
- If system boots
	- Be happy and enjoy the new update
- If system doesn't boot on one of these steps
	- Try to fix the problem or revert to the latest backup

---

## Resources

### SSDT

Generate your SSDT with ssdtPRGen: [github.com/Piker-Alpha](https://github.com/Piker-Alpha/ssdtPRGen.sh)
<br>*To be done*

### Kexts

#### WiFi

AzureWave Broadcom BCM94352HMB/BCM94352 WLAN+BT4.0 macOS Sierra 10.12.1 [forum.osxlatitude.com](http://forum.osxlatitude.com/index.php?/topic/9414-azurewave-broadcom-bcm94352hmbbcm94352-wlanbt40-macos-sierra-10121/)

LiLu.kext: [github.com/acidanthera](https://github.com/acidanthera/Lilu/releases)

AirportBrcmFixup.kext [sourceforge.net](https://sourceforge.net/projects/airportbrcmfixup/files/)

Add following entries to EFI/CLOVER/config.plist:
- ACPI > Fixes > AddDTGP
- ACPI > Fixes > FixAirport
- Devices > Fake ID > WIFI = 0x43a014E4

#### Bluetooth

BrcmFirmwareData.kext and BrcmPatchRAM2.kext [bitbucket.org/RehabMan](https://bitbucket.org/RehabMan/os-x-brcmpatchram/downloads/)

### Ethernet

IntelMausiEthernet.kext: [bitbucket.org/RehabMan](https://bitbucket.org/RehabMan/os-x-intel-network/downloads/)

#### Sensors

BrcmPatchRAM: [bitbucket.org/RehabMan](https://bitbucket.org/RehabMan/os-x-brcmpatchram/downloads/)

FakeSMC: [bitbucket.org/RehabMan](https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/)

FakePCIID: [bitbucket.org/RehabMan](https://bitbucket.org/RehabMan/os-x-fake-pci-id/downloads/)

#### CPU

NullCPUPowerManagement.kext: [tonymacx86.com](https://www.tonymacx86.com/resources/nullcpupowermanagement.268/)

#### Audio

VoodooHDA + AppleHDADisabler: [sourceforge.net](https://sourceforge.net/projects/voodoohda/files/), [hackintosh.zone](https://www.hackintosh.zone/file/1023-voodoohda-290d10/)

#### Graphics

WhateverGreen.kext: [github.com/acidanthera](https://github.com/acidanthera/WhateverGreen)

### Kext Resources

Broadcom BCM4352 802.11 ac wifi and bluetooth combo card: [forum.osxlatitude.com](http://forum.osxlatitude.com/index.php?/topic/2767-broadcom-bcm4352-80211-ac-wifi-and-bluetooth-combo-card/)

KextToPatch Einträge für High Sierra: [hackintosh-forum.de](https://www.hackintosh-forum.de/index.php/Thread/28676-Neue-Clover-KextsToPatch-Eintr%C3%A4ge-f%C3%BCr-Sierra-High-Sierra/)
