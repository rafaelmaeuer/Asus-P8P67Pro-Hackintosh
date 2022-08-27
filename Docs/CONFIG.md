# Advanced Config P8P67

The following configurations are not essential for the Hackintosh to work, but they improve functionality to get as close to a real Mac as possible.

## Power Management

As power management is only working properly after wake from sleep, the following method isn't used any longer. Instead, no PM-SSDT is loaded and `CpuPm` and `Cpu0Ist` tables are dropped on boot (runs in high frequency mode).

**Old method**

*Note: will only work after wake from sleep, only kept for historical reasons*

As `iMac12,2` is the closest SMBIOS to P8P67 mainboards ([link](https://dortania.github.io/OpenCore-Install-Guide/config.plist/sandy-bridge.html#platforminfo)), it is used to generate SSDT for power-management. As `SSDT-PLUG` is only compatible with Intel's Haswell and newer CPUs ([link](https://dortania.github.io/Getting-Started-With-ACPI/Universal/plug.html)), Sandy Bridge needs to follow the [ssdtPRgen](https://dortania.github.io/OpenCore-Post-Install/universal/pm.html#sandy-and-ivy-bridge-power-management) method.

- OpenCore Configurator Paths
  - Drop ACPI: `ACPI` -> `Delete`
  - SMBIOS: `PlatformInfo` -> `SMBIOS` -> `Button Up/Down`
  - Boot-Args: `NVRAM` -> `UUID` -> `7C4...F82` -> `boot-args`

1. Select SMBIOS `iMac12,2` (CPU: Sandy Bridge i7 2600)
   - Add `-no_compat_check` boot-flag
   - Drop `CpuPm` and `Cpu0Ist` tables
   - Reboot with new SMBIOS

2. Use [ssdtPRGen.sh](https://github.com/Piker-Alpha/ssdtPRGen.sh) from [Tools](../Tools) folder to generate `SSDTs`
   - [Ignore](https://github.com/Piker-Alpha/ssdtPRGen.sh/issues/183#issuecomment-171089689) warning about improperly 'cpu-type' ([0x0703](https://docs.google.com/spreadsheets/d/1x09b5-DGh8ozNwN5ZjAi7TMnOp4TDm6DbmrKu86i_bQ/edit#gid=0&range=D18) instead of 0x0603)
   - Output folder: `~/Library/ssdtPRGen/`
   - Rename `SSDT.aml` to `SSDT-PM.aml`
   - Add to `EFI/OC/ACPI` and `config.plist`

3. Change SMBIOS to `iMac18,3` (GPU: Radeon Pro 570)
   - Set `ProzessorType` to `1795` (decimal for 0x0703)
   - Remove `-no_compat_check` boot-flag
   - Remove drop of `CpuPm` and `Cpu0Ist` tables
   - Reboot with new SMBIOS

## USB Mapping

An USB port-mapping can be created with [OpenCore Post-Install - USB Mapping](https://dortania.github.io/OpenCore-Post-Install/usb/intel-mapping/intel.html) guide and [corpnewt/USBMap](https://github.com/corpnewt/USBMap) tool.

- Use Back-Panel USB2-Ports or BT for Mouse and Keyboard
- Boot with `USBInjectAll.kext` and &#9745; `XhciPortLimit` enabled
- Run `USBmap.command` and test all ports with USB2/3 Devices
- Give each port a unique name like e.g. `USB3.0(HS) Back Left`
- After discovery and naming set the correct port-types
  - USB2: 0
  - USB3: 3
  - USB-C: 9
  - Internal: 255
- Export `USBMap.kext` and add it to EFI and OpenCore
- Disable `XhciPortLimit` and remove `USBInjectAll.kext`

The following generated files can be found in [USB](../USB) folder:

| Path         | File        | Description           |
| ------------ | ----------- | --------------------- |
| USB/Results/ | USBMap.kext | USB port-mapping kext |
| USB/Scripts/ | USB.plist   | USB port-naming list  |
