# Troubleshooting P8P67

Tips and tricks to solve already known problems

When [adding SSDTs, Kexts and Firmware Drivers](https://dortania.github.io/OpenCore-Install-Guide/config.plist/#adding-your-ssdts-kexts-and-firmware-drivers) to the EFI folder, use [OpenCore Configurator](https://mackie100projects.altervista.org/opencore-configurator/) as GUI or [corpnewt/ProperTree](https://github.com/corpnewt/ProperTree) when needing an universal plist-editor.

## Add kexts

To manually add kexts:

- Copy `{name}.kext` into `EFI/OC/Kexts`
- Open `config.plist` in OpenCore Configurator
- Add new files with `Kernel` -> `Scan/Browse`
  - Select `EFI/OC/Kexts` folder
  - Add a meaningful `Comment` to kext
  - (Optional: set `MinKernel` and `MaxKernel`)

## Add ACPI patches

To manually add ACPI patches:

- Copy `{name}.aml` into `EFI/OC/ACPI`
- Open `config.plist` in OpenCore Configurator
- Add new files with `ACPI` -> `Scan/Browse`
  - Select `EFI/OC/ACPI` folder
  - Add a meaningful `Comment` to SSDT

## Reset NVRAM

In OpenCore Configurator go to `Misc` -> `Boot` and uncheck the option `HideAuxiliary`.

- On reboot select `Reset NVRAM` from OpenCanopy boot-options

## Default Boot Option

In OpenCore Configurator go to `Misc` -> `Security` and check the option `AllowSetDefault`.

- In OpenCanopy boot picker set default boot-option with `ctrl + enter`

## Add Boot Entry

As the P8P67 bios offers no option to simply add new boot entries, [EasyUEFI](https://www.easyuefi.com/index-us.html) from a parallel windows installation is used to create OpenCore boot entry

- Follow this guide [Manually install Clover for UEFI booting and configure boot priority with EasyUEFI in Windows](https://www.insanelymac.com/forum/topic/310038-manually-install-clover-and-configure-boot-priority-with-easyuefi-in-windows/) and use `EFI/BOOT/BOOTx64.efi` as file path

## Boot Resolution

The display resolution during boot is very low, full display resolution (4K) is only reached on the last boot stage

- Default options `TextRenderer` set to `BuiltinGraphics` and `Resolution` set to `Max` ([macos-decluttering](https://dortania.github.io/OpenCore-Post-Install/cosmetic/verbose.html#macos-decluttering)) deliver best results (1280x800 or similar)
- Custom options like `TextRenderer` set to `SystemGraphics` and `Resolution` set to `3840x2160` deliver worse results (1024x768 fallback)
- Setting `UIScale` to `02` (HiDPI-Mode) only increases the icon size
- Switching the BIOS settings from `Legacy ROM` to `UEFI ROM` has no improvement as suggested [here](https://www.reddit.com/r/hackintosh/comments/i8pc8t/gui_bootscreen_resolution_with_opencanopy_efi/), [there](https://www.reddit.com/r/hackintosh/comments/j9wyu7/stretched_opencore_boot_picker_and_apple_logo/) or [over there](https://www.reddit.com/r/hackintosh/comments/j3eab5/opencore_boot_menu_low_resolution_on_ultrawide/)
  - 🚨 Warning 🚨 ASUS RX570 doesn't work with `UEFI ROM` settings (black screen -> needs CMOS-reset), although latest official [firmware](https://www.techpowerup.com/vgabios/191598/asus-rx570-4096-170327) has UEFI-support
  - GeForce GTX 760 works with `UEFI ROM` BIOS-settings, but doesn't improve resolution during boot. The latest official [firmware](https://www.techpowerup.com/vgabios/162810/msi-gtx760-2048-140306) also has UEFI-support
- The problem might be related with [CSM](https://superuser.com/questions/1284392/what-exactly-is-uefi-with-csm-boot-mode) or [GOP](https://wiki.osdev.org/GOP) for graphic cards

## Boot Theme

As the best possible boot resolution with 1280x800 has a width distortion of 1.28 (1024/800) a custom boot theme is used with inverse distorted images to compensate. Modify Images:

- Open `.icns` file with apple preview
- Drag and Drop `.tiff` images to folder
- Resize Image width to 78,125% (1024/800)
- Resize Image area to original width
- Save Images as .png
- Create `.icns` image bundle
  ```sh
  cd /OpenCore/Utilities/icnspack/
  ./icnspack image.icns image.png image@2x.png
  ```
- Replace original image bundle

## AHCI Ports

Information copied from [SATA Drives Not Shown in DiskUtility](https://www.olarila.com/topic/9616-error-while-installing-big-sur/?do=findComment&comment=117695)

- Make sure SATA Mode is AHCI in bios
- Certain SATA controllers may not be officially supported by macOS, for these cases you'll want to grab [CtlnaAHCIPort.kext](https://github.com/dortania/OpenCore-Install-Guide/blob/master/extra-files/CtlnaAHCIPort.kext.zip)
  - For very legacy SATA controllers, [AHCIPortInjector.kext](https://www.insanelymac.com/forum/files/file/436-ahciportinjectorkext/) may be more suitable

## Apple Watch Unlock

If unlock with Apple Watch doesn't work or make problems although using a `BCM94360CD Fenvi` card, follow the steps of this blogpost comment: [watchOS 7 Beta 5 - unlock mac doesn't work](https://forums.macrumors.com/threads/watchos-7-beta-5-unlock-mac-doesnt-work.2250819/page-2?post=28904426#post-28904426). Afterwards unlock with Apple Watch works like it should with a regular Mac.
