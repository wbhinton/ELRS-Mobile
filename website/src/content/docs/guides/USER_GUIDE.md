---
title: User Guide
slug: user_guide
sidebar:
  order: 1
---

ELRS Mobile flashes and configures ExpressLRS receivers (RX) and transmitters (TX) from your phone, over Wi-Fi, with no laptop and no internet connection at the field. It works with ESP-based hardware (ESP8285, ESP32, ESP32-C3, ESP32-S3) and ExpressLRS 3.3.x and 4.x firmware. See [Supported Hardware](/supported_hardware) for every compatible device.

The workflow has two halves: download firmware while you have internet, then flash anywhere.

---

## Installation

| Platform | Where to get it |
| :--- | :--- |
| Android | [Google Play](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile) |
| iPhone and iPad | [App Store](https://apps.apple.com/us/app/elrs-mobile/id6760490014) |
| Android, without Google Play | [Direct APK download](https://cdn.elrsmobile.com/ELRS-Mobile-latest.apk), [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases), or [GitHub Store](https://github.com/OpenHub-Store/Github-Store) |

The store versions update through Google Play and the App Store. The direct-download APK checks for a new release once a day and offers to download it; you can also check any time from **Settings → About & Legal → Check for Updates**, skip a version, or be reminded later. Your settings and profiles are kept when you install an update.

Want new features early? Join the [Google Play beta](https://play.google.com/apps/testing/io.datarx.elrsmobile) or the [TestFlight beta](https://testflight.apple.com/join/jwU1WrpX).

On first launch the app shows a short disclaimer. Flashing firmware always carries some risk to your hardware; accept it to continue.

---

## Quick start: flashing your first device

### Step 1: Download firmware (at home)

1. On the Dashboard, open **Firmware Manager**.
2. Tap the download icon next to the ExpressLRS version you want. Only versions 3.3.0 and newer are listed: they are the first with the unified firmware that ELRS Mobile builds on.
3. When the download finishes, the version shows **Ready for offline use**. The firmware and the hardware definitions it needs are now stored on your phone.

Download firmware on your home Wi-Fi or mobile data. You can't download while your phone is connected to a receiver's or transmitter's Wi-Fi hotspot, because that network has no internet.

The header shows how many versions you've stored against your limit. Change the limit in **Settings → App & Storage → Max Cached Versions**, and delete versions you no longer need.

### Step 2: Connect to your device

1. Power on your receiver or transmitter and wait for it to start its Wi-Fi hotspot. By default this happens 60 seconds after power-on if it hasn't connected to its partner. Transmitters can also start Wi-Fi from the ExpressLRS Lua script on your radio.
2. On your phone, join the **ExpressLRS RX** or **ExpressLRS TX** network. The password is `expresslrs`.
3. Open ELRS Mobile. The Dashboard finds the device automatically and shows its product name, firmware version, target and regulatory domain.

If the Dashboard shows **No Device Found**, tap **Retry**. If your device is on a different network (for example, joined to your home Wi-Fi), tap the gear icon on the device card and enter its IP address.

Devices running firmware older than 3.1 are detected too, so you can bring them up to a current release.

### Step 3: Flash

1. On the Dashboard, tap **Flash Device**.
2. Check the target. The app preselects the target that matches the connected device when it can; otherwise choose Device Type, Device Vendor, Regulatory & Frequency, and Device Target.
3. Choose the firmware version. Versions you've downloaded are marked **(Cached)**. If the hardware needs a newer version than you have, the app says so and offers to download a compatible one.
4. Check the firmware options: flashing profile, binding phrase, Wi-Fi network and password, regulatory domain, and Wi-Fi auto-on interval.
5. Tap **Flash**.

The progress bar follows each step: locating and unpacking your downloaded firmware, building it with your settings, uploading it, and **Writing to Device — Please Wait** while the device installs it and restarts. When the device confirms, you'll see **Flashing Successful! Device is rebooting**, and the Dashboard reconnects once it's back.

---

## Safety checks

The app checks your choices before flashing and stops if something looks wrong.

:::danger[Incompatible chip]
Firmware for one chip can never run on another (for example, ESP32 firmware on an ESP8285 receiver). The app blocks the flash and tells you which chip each one is. Choose a target for your device's chip.
:::

:::caution[Target mismatch]
If the selected target doesn't match the product the device reports, you'll see **Target Mismatch**. Check your selection first. If you're sure it's right (for example, recovering from a bad flash or moving to a newer target definition), tap **Force Flash**.
:::

:::note[No binding phrase]
Flashing without a binding phrase works, but the device will only bind using the default (empty) phrase. The app asks before continuing.
:::

:::caution[Flash not confirmed]
If the device disconnects before confirming the flash (it lost power, restarted, or the Wi-Fi link dropped), the app can't tell whether the update finished. It shows an amber warning instead of reporting success. Reconnect and check the firmware version on the Dashboard; if it hasn't changed, flash again.
:::

---

## Flashing profiles

A flashing profile saves a binding phrase, home Wi-Fi network and password, default regulatory domains, and Wi-Fi auto-on interval under a name. Use one per fleet or radio setup, and switch between them in one tap.

Manage profiles in **Settings → Profiles & Network**:

- **Add:** tap **+**, type a name, and tap **Add**.
- **Switch:** choose a profile from the **Flashing Profile** list. It's also available on the flashing screen.
- **Edit:** change any field; the active profile saves automatically.
- **Delete:** select the profile and tap the delete icon. You always keep at least one profile.

Binding phrases and Wi-Fi passwords are stored in your phone's encrypted secure storage.

---

## Device configuration

On the Dashboard, tap **Device Config** to open the connected device's own ExpressLRS settings page inside the app. Use it to change Wi-Fi and binding settings, model match, serial protocol, PWM output mapping and other device options. The app keeps the page locked to your device.

---

## Settings

| Section | What's there |
| :--- | :--- |
| Profiles & Network | Flashing profiles, binding phrase, home Wi-Fi network and password, default 2.4 GHz and sub-GHz regulatory domains |
| App & Storage | Max cached versions, Firmware Manager, clear the firmware cache, app language, anonymous usage analytics on or off |
| Advanced & Debug | Expert Mode and its tools (below) |
| About & Legal | App version, legal notice and license, support development, and **Check for Updates** in the direct-download APK |

Change the app language from Settings or the language button in the top bar. ELRS Mobile is available in 18 languages.

---

## Expert Mode

Turn on **Settings → Advanced & Debug → Expert Mode** to unlock:

- **STM32 targets.** Older STM32-based hardware can't be flashed over Wi-Fi, and only ExpressLRS 3.3.x supports it. The app builds the firmware with your settings so you can flash it from a PC with an STLink or Betaflight passthrough.
- **Download Binary.** Save the built firmware file instead of flashing it, for manual flashing or auditing.
- **Export ELRS Lua Script.** Save `elrs.lua` for EdgeTX and OpenTX radios.
- **Submit Debug Report.** Send device information and app logs to help fix a bug. Binding phrases and Wi-Fi passwords are never included.

---

## Troubleshooting

**The Dashboard can't find my device.** Make sure your phone is still joined to the device's Wi-Fi network; some phones leave networks that have no internet. On Android, ELRS Mobile keeps its traffic on that Wi-Fi network even without internet. Tap **Retry**, or enter the IP address from the gear icon (`10.0.0.1` on the device's own hotspot).

**I can't download firmware.** Disconnect from the device's hotspot and use a network with internet.

**My device is unresponsive after a failed flash.** Hold the BOOT button while plugging it in over USB to enter bootloader mode, then re-flash with the [ExpressLRS Web Flasher](https://expresslrs.org/flasher). Wi-Fi-capable devices can also be recovered by holding BOOT for 60 seconds to start the Wi-Fi hotspot. The in-app **Help & Support** screen has these steps, a FAQ, and links to the ExpressLRS Discord.

**My profiles disappeared after updating.** Updating straight from v1.0.43 or older to v1.0.45 or newer can't carry saved profiles, binding phrases and Wi-Fi settings across a storage upgrade. The app tells you once; re-enter them in Settings.

---

Developers can verify the firmware ELRS Mobile builds with the [Firmware Validation Tools](/firmware-validation).
