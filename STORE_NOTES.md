# Store Release Notes

Short, user-facing notes to paste into the app stores for each release,
newest first. The full technical history lives in [CHANGELOG.md](CHANGELOG.md).

**Limits**

| Field | Where | Limit |
|---|---|---|
| What's new | Google Play Console, per track release | 500 characters |
| What to Test | App Store Connect → TestFlight, per build | 4,000 characters |
| What's New in This Version | App Store Connect, production only | 4,000 characters |

Release candidates need the Play and TestFlight notes; add App Store notes
when the release goes to production.

---

## v1.0.44-rc2

### Google Play — What's new

```
• Force Flash works again after a target mismatch
• The app only reports success when your device confirms the flash, and warns you if the connection drops mid-flash
• Blocks firmware built for a different chip, with an explanation
• Update devices running firmware older than 3.1
• Progress bar now shows each real flashing step
• Every screen and error message translated into all 18 languages
```

### TestFlight — What to Test

```
This release candidate reworks how flashing results are reported. Please focus on:

1. Normal flash: flash a receiver or transmitter and confirm the progress steps look right and it ends with "Flashing Successful".

2. Force Flash: select a target whose product name differs from your device (same chip), confirm the Target Mismatch dialog, tap Force Flash, and check the device boots the new firmware.

3. Wrong chip: select a target for a different chip than your device (e.g. an ESP32 target for an ESP8285 receiver). Flashing should be blocked with an "Incompatible chip" message, with no Force Flash option.

4. Interrupted flash: power-cycle the device while "Writing to Device" is shown. You should get an amber warning that the flash is unconfirmed, never "Flashing Successful".

5. No bind phrase: clear the binding phrase and tap Flash. You should be asked whether to continue without one.

6. Languages: switch the app language in Settings and look for untranslated text, cut-off labels, or wrong wording, especially on the flashing screen and in error messages.

Devices on firmware older than 3.1 should now be detected and flashable. Reports from anyone with one are especially welcome.
```
