# Sleep with P8P67

List of known wake/sleep related issues and possible solutions or fixes.

## Power-Nap

To disable Power Nap, uncheck `Activate Power Nap` in System Settings -> Energy Saving and disable WakeUp for Maintenance with:

```sh
sudo pmset -a ttyskeepawake 0
```

## Wake by Bluetooth

The internal USB2-ports share the same hub and are used for I/O-Panel and Bluetooth connectors. [Fixing Sleep Preparations](https://dortania.github.io/OpenCore-Post-Install/universal/sleep.html#preparations) prevent the system to completely power off when going to sleep:

```sh
sudo pmset autopoweroff 0
sudo pmset powernap 0
sudo pmset standby 0
sudo pmset proximitywake 0
sudo pmset tcpkeepalive 0
```

**Fix after Wake**

It seems that with Monterey there are [issues](https://github.com/acidanthera/bugtracker/issues/1821) with Bluetooth. You can try to enable the `ExtendBTFeatureFlags` Quirk or reset Bluetooth after wake using [SleepWatcher](https://gist.github.com/ralph089/a65840c4f5e439b90170d735a89a863f), [BetterTouchTool](https://www.tonymacx86.com/threads/bluetooth-doesnt-work-after-wake-on-monterey.315679/page-5#post-2308355) or [Shortery](https://www.tonymacx86.com/threads/bluetooth-doesnt-work-after-wake-on-monterey.315679/page-6#post-2308688).

As Disable/Enable BT with `BetterTouchTool` and `SleepWatcher` only work in one of both cases, the following combination is used to fix BT after sleep:

- Disable BT before sleep with [BetterTouchTool](https://www.tonymacx86.com/threads/bluetooth-doesnt-work-after-wake-on-monterey.315679/page-5#post-2308355)
- Enable BT after wake with [SleepWatcher](https://gist.github.com/rafaelmaeuer/57dcdbdde509942bc04b2f84783a23af) script
