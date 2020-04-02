## ASUS P8P67 PRO/EVO (REV3.0)

### Info

Guide how to install macOS Catalina on ASUS P8P67 PRO/EVO (REV3.0)

- macOS version: 10.15.4
- clover version: 2.5k r5103

---

#### BIOS

- Use version 3602 (get ROM for PRO/EVO Board from [Bios](/Bios) folder)
- Use proper settings
  - AI Tweaker: Auto
  - Advanced
    - SATA
      - Mode Selection: AHCI
      - S.M.A.R.T.: Enabled
    - USB
      - Legacy: Enabled
      - Legacy USB 3.0: Enabled
      - EHCI Hand-off: Disabled
    - Onboard Devices
      - Renesas USB 3.0: Disabled
      - Bluetooth: Disabled
      - VIA 1394: Disabled
      - Marvell Storage: AHCI
      - Serial Port: Disabled
  - Boot
    - PCI ROM: Legacy ROM
    - Option ROM: Force BIOS

#### Hardware

This Hackintosh was created on an ASUS P8P67 PRO Mainboard with an Intel Core i7 2600K Processor and 16GB RAM. It is running now on an ASUS P8P67 EVO Mainboard. A GeForce GTX 760 and Radeon RX 570 graphics card have been working  with different display setups.

#### Graphics

Radeon RX 570 was used with two 4K Monitors on DP and HDMI, DVI makes problems.  
GeForce GTX 760 was used with two Displays on DVI, no 4K on HDMI possible (v1.4a).

##### WIFI

To get WiFi running, a [ASUS PCE-AC55BT B1 PCI-E](https://www.asus.com/Networking/PCE-AC55BT-B1/) card is used as adapter with a [BroadCom BCM4352 BCM94352Z NGFF M.2](https://wikidevi.com/wiki/Broadcom_BCM94352Z) card as chip.

##### Bluetooth

The onboard Bluetooth is disabled. The Bluetooth on the Broadcom BCM94352Z is not connected to the motherboard. Instead a [Plugable Bluetooth 4 USB Adapter](https://plugable.com/products/usb-bt4le/) is used on USB 2.0 port to avoid unwanted sleep termination. It works without any additional driver (until Mojave, in Catalina it only worked during install).

##### SATA

For eSATA and RAID a [DIGITUS SATA PCI-E](https://www.digitus.info/de/produkte/computer-zubehoer-und-komponenten/computer-zubehoer/io-karten/ds-30104-1/) card is used as the MARVELL 88SE9230 chip can be activated with the AHCIPortInjector.

##### USB3

For USB3 an [Inateck KT4006 PCI-E](https://www.inateck.com/inateck-kt4006-dual-port-usb-3-0-pci-express-card-20-pin-connector-no-power-connection.html) card is used. The internal Renesas USB3 chip can be activated using GenericUSBXHCI.kext, but it causes a problem on shutdown (unwanted restart).

---

### Install macOS

#### 1. Create Clover Drive

##### a) Preparation

- Format USB-Drive with GUID and FAT32
  - Find the correct disk number of USB-Drive:

        diskutil list

  - Replace {#} with corresponding disk number and {Volume} with desired Name:

        diskutil partitionDisk /dev/disk{#} 1 GPT FAT32 {Volume} R

- Download Clover: [github.com/CloverHackyColor](https://github.com/CloverHackyColor/CloverBootloader/releases)

##### b) Install Clover [clover-wiki](https://clover-wiki.zetam.org/Installation)

- Follow this guide [Create a MacOS Catalina 10.15.0 USB Installer Drive w/Clover](https://hackintosher.com/forums/thread/guide-how-to-create-a-macos-catalina-10-15-0-usb-installer-drive-w-clover.2836/) Section `IV. Install Clover Bootloader into the USB Installer Flash Drive's EFI Boot Partition`

##### c) Post Install

- Copy `EFI/BOOT/BOOTX64.efi` to USB-Drive root and rename it to `SHELLX64.efi`
- Copy kexts from folder `Other` to `EFI/CLOVER/kexts/Other/`
- Add clover boot args: `npci=0x2000`
  - (Depending on graphics card add boot arg `-no_compat_check`)
- As SMBIOS select `iMac17.1`

---

#### 2. Create macOS Installer Drive

To create a working macOS Installer boot drive, you will need the following:
- An empty USB flash drive (minimum 8GB)
- A device already running macOS with access to the App Store

##### a) Download macOS Installer

- Open the Mac App Store on your device already running macOS
- Download `Install macOS Catalina` application
- Close when it opens automatically

##### b) Create Installer Stick

- Use [DiskMaker X](https://diskmakerx.com/) or [Install Disk Creator](https://macdaddy.io/install-disk-creator/) to create macOS Install Drive

---

#### 3. Install macOS

- Connect Macintosh HD, macOS Installer and Clover Drive to your target machine
- Boot from Clover Drive and select macOS Installer (`Install macOS Catalina`)
- The installation should start automatically (don't worry about reboot after one minute)

---

#### 4. Install Clover in EFI partition of macOS HDD

- After successfully install repeat steps 1b - 1c but with EFI on Macintosh HD as target

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

- On `Error loading kernel cache` reboot (try it out which AptioFix driver suits best for you)

---

### Update macOS

- Make a full backup
- Check [hackintosher.com](https://hackintosher.com/guides/) for the latest macOS Update Guide
- Check all kexts for updates
- Make a new clover Drive for testing purpose
  - Use updated kexts and drivers in post install
- Boot from new Clover Drive
- If system boots
  - Mount EFI partition of Macintosh HD
  - Backup `EFI` to `EFI-Backups`
  - Install new Clover version to EFI partition
  - Copy updated kexts and drivers during post install
  - Don't forget to copy `Microsoft` folder (it contains the windows bootloader)
- Eject Clover Drive and reboot
- If system boots
  - Start macOS Update
  - On restart select newly added `Install macOS Catalina` partition
  - After reboot select normal Macintosh HD partition
- If system boots
  - Be happy and enjoy the new update
- If system doesn't boot on one of these steps
  - Try to fix the problem or revert to the latest backup

---

## Resources

### SSDT

Generate your SSDT with ssdtPRGen: [github.com/Piker-Alpha](https://github.com/Piker-Alpha/ssdtPRGen.sh)  
*TODO*

### DSDT

This Hackintosh works completely without DSDT.

---

### Kexts

#### Kext Patch: [acidanthera/Lilu](https://github.com/acidanthera/Lilu/releases)

- Lilu.kext

#### WiFi: [RehabMan/OS-X-Fake-PCI-ID](https://bitbucket.org/RehabMan/os-x-fake-pci-id/downloads/)

- FakePCIID.kext
- FakePCIID_Broadcom_WiFi.kext

#### Bluetooth (with sleep issue): [acidanthera/BrcmPatchRAM](https://github.com/acidanthera/BrcmPatchRAM/releases)

- BrcmBluetoothInjector.kext
- BrcmFirmwareData.kext
- BrcmPatchRAM3.kext

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

#### SATA: [Fabio1971/AHCIPortInjector.kext](https://www.insanelymac.com/forum/files/file/436-ahciportinjectorkext/)

- AHCIPortInjector.kext

#### JPG-Preview: [vulgo/NoVPAJpeg](https://github.com/vulgo/NoVPAJpeg/releases)

- NoVPAJpeg.kext

---

#### Internal USB3 (with shutdown issue): [RehabMan/OS-X-Generic-USB3](https://bitbucket.org/RehabMan/os-x-generic-usb3/downloads/)

- GenericUSBXHCI.kext

---

### Tools

- [Clover Configurator](http://mackie100projects.altervista.org/download-clover-configurator/)
- [Hackintool](https://www.tonymacx86.com/threads/release-hackintool-v2-8-6.254559/)