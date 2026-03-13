# CLAUDE.md — 1% Better Focus

## Brand Hub
**onepercentbetter.poker** — this project is listed there as `1% Better Focus`.
If it's removed from the site, it's no longer a brand asset.
Owner: Chris S. Yoon · github.com/sukminc

## What this is
Minimalist deep-work Pomodoro timer. Flutter app for iOS, Android, Web.
Status: `building` (MVP done, Supabase sync + App Store release pending)
Slug on hub: `onepercent-focus` · Repo: `sukminc/OneBetterFocus`

## Core Philosophy
Same brand DNA as the hub — marginal gains compounded.
Easy consumer app = revenue stream that funds the core analytics platform.

## Stack
- Flutter 3.x (iOS, Android, Web)
- Dart
- Supabase (Phase 2 — auth + session sync)
- local-first: shared_preferences for streaks/sessions

## Key Architecture
- `TimerNotifier` — pure Dart, zero UI dependencies
- `TimerState` — immutable, copyWith pattern
- `SessionStorage` abstraction — swap to Supabase without touching features
- Feature flags for premium gating (`customTimeSets`, `customReflection`)

## MVP Features (Phase 1 — Done)
- 25/5 Pomodoro timer
- Dimming overlay during focus sessions
- Confetti on completion
- Emoji self-reflection bottom sheet
- Streak + session count (local-first)

## Roadmap
- Phase 2: Supabase auth + async session sync
- Phase 3: Custom time sets (IAP / RevenueCat)
- Phase 4: App Store + Google Play release

## Commands
```bash
flutter pub get
flutter run -d chrome     # web
flutter run               # connected device
flutter build apk         # Android
flutter build ipa         # iOS
```
