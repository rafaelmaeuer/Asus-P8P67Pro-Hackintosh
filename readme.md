## ASUS P8P67 Pro

### Info

#### Common Problems in 10.13 High Sierra: [tonymacx86.com](https://www.tonymacx86.com/threads/readme-common-problems-in-10-13-high-sierra.233582/)

### Install High Sierra

#### 1. Make Clover USB-Drive

##### a) Preparation
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

##### b) Clover Install [clover-wiki](https://clover-wiki.zetam.org/Installation)
- Install Clover r4497
	- Select USB-Drive as install target
	- Open custom install settings
		- Select `Install Clover for UEFI`
    	- Select Drivers64UEFI
	- Install

##### c) Post Install
- Copy `EFI/BOOT/BOOTX64.efi` to USB-Drive root and rename it to `SHELLX64.efi`
- Copy kexts from folder `Other` to `EFI/CLOVER/kexts/Other/`
- add Clover boot args: `-v npci=0x2000`
- On `Error loading kernel cache (0x9)` reboot

- Install NVIDIA WebDriver-387.10.10.10.30.106.pkg
- add following to config.plist
	```
	<key>SystemParameters</key>
    <dict>
        <key>InjectKexts</key>
        <string>YES</string>
        <key>InjectSystemID</key>
        <true/>
        <key>NvidiaWeb</key>
        <true/>
    </dict>
    ```

- Adding apfs.efi to `EFI/CLOVER/drivers64UEFI/` causes Clover to hang on load

#### 2. Make High Sierra USB-Drive
To create a functioning macOS High Sierra installer boot drive, you will need the following:
- A free USB flash drive (minimum 8GB)
- A device already running OS X with access to the App Store

##### a) Download Installer
- Open the Mac App Store on your device already running OS X
- Download `Install macOS High Sierra` application
- Close when it opens automatically

##### b) Format USB drive
- Insert USB flash drive
- Open Disk Utility and format flash drive
	- Select `GUID` as partition scheme 
	- Select `Mac OS Extended (Journaled)` as file format

##### c) Create Installer
Use [DiskMaker X](http://diskmakerx.com/), [Install Disk Creator](https://macdaddy.io/install-disk-creator/) or do it manually:
- Open a terminal
- Enter the following command (replace {NAME} with your flash drive's name)
	```
	sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/{NAME}/ --applicationpath /Applications/Install\ macOS\ High\ Sierra.app/ --nointeraction
	```
- Enter your user password (digits will not be shown) and hit return
- This step can take up to 30 minutes
- The process is complete when `done` is displayed

#### 3. Install Clover in EFI partition on High Sierra
- Repeat steps 1b - 1c but with High Sierra disk as target


### Update High Sierra
- Make a full backup
- Check [hackintosher.com](https://hackintosher.com/guides/) for the latest OS X Update Guide
- Check all kexts for updates
- Make a new Clover USB-Drive for testing purpose
	- Use updated kexts and drivers in post install (apfs.efi and lilu.kext)
- Boot from new Clover USB-Drive
- If system boots
	- Mount High Sierra EFI partition
	- Backup `EFI` to `EFI-Backups`
	- Install new Clover version to EFI partition
	- Copy updated kexts and drivers during post install
	- Don't forget to copy `Microsoft` folder (it contains the windows bootloader)
- Eject USB-Drive and reboot
- If system boots
	- Start High Sierra Update
	- On restart select newly added `Install OS X ...` partition
	- Disable all BCRM kexts to prevent loop at the end of boot
	- After reboot select normal High Sierra partition
- If system boots
	- Be happy and enjoy the new update
- If system doesn't boot on one of these steps 
	- Try to fix the problem or revert to the latest backup

### Post Install

#### Download Clover Configurator: [Link](http://mackie100projects.altervista.org/download-clover-configurator/)

#### Download Kext Utility: [Link](http://cvad-mac.narod.ru/index/0-4)


### SSDT
Generate your SSDT with ssdtPRGen: [github.com/Piker-Alpha](https://github.com/Piker-Alpha/ssdtPRGen.sh)
<br>*TBD*

### Kexts

#### AzureWave Broadcom BCM94352HMB/BCM94352 WLAN+BT4.0 macOS Sierra 10.12.1: [forum.osxlatitude.com](http://forum.osxlatitude.com/index.php?/topic/9414-azurewave-broadcom-bcm94352hmbbcm94352-wlanbt40-macos-sierra-10121/)

#### WiFi:
Copy latest LiLu.kext (requires v1.2.0) to EFI/CLOVER/kexts/other: [github.com/vit9696](https://github.com/vit9696/Lilu/releases)

Copy AirportBrcmFixup.kext to kexts folder: [sourceforge.net](https://sourceforge.net/projects/airportbrcmfixup/files/)

Add following entries to EFI/CLOVER/config.plist:
- ACPI > Fixes > AddDTGP
- ACPI > Fixes > FixAirport
- Devices > Fake ID > WIFI =  0x43a014E4

#### Bluetooth:
Copy BrcmFirmwareRepo.kext and BrcmPatchRAM2.kext to EFI/CLOVER/kexts/other: [forum.osxlatitude.com](http://forum.osxlatitude.com/index.php?app=core&module=attach&section=attach&attach_id=12117)


### Kext Ressources:

Broadcom BCM4352 802.11 ac wifi and bluetooth combo card: [forum.osxlatitude.com](http://forum.osxlatitude.com/index.php?/topic/2767-broadcom-bcm4352-80211-ac-wifi-and-bluetooth-combo-card/)

FakeSMC: [bitbucket.org/RehabMan](https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/)

NullCPUPowerManagement.kext: [tonymacx86.com](https://www.tonymacx86.com/resources/nullcpupowermanagement.268/)

VoodooHDA + AppleHDADisabler: [sourceforge.net](https://sourceforge.net/projects/voodoohda/files/), [hackintosh.zone](https://www.hackintosh.zone/file/1023-voodoohda-290d10/)

KextToPatch Einträge für High Sierra: [hackintosh-forum.de](https://www.hackintosh-forum.de/index.php/Thread/28676-Neue-Clover-KextsToPatch-Eintr%C3%A4ge-f%C3%BCr-Sierra-High-Sierra/)