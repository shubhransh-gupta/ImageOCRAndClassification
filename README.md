# ImageOCRAndClassification
We’re trying to create an experience very similar to how ‘Library’ section looks on Apple Photos (horizontal image strip at the bottom with a full image preview of the selected image)

Building a working demo for this flow. Also, build the logic to auto-sync the images from screenshot gallery and use apple’s core ML vision framework for populating the description field with OCR data from the image.

Expectations:

1. The app should be able to handle large number of screenshots efficiently. Avoid memory-related issues. Dataset for a large number of images if needed. Download using wget.
    To test OCR, you can use some screenshots with text on it.
    
2. The UI should be responsive. Use loading states wherever applicable.
3. Fast scroll on the bottom image strip should be supported. Get as close to the UX apple photos app has.
4. All functionalities should be implemented.
