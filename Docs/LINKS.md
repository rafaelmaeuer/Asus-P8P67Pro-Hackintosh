# Links for P8P67 Hackintosh

Documentation of Links used while creating ASUS P8P67 PRE/EVO Hackintosh.

## OpenCore Default Boot

- [How to change default boot option for OpenCore](https://www.reddit.com/r/hackintosh/comments/dze9kw/how_to_change_default_boot_option_for_opencore/)

## OpenCore Disabling SIP

SIP or more properly known as System Integrity Protection, is a security technology that attempts to prevent any malicious software and the end user from damaging the OS. You can choose different values to enable or disable certain flags of SIP in [OpenCore-Install-Guide](https://dortania.github.io/OpenCore-Install-Guide/troubleshooting/extended/post-issues.html#disabling-sip).

## Nec Renesas uPD720200

The internal USB3.0 could be activated with `GenericUSBXHCI.kext` prior macOS Big Sur. But it caused unwanted restarts as an unwanted side effect.

- [RehabMan/GenericUSBXHCI.kext](https://bitbucket.org/RehabMan/os-x-generic-usb3/downloads/)
- [How to get Nec Renesas uPD720200 USB3.0 to work?](https://www.insanelymac.com/forum/topic/308452-how-to-get-nec-renesas-upd720200-usb30-to-work/)
- [NEC/Renesas uPD720200A USB3.0 XHCI controller support](https://www.tonymacx86.com/threads/nec-renesas-upd720200a-usb3-0-xhci-controller-support.233130/)

## Realtek RTL8110SC/8169SC

The second ethernet controller is a Realtek RTL8110SC/8169SC which can probably be activated by `AppleRTL8169Ethernet.kext`, but not `RealtekRTL8111.kext` (check the links).

- [Is RTL-8110SC/8169SC supported?](https://github.com/Mieze/RTL8111_driver_for_OS_X/issues/64)
- [Is RTL-8110 working with RealtekRTL8111.kext?](https://github.com/Qraxin/Asus-P8P67-OpenCore-EFI/issues/3)
- [RTL8169 worked on 10.13.2 perfect!](https://www.tonymacx86.com/threads/rtl8169-worked-on-10-13-2-perfect.267556/)
- [Driver for Realtek's RTL810x Fast Ethernet Series](https://www.insanelymac.com/forum/topic/296190-driver-for-realteks-rtl810x-fast-ethernet-series/)
