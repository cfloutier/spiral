# spiral — Development

Implementation notes and build procedure for `spiral`. For usage/controls, see [README.md](README.md).

---

## Development Setup

Only needed to open/edit/run the sketch from source — not needed to just run a release build (see [README.md](README.md#getting-a-release)).

1. **Install Processing**: download from https://processing.org/download and install (Java Mode, the default one).
2. **Install ControlP5**: in the Processing IDE, go to `Sketch > Import Library... > Manage Libraries...`, search for **ControlP5**, and click Install. This puts it straight into your sketchbook's `libraries/` folder — no manual download/unzip needed. (Library home page, for reference: http://www.sojamo.de/libraries/controlP5)
3. Open `spiral.pde` in Processing and press Run.

---

## Principle

Each line starts on a circle of radius `Radius`, at an angle evenly spaced around `NbLines` lines (plus `StartAngle`). At every step it rotates by a per-step angle (`Rotation × RotationMultiplier`, finely adjusted by `RotationTwitch`) and scales its radius by `RatioRadius` — a ratio below 1 spirals inward, above 1 spirals outward. Repeating this `NbSteps × NbStepsMultiplier` times traces one spiral arm; `Mirror` adds a second pass with the rotation reversed.

---

## Architecture

| File | Role |
|------|------|
| `spiral.pde` | Setup, draw loop, export |
| `Data.pde` | `SpiralsData` + `DataGUI` — aggregates main, style |
| `DataMain.pde` | `DataMain` + `MainGUI` — spiral generation parameters |
| `SpiralGenerator.pde` | `SpiralLine` + `SpiralGenerator` — per-line angle/radius stepping |

---

## Building a Release

`export_app.ps1` (project root) builds a standalone, installer-free application and packages it as a release zip.

```powershell
.\export_app.ps1
```

This will:
1. Export the sketch as a standalone application via `processing-java --export` (embeds a JRE and all libraries, including ControlP5 — end users install nothing).
2. Copy `Settings/` into the export (the Processing export step does **not** include it, and the sketch crashes on startup without a `Settings/default.json` to load).
3. Zip the result into `releases/spiral_<variant>_<date>.zip`, ready to hand out.

Useful options:
```powershell
.\export_app.ps1 -ProcessingPath "D:\tools\processing-4.3\processing-java.exe"  # different Processing install
.\export_app.ps1 -Zip $false                                                    # skip the release zip
```

**Note:** the build always targets the OS you run the script on — `-Variant` does not cross-compile for another platform (verified empirically: requesting `linux-amd64` from Windows still produced a Windows build). To produce a macOS or Linux build, run this script on a machine running that OS.
