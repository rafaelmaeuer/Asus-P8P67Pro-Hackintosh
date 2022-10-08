# Changelog P8P67 Hackintosh

## macOS Monterey

## [4.2.0] - 2022-10-08

- chore: update macOS to `v12.6`
- chore: update open-core to `v0.8.5`
- chore: update kexts and tools

## [4.1.0] - 2022-08-27

- chore: update macOS to `v12.5.1`
- chore: update open-core to `v0.8.3`
- fix: remove SSDT-PM, drop cpu-tables
- fix: country code for brcm-wifi
- fix: gpu display name

## [4.0.0] - 2022-08-05

- update macOS to `v12.5`
- update OpenCore to `v0.8.2`
- add dual-boot for win 11
- update kexts and tools
- update readme and docs

---

## macOS Big Sur

## [3.3.0] - 2021-10-18

- update macOS to `v11.6`
- update OpenCore to `v0.7.4`
- update kexts and tools

## [3.2.0] - 2021-07-14

- update macOS to `v11.4`
- update OpenCore to `v0.7.1`
- add audio fixes
- add Fenvi Wifi/BT-Card
- fix Distorted Boot-Theme
- update kexts and tools

## [3.1.2] - 2021-04-04

- enable Intel VT-d with OpenCore

## [3.1.1] - 2021-03-18

- update macOS to `v11.2.3`
- update OpenCore to `v0.6.7`
- update Realtek kext
- add RTL8169Tiger driver
- remove pci entries (fix sleep)
- update kexts

## [3.1.0] - 2021-02-26

- update macOS to `v11.2`
- update OpenCore to `v0.6.6`
- update config.plist
- add pci devices
- update ACPI patches
- update kexts and tools

## [3.0.1] - 2021-02-01

- update config.plist
- remove memcheck.efi
- generate new SSDT

## [3.0.0] - 2021-01-27

- update macOS to `v11.1`
- use OpenCore as boot-loader
- prevent SMBIOS on other OSes
- increase boot timeout

---

## macOS Catalina

## [2.4.0] - 2020-09-12

- update macOS to `v10.15.6`
- update clover to `r5122`

## [2.3.2] - 2020-07-02

- update clover to `r5119`
- add AppleALC as audio driver
- update kexts and tools

## [2.3.1] - 2020-06-09

- add GPRW SSDT patch (fix wake by usb)
- revert BT-usb from type 255 to 0

## [2.3.0] - 2020-06-04

- update macOS to `v10.15.5`
- update clover to `r5118`
- add properties for BCM94352Z wifi card
- update kexts and tools

## [2.2.2] - 2020-05-11

- add Intel Power Gadget
- add USB port mapping
- add ACPI patches and -dump
- add SSDT PlatformPlugin
- switch from FakePCIID to AirportBrcmFixup
- disable usb rename patches
- update kexts

## [2.2.1] - 2020-04-03

- add USBInjectAll to disabled kexts
- remove AirportBrcmFixup kext
- add FakePCIID kext
- add FakePCIID_Broadcom_Wifi kext

## [2.2.0] - 2020-04-02

- update macOS to `v10.15.4`
- add Catalina4k theme
- enable HiDPI boot in clover
- disable FakePCIID.kext
- disable AirportBrcmFixup.kext
- disable USBPorts.kext
- remove SSDT-UIAC.aml

## [2.1.0] - 2020-03-26

- update macOS to `v10.15.3`
- remove DSDT.aml
- update kexts

## [2.0.3] - 2020-02-07

- update AirportBrcmFixup.kext

## [2.0.2] - 2020-01-25

- add USB patch
- update microsoft folder
- update kexts

## [2.0.1] - 2020-01-21
  
- add roms for bios
- update BrcmPatchRam.kext

## [2.0.0] - 2020-01-13

- update macOS to `v10.15.2`
- update clover to `r5103`
- update EFI and kexts
- add clover boot themes

---

## macOS Mojave

## [1.2.1] - 2019-11-09

- install security update 2019-001
- update kexts

## [1.2.0] - 2019-09-06

- update macOS to `10.14.6`
- update clover to `2.5k r5058`
- update kexts and tools

## [1.1.0] - 2019-06-17

- update macOS to `10.14.5`
- update clover to `2.4k r4961`
- update tools

## [1.0.5] - 2019-01-30

- use OsxAptioFix2Drv
- add mojave boot theme

## [1.0.4] - 2019-01-18

- disable integrated USB3
- remove GenericUSBXHCI.kext

## [1.0.3] - 2018-12-14

- add NoVPAJpeg.kext
- add AHCIPortInjector.kext

## [1.0.2] - 2018-11-06

- remove FacePCIID_XHCIMux.kext
- remove USBInjectAll.kext
- add GenericUSBXHCI.kext
- update usb port patch
- update FacePCIID.kext

## [1.0.1] - 2018-11-01

- move from geforce to radeon
- update kexts

## [1.0.0] - 2018-10-19
  
- update macOS to `10.14`
- update clover to `2.4k r4674`
- remove high sierra boot theme
- update EFI and kexts
- add 14MBRinstallerMaker for HFS+
- remove nVidia web driver
- add WhateverGreen kext

---

## macOS High Sierra

## [0.0.5] - 2018-09-12

- fix restart after shutdown

## [0.0.4] - 2018-08-13

- update BrcmPatchRAM2.kext
- remove BrcmFirmwareRepo.kext
- add BrcmFirmwareData.kext

## [0.0.3] - 2018-07-29

- update clover boot menu

## [0.0.2] - 2018-07-18

- add FakeSMC kexts
- add nvidia web driver boot flag
- add microsoft folder for windows boot

## [0.0.1] - 2018-06-14

- install macOS to `10.13`
- install clover to `2.4k r4509`
- add high sierra boot theme
- add kexts and tools
