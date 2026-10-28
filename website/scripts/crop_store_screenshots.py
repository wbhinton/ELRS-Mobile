"""Crop the phone out of each iPhone store screenshot for use on the website.

The store screenshots (store_front/apple/.../iPhones 6.9/NN.png) are marketing
images: a caption at the top, then a phone mockup on a dark background. This
finds the phone, fades its edges into transparency so it sits on any dark page
background, and writes website/src/assets/screens/<name>.png.

Re-run after updating the store screenshots:
    python3 website/scripts/crop_store_screenshots.py
"""

from pathlib import Path

from PIL import Image, ImageChops, ImageDraw, ImageFilter

ROOT = Path(__file__).resolve().parents[2]
SOURCE = ROOT / "store_front/apple/English (en-US)/iPhones  6.9"
OUT = ROOT / "website/src/assets/screens"

SCREENS = {
    "01.png": "dashboard",
    "02.png": "flashing",
    "03.png": "firmware-manager",
    "04.png": "settings",
    "06.png": "device-config",
}

HEIGHT = 900  # output height in px; astro:assets generates smaller sizes
# The phone's dark-grey screen (L≈30) is lighter than the store background (L≈16);
# a phone row spans most of the image width, caption text rows do not.
SCREEN_LUM = 22
PHONE_ROW_FILL = 0.55
PHONE_COL_FILL = 0.5
FADE_START = 0.72  # fraction of height where the bottom fade begins


def runs(flags):
    """Yield (start, end) index pairs for consecutive True values."""
    start = None
    for i, flag in enumerate(flags + [False]):
        if flag and start is None:
            start = i
        elif not flag and start is not None:
            yield start, i - 1
            start = None


def phone_bounds(img):
    """Return the phone's bounding box: the tallest run of mostly-lit rows."""
    lum = img.convert("L")
    w, h = lum.size
    px = lum.load()
    xs = range(0, w, 6)
    row_hit = [sum(px[x, y] > SCREEN_LUM for x in xs) > PHONE_ROW_FILL * len(xs) for y in range(h)]
    top, bottom = max(runs(row_hit), key=lambda r: r[1] - r[0])
    ys = range(top, bottom, 6)
    col_hit = [sum(px[x, y] > SCREEN_LUM for y in ys) > PHONE_COL_FILL * len(ys) for x in range(w)]
    left, right = max(runs(col_hit), key=lambda r: r[1] - r[0])
    return left, top, right, bottom


def crop(path):
    img = Image.open(path).convert("RGBA")
    left, top, right, bottom = phone_bounds(img)
    # Bounds are the screen; the phone frame sits ~65px outside it, the glow beyond.
    pad = 110
    img = img.crop((max(0, left - pad), max(0, top - pad), min(img.width, right + pad), bottom))
    w, h = img.size

    # Rounded mask that keeps the frame but drops the glow, so no background box shows.
    inset = 63
    mask = Image.new("L", (w, h), 0)
    ImageDraw.Draw(mask).rounded_rectangle((inset, inset, w - inset, h + 200), radius=150, fill=255)
    mask = mask.filter(ImageFilter.GaussianBlur(14))

    # The store mockups crop the phone at the image bottom; fade it out instead.
    fade = Image.new("L", (w, h), 255)
    draw = ImageDraw.Draw(fade)
    start = int(h * FADE_START)
    for y in range(start, h):
        draw.line((0, y, w, y), fill=int(255 * (1 - (y - start) / (h - start)) ** 1.5))

    img.putalpha(ImageChops.multiply(mask, fade))
    return img.resize((w * HEIGHT // h, HEIGHT), Image.LANCZOS)


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    for source, name in SCREENS.items():
        out = OUT / f"{name}.png"
        crop(SOURCE / source).save(out, optimize=True)
        print(f"{source} -> {out.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
