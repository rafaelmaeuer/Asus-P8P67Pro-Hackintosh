## ASUS P8P67 PRO (REV3.0)

### Info

Guide how to install OS X Mojave on ASUS P8P67 PRO (REV3.0)

---

#### BIOS

- Use version 3602
- Use correct BIOS settings
  `to be done`

#### Hardware

This Hackintosh is based on ASUS P8P67 PRO Mainboard with an Intel Core i7 2600K Processor, 16GB RAM and a Radeon GTX 570 graphics card.

##### WIFI / Bluetooth

The onboard Bluetooth is disabled. To get WiFi and Bluetooth running, a [ASUS PCE-AC55BT PCI-E](https://www.asus.com/de/Networking/PCE-AC55BT/) card is used as adapter with a [Broadcom BCM4352 Combo](https://osxlatitude.com/forums/topic/2767-broadcom-bcm4352-80211-ac-wifi-and-bluetooth-combo-card/) card as chip.

##### SATA

For eSATA and RAID a [DIGITUS SATA PCI-E](https://www.digitus.info/de/produkte/computer-zubehoer-und-komponenten/computer-zubehoer/io-karten/ds-30104-1/) card is used as the MARVELL 88SE9230 chip can be activated with the AHCIPortInjector.

---

### Install OS X

#### 1. Create Clover USB-Drive

##### a) Preparation

- Format USB-Drive with GUID and HFS+
  - Find the correct disk number of USB-Drive:

  ```sh
  diskutil list
  ```

  - Replace {#} with corresponding disk number and {Volume} with desired Name:

  ```sh
  diskutil partitionDisk /dev/disk{#} 1 GPT HFS+ {Volume} R
  ```

- Download Clover: [sourceforge.net](https://sourceforge.net/projects/cloverefiboot/)

##### b) Install Clover [clover-wiki](https://clover-wiki.zetam.org/Installation)

- Run clover installer
  - Select USB-Drive as install target
  - Open custom install settings
    - Select `Install Clover for UEFI`
    - Select Drivers64UEFI
  - Install

##### c) Post Install

- Copy `EFI/BOOT/BOOTX64.efi` to USB-Drive root and rename it to `SHELLX64.efi`
- Copy kexts from folder `Other` to `EFI/CLOVER/kexts/Other/`
- Add clover boot args: `-v npci=0x2000 nv_disable=1`
  - Depending on graphics card add boot arg `-no_compat_check`
- As SMBIOS select `iMac17.1`

Note:
- Adding `apfs.efi` or `ApfsDriverLoader-64` to `EFI/CLOVER/drivers64UEFI/` causes Clover to hang on load, so use HFS+ filesystem
- Adding `HFSPlus-64` to `EFI/CLOVER/drivers64UEFI/` causes Clover to hang on load, use `VBoxHfs-64` instead

---

#### 2. Create OS X USB-Drive

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

#### 3. Install OS X

- Connect target HDD, Mojave USB drive and Clover USB drive to your target machine
- Boot from Clover USB drive and select Mojave USB drive (`Install OS X Mojave`)
- The installation should start automatically (dont worry about reboot after one minute)

---

#### 4. Install Clover in EFI partition of OS X HDD

- After successfully install repeat steps 1b - 1c but with EFI on Mojave HDD as target

---

#### 5. Post Install

##### nVidia WebDriver (only for nVidia GPU)

- Install latest nVidia WebDrivers using [nVidia Update](https://github.com/Benjamin-Dobell/nvidia-update)

  ```sh
  bash <(curl -s https://raw.githubusercontent.com/Benjamin-Dobell/nvidia-update/master/nvidia-update.sh)
  ```

- Open config.plist in clover configurator
  - In section `Boot` remove `nv_disable=1` and add `nvda_drv=1` as boot args
  - In section `System Parameters` check `Injext System ID` and `NvidiaWeb`
- Save config.plist

---

### Troubleshooting

- On `Error loading kernel cache` reboot

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

### DSDT

This Hackintosh works completely without DSDT.

---

### Kexts

#### Kext Patch: [acidanthera/Lilu](https://github.com/acidanthera/Lilu/releases)

- Lilu.kext

#### WiFi: [RehabMan/OS-X-Fake-PCI-ID](https://bitbucket.org/RehabMan/os-x-fake-pci-id/downloads/)

- FakePCIID.kext
- FakePCIID_Broadcom_WiFi.kext

#### Bluetooth: [RehabMan/OS-X-BrcmPatchRAM](https://bitbucket.org/RehabMan/os-x-brcmpatchram/downloads/)

- BrcmFirmwareRepo.kext
- BrcmPatchRAM2.kext

#### Sensors: [RehabMan/OS-X-FakeSMC-kozlek](https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/)

- FakeSMC.kext
- FakeSMC_ACPISensors.kext
- FakeSMC_CPUSensors.kext
- FakeSMC_GPUSensors.kext
- FakeSMC_LPCSensors.kext
- FakeSMC_SMMSensors.kext

#### CPU: [tonymacx86/NullCPUPowerManagement](https://www.tonymacx86.com/resources/nullcpupowermanagement.268/)

- NullCPUPowerManagement.kext

#### Audio: [SourceForge/VoodooHDA](https://sourceforge.net/projects/voodoohda/)

- VoodooHDA.kext

#### Ethernet: [RehabMan/OS-X-Intel-Network](https://bitbucket.org/RehabMan/os-x-intel-network/downloads/)

- IntelMausiEthernet.kext

#### Graphics: [acidanthera/WhateverGreen](https://github.com/acidanthera/WhateverGreen)

- WhateverGreen.kext

#### USB: [RehabMan/OS-X-Generic-USB3](https://bitbucket.org/RehabMan/os-x-generic-usb3/downloads/)

- GenericUSBXHCI.kext

#### SATA: [Fabio1971/AHCIPortInjector.kext](https://www.insanelymac.com/forum/files/file/436-ahciportinjectorkext/)

- AHCIPortInjector.kext

#### JPG-Preview: [vulgo/NoVPAJpeg](https://github.com/vulgo/NoVPAJpeg/releases)

- NoVPAJpeg.kext

---

### Tools

- Clover Configurator: [Link](http://mackie100projects.altervista.org/download-clover-configurator/)
- Kext Utility: [Link](http://cvad-mac.narod.ru/index/0-4)