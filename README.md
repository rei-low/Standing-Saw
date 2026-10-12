# Standing Saw

A SwiftUI app for experimenting with AirPods head tracking as a control source for spatial audio.

**Status:** freshly scaffolded — the app currently shows the default SwiftUI view; head tracking and audio aren't wired up yet.

## Requirements

- Xcode 26.1 or later
- iOS / iPadOS 26.1 or later
- A physical iPhone or iPad and AirPods with head tracking support (the Simulator doesn't provide headphone motion data)

## Getting started

```sh
git clone https://github.com/rei-low/Standing-Saw.git
cd Standing-Saw
open "AirPods Head Tracking Audio.xcodeproj"
```

Select your own development team under *Signing & Capabilities* before building to a device.

## Layout

| Path | Contents |
| --- | --- |
| `AirPods Head Tracking Audio/` | App source (SwiftUI) and asset catalog |
| `AirPods Head Tracking AudioTests/` | Unit tests |
| `AirPods Head Tracking AudioUITests/` | UI and launch tests |
