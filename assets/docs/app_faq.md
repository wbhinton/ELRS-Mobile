# Walkthrough

## Phase 1: Caching Firmware
1. **Connect to the Internet:** Ensure your phone is connected to the internet (e.g. home wifi or mobile network).
2. **Open Firmware Manager:** Navigate to the Firmware Manager in the app.
3. **Download Release:** Tap the download icon next to your desired ExpressLRS release. This securely caches the required firmware targets and hardware definitions on your phone for 100% offline use.

## Phase 2: Connecting to Your Device
1. **Power on Device:** Power on your ExpressLRS Receiver (RX) or Transmitter (TX).
2. **Wait for Hotspot:** Wait for the device to enter Wi-Fi Hotspot Mode (indicated by a rapid blinking LED).
3. **Connect to Hotspot:** Connect your phone's Wi-Fi to the `ExpressLRS RX` or `ExpressLRS TX` network using the password `expresslrs`.
* **Note:** ELRS Mobile natively handles forced routing, ensuring your phone doesn't silently switch back to 5G/LTE.

## Phase 3: Flashing Firmware
1. **Navigate to Flash Device:** From the main Dashboard, select **Flash Device**.
2. **Target Selection:** Use the cascading dropdowns to select the vendor and specific hardware target.
3. **Version Selection:** Choose an available firmware version from your offline repository.
4. **Configuration:** Enter your custom credentials. The application persists the WiFi SSID, WiFi Password, and Binding Phrase in local storage so you don't have to re-enter them.
5. **Build & Flash:** Tap **FLASH**. The system patches the binary with your local credentials and uploads it.
* **Crucial:** Always wait for the success confirmation and for the device LED to resume blinking before unplugging!

---

# FAQ

## Do I need an internet connection or cellular service to flash firmware?
No. ELRS Mobile features **100% Offline Flashing**. As long as you have previously downloaded the firmware version via the Firmware Manager while on home Wi-Fi, the app can dynamically assemble and flash the firmware completely offline.

## My phone keeps disconnecting from the ExpressLRS Wi-Fi hotspot.
ELRS Mobile natively handles forced network routing. It ensures your phone doesn't silently switch back to 5G/LTE when it realizes the receiver's hotspot has no internet access, completely eliminating the common "connected but can't see the receiver" issue out in the field.

## I get a "Not enough space" error when flashing my ESP8285 receiver.
ESP8285 chips (like those found on many AIO boards) only have 1MB of total physical storage. Updating directly to a major release (like from 3.x to 4.x) over Wi-Fi can run out of dual-partition space because the incoming file is too large to unpack alongside the currently running firmware. 

**How to fix:** First, flash your receiver to an intermediate version (like **3.6.3**). Once it is running the leaner 3.6.3 firmware, you will have enough partition space to successfully flash to your desired 4.0 target. Alternatively, enable **Expert Mode** in Settings, save the built binary locally, and flash it manually via a wired Betaflight Passthrough connection.

## Where do I find the ExpressLRS Lua script for my radio?
ELRS Mobile comes with the universal, version-agnostic Lua script built right in! To get it:
1. Go to **Settings** and toggle on **Expert Mode**.
2. Tap **Export ELRS Lua Script**.
3. This saves `elrs.lua` directly to your phone's local storage. Turn on your radio and plug it into your phone via USB, be sure to select "USB Storage" mode on your radio and transfer the file into your `SCRIPTS/TOOLS` folder using your phone's file manager. 

**Note** You need to delete any previous versions of the elrs.lua script (eg. elrs_v2.lua, elrs_v3.lua, etc) from your radio's SD card before using the new script.

## What if a flash fails and my device becomes unresponsive?
If your device is unresponsive after a failed flash, you can easily recover it:
1. Hold the BOOT button on the device while plugging it in via USB to enter bootloader mode.
2. Use a computer and the ELRS Web Flasher to re-flash the device over a wired USB/UART connection.
3. For Wi-Fi-capable devices, you can also hold the BOOT 

**Note** There is a video link on the Resources Tab that shows how to do this.

## Can I save the firmware file to my phone without flashing it?
Yes. By going into **Settings** and enabling **Expert Mode**, you unlock the ability to save the assembled firmware binary directly to your mobile device's local storage instead of immediately flashing it Over-The-Air (OTA).

This is especially useful if you want to flash the device manually using a dedicated hardware programmer (like an STLink or FTDI adapter).

## I am getting a "Target Mismatch" error. What should I do?
A target mismatch error occurs when the hardware target you selected in the app does not match the target of the firmware currently running on the device

Currently the app doesn't support flashing a different target than the one currently running on the device. 
