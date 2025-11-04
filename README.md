# MyTabbedApp

MyTabbedApp is a React Native application created with the React Native CLI and TypeScript. It features a two-tab layout with Home and Settings screens using `@react-navigation/bottom-tabs`.

## Prerequisites

- Node.js 18+
- Java 17
- Android SDK with required platform tools available on your `PATH`
- Watchman (optional, for macOS users)

## Installation

```bash
npm install
```

## Running on Android (Debug)

Start an Android emulator or connect a device with USB debugging enabled, then run:

```bash
npx react-native run-android
```

This will compile and install the debug build on the connected device/emulator.

## Building a Signed Release APK

1. Place your keystore file at `android/app/release.keystore` (this file is intentionally ignored by Git).
2. The signing configuration is already wired up through `android/gradle.properties` and `android/app/build.gradle`.
3. Build the release APK from the project root:

```bash
cd android
./gradlew assembleRelease
```

The generated APK will be located at `android/app/build/outputs/apk/release/app-release.apk`.

> **Note:** The Gradle wrapper scripts download the `gradle-wrapper.jar` from the official Gradle distribution on first use. Ensure either `curl` or `wget` is available on Unix-like systems; Windows hosts rely on PowerShell's `Invoke-WebRequest`.

## Docker Support

Build the development image (contains Node.js, Java 17, and Android SDK tools):

```bash
docker build -t mytabbedapp .
```

Install dependencies inside the container (the project is mounted so `node_modules` persists on your machine):

```bash
docker run --rm -it -v "$PWD":/app mytabbedapp npm install
```

Run the Metro bundler or other CLI commands, for example to launch the Android debug build:

```bash
docker run --rm -it -v "$PWD":/app --network host \
  mytabbedapp npx react-native run-android
```

Build the signed release APK within the container:

```bash
docker run --rm -it -v "$PWD":/app mytabbedapp bash -lc 'cd android && ./gradlew assembleRelease'
```
