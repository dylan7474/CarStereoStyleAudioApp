# CarStereoStyleAudioApp

CarStereoStyleAudioApp is a lightweight web app that presents a car-stereo-inspired audio interface. It provides a retro dashboard-style layout for browsing and controlling audio playback with clear, tactile-style controls.

## Basic Controls

- **Play/Pause**: Toggle playback for the current track.
- **Next/Previous**: Skip forward or backward through the playlist.
- **Noise/Stream Mix**: Balance the ambient noise layer against the main audio stream.
- **Source**: Switch between available inputs or playlists.
- **Sleep Timer**: Choose a 15 or 30 minute timer to stop playback.

## Recent Updates

- Mobile-friendly player controls now stay visible with a compact layout.
- Phone layout now prioritizes the full-width progress scrubber with a vertical mix slider.
- The library info panel collapses on smaller screens for easier browsing.
- Sleep timer displays a live countdown when active.
- Preset buttons now highlight the active source during playback.
- Offline-first library browsing now uses cached metadata when connectivity drops.
- The main display now uses a high-fidelity retro digital time readout with scanlines and a clearer, steadier glow.
- Progress time readouts now prioritize contrast and spacing for better legibility.
- Sleep timer readout now stacks cleanly with the main progress time on phones without duplicating the small status line.
- Added a legacy-friendly `legacy.html` page for older browsers without modern CSS/JS features.
- Tuned legacy playback controls to favor touch-first Safari devices with a tap-to-start fallback message.
- Added a top-bar noise toggle with white/blue noise playback that can run alongside the main audio stream.
- Merged the stream volume and noise balance into a single mix control that works for both white and blue noise.

## Improvement Ideas

- Add persistent theme selection and accent color presets.
- Provide full keyboard shortcuts for player, library, and presets.
- Add a playlist manager with drag-and-drop ordering and save slots.
- Improve accessibility with focus states and ARIA labels on controls.

## Roadmap

- Theme presets to mimic different classic head units.
