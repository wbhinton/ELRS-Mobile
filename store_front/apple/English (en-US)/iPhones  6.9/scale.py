import os
from PIL import Image

def scale_all_screenshots():
    # Target size for 6.5" Display (iPhone 11 Pro Max)
    target_size = (1242, 2688)
    output_folder = 'scaled'

    # Create the output directory if it doesn't exist
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)
        print(f"Created folder: {output_folder}")

    # Identify all PNG files in the current working directory
    png_files = [f for f in os.listdir('.') if f.lower().endswith('.png')]

    if not png_files:
        print("No PNG files found in the current directory.")
        return

    print(f"Found {len(png_files)} images. Starting resize...")

    for filename in png_files:
        try:
            with Image.open(filename) as img:
                # Resize using Lanczos for best quality on text/UI
                resized_img = img.resize(target_size, Image.Resampling.LANCZOS)
                
                # Construct output path
                output_path = os.path.join(output_folder, filename)
                
                # Save the new image
                resized_img.save(output_path, "PNG")
                print(f" ✅ Processed: {filename}")
        except Exception as e:
            print(f" ❌ Failed to process {filename}: {e}")

    print(f"\nDone! Scaled images are located in the '{output_folder}' folder.")

if __name__ == "__main__":
    scale_all_screenshots()