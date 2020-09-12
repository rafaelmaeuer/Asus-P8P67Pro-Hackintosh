## ASUS P8P67 PRO/EVO (REV3.0)

### Info

Guide how to install macOS Catalina on ASUS P8P67 PRO/EVO (REV3.0)

- macOS version: 10.15.6
- clover version: r5122

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
      - EHCI Hand-off: Enabled
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

This Hackintosh was created on an ASUS P8P67 PRO Mainboard with an Intel Core i7 2600K Processor and 16GB RAM. It is running now on an ASUS P8P67 EVO Mainboard. A GeForce GTX 760 and Radeon RX 570 graphics card have been working with different display setups.

#### Graphics

Radeon RX 570 was used with two 4K Monitors on DP and HDMI, DVI makes problems.  
GeForce GTX 760 was used with two Displays on DVI, no 4K on HDMI possible (v1.4a).

##### WIFI

To get WiFi running, a [ASUS PCE-AC55BT B1 PCI-E](https://www.asus.com/Networking/PCE-AC55BT-B1/) card is used as adapter with a [BroadCom BCM4352 BCM94352Z NGFF M.2](https://deviwiki.com/wiki/Broadcom_BCM94352Z) card as chip.

##### Bluetooth

The onboard Bluetooth is disabled. The Bluetooth of the Broadcom BCM94352Z causes unwanted wake from sleep, therefore a SSDT-GPRW patch is used. Alternatively a [Plugable Bluetooth 4 USB Adapter](https://plugable.com/products/usb-bt4le/) can be used (works ootb).

##### SATA

For eSATA and RAID a [DIGITUS SATA PCI-E](https://www.digitus.info/de/produkte/computer-zubehoer-und-komponenten/computer-zubehoer/io-karten/ds-30104-1/) card is used as the MARVELL 88SE9230 chip can be activated with the AHCIPortInjector.

##### USB

USB2 works ootb but a port mapping was created in the attempt of avoiding unwanted wake from sleep which is caused by the internal USB-connector of the BT-card. As the most promising solution (setting the USB-connector type to internal/255) is not working (BT isn't recognized anymore), the current solution is a [SSDT-GPRW](https://dortania.github.io/USB-Map-Guide/misc/instant-wake.html) patch which disables wake by usb completely.

##### USB3

For USB3 an [Inateck KT4006 PCI-E](https://www.inateck.com/inateck-kt4006-dual-port-usb-3-0-pci-express-card-20-pin-connector-no-power-connection.html) card is used which works ootb. The internal Renesas USB3 chip can be activated using GenericUSBXHCI.kext, but it causes a problem on shutdown (unwanted restart).

---

### Install macOS

#### 1. Create Clover Drive

##### a) Preparation

- Format USB-Drive with GUID and HFS+

  - Find the correct disk number of USB-Drive:

        diskutil list

  - Replace {#} with corresponding disk number and {Volume} with desired Name:

        diskutil partitionDisk /dev/disk{#} 1 GPT HFS+ {Volume} R

- Download Clover: [github.com/CloverHackyColor](https://github.com/CloverHackyColor/CloverBootloader/releases)

##### b) Install Clover [clover-wiki](https://clover-wiki.zetam.org/Installation)

- Follow this guide [Create a MacOS Catalina 10.15.0 USB Installer Drive w/Clover](https://hackintosher.com/forums/thread/guide-how-to-create-a-macos-catalina-10-15-0-usb-installer-drive-w-clover.2836/) Section `IV. Install Clover Bootloader into the USB Installer Flash Drive's EFI Boot Partition`

##### c) Post Install

- Copy `EFI/BOOT/BOOTX64.efi` to USB-Drive root and name it `SHELLX64.efi`
- Copy all ACPI patches from/to `EFI/CLOVER/ACPI/patched/`
- Copy `config.plist` from/to `EFI/CLOVER/config.plist` (backup original first)
- Copy all kexts from/to `EFI/CLOVER/kexts/Other/`
  - Delete all 10.X folders in `EFI/CLOVER/kexts/`
- (Optional: Copy favorite Clover theme to `EFI/CLOVER/themes`)

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

### ACPI

- SSDT-GPRW.aml disables wake from sleep for usb devices
- SSDT-EC.aml is necessary to boot since macOS Catalina
- SSDT-PLUG.aml is used for advanced power management

---

### USB-Mapping

- USBPorts.kext does the correct port-mapping
- SSDT-EC-USBX.aml applies patches for EC and USBX

---

### Clover Configuration

- Use `iMac17.1` as SMBIOS

#### Fix boot Error

- Add clover boot arg `npci=0x2000` to pass `PCI Configuration Began` Error

#### Fix for Nvidia GPUs

Since OS X Mojave GPUs without Metal support need to bypass hardware compatibility check

- Add clover boot arg `-no_compat_check`

#### Config for WiFi

For a correct Broadcom BCM94352Z configuration

- Follow instructions from this [post](https://www.hackintosh-forum.de/forum/thread/37478-dw-1560-broadcom-bcm94352z-mit-ngff-m-2-schnittstelle/)

---

### Kexts

#### Kext Patch: [acidanthera/Lilu](https://github.com/acidanthera/Lilu/releases)

- Lilu.kext

#### Graphics: [acidanthera/WhateverGreen](https://github.com/acidanthera/WhateverGreen)

- WhateverGreen.kext

#### WiFi: [acidanthera/AirportBrcmFixup](https://github.com/acidanthera/AirportBrcmFixup/releases)

- AirportBrcmFixup.kext

#### Bluetooth: [acidanthera/BrcmPatchRAM](https://github.com/acidanthera/BrcmPatchRAM/releases)

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

#### Audio: AppleALC or VoodooHDA

- AppleALC.kext [acidanthera/AppleALC](https://github.com/acidanthera/AppleALC/releases/)
- VoodooHDA.kext [SourceForge/VoodooHDA](https://sourceforge.net/projects/voodoohda/)

#### Ethernet: [RehabMan/OS-X-Intel-Network](https://bitbucket.org/RehabMan/os-x-intel-network/downloads/)

- IntelMausiEthernet.kext

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
- [Hackintool](https://github.com/headkaze/Hackintool/releases/)
