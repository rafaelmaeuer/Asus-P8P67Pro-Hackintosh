## ASUS P8P67 Pro

### Info

#### Common Problems in 10.13 High Sierra:
https://www.tonymacx86.com/threads/readme-common-problems-in-10-13-high-sierra.233582/

### Install High Sierra

#### 1. Make Clover USB-Stick

##### a) Preparation
- Format USB-Stick with GUID and HFS+
	- Find the correct disk number of USB-Stick:
	```
	diskutil list
	```
	- Replace {#} with corresponding disk number and {Volume} with desired Name:
	```
	diskutil partitionDisk /dev/disk{#} 1 GPT HFS+ {Volume} R
	```
- Download Clover: https://sourceforge.net/projects/cloverefiboot/

##### b) Clover Install
https://clover-wiki.zetam.org/Installation
- Install Clover r4497
	- Select USB-Stick as install target
	- Open custom install settings
		- Select `Install Clover for UEFI`
    	- Select Drivers64UEFI
	- Install

##### c) Post Install
- Copy `EFI/BOOT/BOOTX64.efi` to USB-Stick root and rename it to `SHELLX64.efi`
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

#### 2. Make High Sierra USB-Stick
TBD

#### 3. Install Clover in EFI partition on High Sierra
- Repeat steps 1b - 1c but with High Sierra disk as target


### Update High Sierra
- Make a full backup
- Check https://hackintosher.com/guides/ for the latest OS X Update Guide
- Check all kexts for updates
- Make a new Clover USB-Stick for testing purpose
	- Use updated kexts and drivers in post install (apfs.efi and lilu.kext)
- Boot from new Clover USB-Stick
- If system boots
	- Mount High Sierra EFI partition
	- Backup `EFI` to `EFI-Backups`
	- Install new Clover version to EFI partition
	- Copy updated kexts and drivers during post install
	- Don't forget to copy `Microsoft` folder (it contains the windows bootloader)
- Eject USB-Stick and reboot
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

#### Download Clover Configurator:
http://mackie100projects.altervista.org/download-clover-configurator/

#### Download Kext Utility:
http://cvad-mac.narod.ru/index/0-4


### SSDT
Generate your SSDT with ssdtPRGen https://github.com/Piker-Alpha/ssdtPRGen.sh
TBD

### Kexts

#### AzureWave Broadcom BCM94352HMB/BCM94352 WLAN+BT4.0 macOS Sierra 10.12.1:
http://forum.osxlatitude.com/index.php?/topic/9414-azurewave-broadcom-bcm94352hmbbcm94352-wlanbt40-macos-sierra-10121/

#### WiFi:
Copy latest LiLu.kext (requires v1.2.0) to EFI/CLOVER/kexts/other:
https://github.com/vit9696/Lilu/releases

Copy AirportBrcmFixup.kext to kexts folder:
https://sourceforge.net/projects/airportbrcmfixup/files/

Add following entries to EFI/CLOVER/config.plist:
- ACPI > Fixes > AddDTGP
- ACPI > Fixes > FixAirport
- Devices > Fake ID > WIFI =  0x43a014E4

#### Bluetooth:
Copy BrcmFirmwareRepo.kext and BrcmPatchRAM2.kext to EFI/CLOVER/kexts/other:
http://forum.osxlatitude.com/index.php?app=core&module=attach&section=attach&attach_id=12117


### Kext Ressources:

Broadcom BCM4352 802.11 ac wifi and bluetooth combo card
http://forum.osxlatitude.com/index.php?/topic/2767-broadcom-bcm4352-80211-ac-wifi-and-bluetooth-combo-card/

FakeSMC
https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/

NullCPUPowerManagement.kext
https://www.tonymacx86.com/resources/nullcpupowermanagement.268/

VoodooHDA + AppleHDADisabler
https://sourceforge.net/projects/voodoohda/files/
https://www.hackintosh.zone/file/1023-voodoohda-290d10/

KextToPatch Einträge für High Sierra:
https://www.hackintosh-forum.de/index.php/Thread/28676-Neue-Clover-KextsToPatch-Eintr%C3%A4ge-f%C3%BCr-Sierra-High-Sierra/