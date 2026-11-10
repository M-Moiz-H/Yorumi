# Yorumi 🌙
### Listen • Chat • Chill Together

A music app built for listening together — stream YouTube Music, create rooms, and chat with friends in real time.

---

## Features

- 🎵 Stream music via YouTube Music (no account required)
- 🔊 Listen Together rooms — sync playback with friends globally
- 💬 Real-time room chat — messages visible to everyone in the room
- 🎙️ Discord rich presence integration
- 📱 Material You dynamic theming
- 🌙 Dark / light mode
- 📶 Offline cache support
- Last.fm scrobbling

---

## Build from source

### Requirements
- Android Studio Hedgehog or newer
- JDK 21
- Android SDK 36

### Steps

```bash
git clone https://github.com/YOUR_USERNAME/Yorumi.git
cd Yorumi
./gradlew assembleFossRelease
```

APK lands at `app/build/outputs/apk/foss/release/`.

---

## GitHub Actions — Automated Builds

### First-time setup (one time only)

**1. Generate your release keystore:**
```bash
chmod +x .github/scripts/gen_keystore.sh
./.github/scripts/gen_keystore.sh
```
Back up `yorumi-release.keystore` somewhere safe. Lose it = can't update existing installs.

**2. Add GitHub Secrets** (`Settings → Secrets and variables → Actions`):

| Secret name | Value |
|---|---|
| `KEYSTORE` | base64 output from the script |
| `KEY_ALIAS` | `yorumi` |
| `KEYSTORE_PASSWORD` | password from the script |
| `KEY_PASSWORD` | password from the script |
| `LASTFM_API_KEY` | *(optional)* Last.fm API key |
| `LASTFM_SECRET` | *(optional)* Last.fm secret |

**3. Push to main** — release fires automatically when `versionCode` or `versionName` changes.

**4. Manual build** — `Actions → Yorumi — Quick Build → Run workflow`.

---

## Workflows

| Workflow | Trigger | Output |
|---|---|---|
| `build.yml` | Every push to main | Debug APK (7 days) |
| `build_pr.yml` | Pull requests | Debug APK (3 days) |
| `release.yml` | Version bump on main | Signed APK → GitHub Release |
| `build_quick.yml` | Manual dispatch | Signed APK (14 days) |

---

## Room Chat

Chat is built into the Listen Together room system.
- Messages relay through the existing Yorumi relay server — no extra backend needed
- Ephemeral: cleared when you leave the room
- Max 300 chars per message, 200 messages kept in memory per session

---

## Credits

Built on [Metrolist](https://github.com/MetrolistGroup/Metrolist) (GPL-3.0),
itself built on [InnerTune](https://github.com/z-huang/InnerTune).
