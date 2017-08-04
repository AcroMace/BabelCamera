# BabelCamera

[![Build Status](https://travis-ci.org/AcroMace/BabelCamera.svg?branch=master)](https://travis-ci.org/AcroMace/BabelCamera) [![DUB](https://img.shields.io/dub/l/vibe-d.svg?maxAge=2592000)](https://github.com/AcroMace/BabelCamera/blob/master/LICENSE)

Find out how to describe the things around you in another language!

An iOS app using [Core ML](https://developer.apple.com/documentation/coreml) and the [Vision framework](https://developer.apple.com/documentation/vision) in iOS 11 as well as the [Google Translate API](https://cloud.google.com/translate).

## Demo

![BabelCamera demo gif](https://github.com/AcroMace/BabelCamera/raw/master/Demo.gif)

*The app also reads the words aloud*

## Running

1. Get a [Google Translate API Key](https://cloud.google.com/translate/docs/getting-started)
2. Copy `Keys.example.xcconfig` to `Keys.xcconfig` and replace `YOUR_API_KEY_HERE` in the file with your API key from step 1
3. Clean build folder / clear derived data (`⌥⇧⌘K`)
4. Run the app

## Vision model

The app currently comes with [SqueezeNet](https://github.com/DeepScale/SqueezeNet). You can replace it with another model available on the [Apple's Core ML page](https://developer.apple.com/machine-learning/) (ex. `ResNet50`, `Inception v3`, `VGG16`) by dragging the `.mlmodel` file (ex. `VGG16.mlmodel`) into Xcode where you see `SqueezeNet.model`, and then:

In `VisionService.swift`, replace the line:

	model = try? VNCoreMLModel(for: SqueezeNet().model)

with

	model = try? VNCoreMLModel(for: VGG16().model)

or the model of your choice

## Languages currently supported

These are languages that can both be translated by Google Translate and pronounced by iOS (listed in `Language.swift`)

- Arabic
- Chinese (Simplified)
- Chinese (Traditional)
- Czech
- Danish
- Dutch
- English
- Finnish
- French
- German
- Greek
- Hewbrew
- Hindi
- Hungarian
- Indonesian
- Italian
- Japanese
- Korean
- Norwegian
- Polish
- Portuguese
- Romanian
- Russian
- Slovak
- Spanish
- Swedish
- Thai
- Turkish
