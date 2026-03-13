# 1% Better Focus

Minimalist focus timer built in Flutter.

This project is part of the `1% Better` product line: small apps with a tight loop, clear value, and fast iteration. `1% Better Focus` is the deep-work version of that idea. It is a local-first timer with a simple session flow, milestone tracking, and lightweight reflection after each block.

## Why This Exists

I wanted a product small enough to ship quickly but opinionated enough to show product taste:

- one job: help the user start and finish a focus block
- no account wall
- no overbuilt dashboard
- visible progress through streaks and milestones

For hiring, this repo also shows that I can move beyond backend/data work and ship a clean mobile experience with state management, local persistence, and a clear UX loop.

## Current Product Loop

1. Enter a focus goal
2. Start a work session
3. Complete the timer
4. Log a quick reflection
5. Record the session and update milestones
6. Reset into the next loop

## What Is Implemented

- Flutter app targeting mobile and web
- Riverpod-based timer state management
- Local persistence with `shared_preferences`
- Milestone tracking for total sessions and current streak
- Reflection sheet after a completed work session
- Confetti feedback on completion
- Debug-friendly shortened timer durations in development

## Code Highlights

- [lib/main.dart](/Users/chrisyoon/GitHub/one-percent-better-focus/lib/main.dart)
  Entry point, Riverpod setup, and app shell.
- [lib/features/timer/providers/timer_provider.dart](/Users/chrisyoon/GitHub/one-percent-better-focus/lib/features/timer/providers/timer_provider.dart)
  Timer phases, running/paused/completed state, and ticker logic.
- [lib/features/timer/widgets/focus_screen.dart](/Users/chrisyoon/GitHub/one-percent-better-focus/lib/features/timer/widgets/focus_screen.dart)
  Main focus flow, goal input, progress ring, action buttons, and completion handling.
- [lib/features/session/widgets/reflection_sheet.dart](/Users/chrisyoon/GitHub/one-percent-better-focus/lib/features/session/widgets/reflection_sheet.dart)
  Post-session reflection UI.
- [lib/features/milestones/providers/milestone_provider.dart](/Users/chrisyoon/GitHub/one-percent-better-focus/lib/features/milestones/providers/milestone_provider.dart)
  Session count and streak state.
- [lib/core/storage/session_storage.dart](/Users/chrisyoon/GitHub/one-percent-better-focus/lib/core/storage/session_storage.dart)
  Local-first persistence layer.

## Stack

- Flutter
- Dart
- Riverpod
- shared_preferences
- Material UI

## Running Locally

```bash
flutter pub get
flutter run
```

For web:

```bash
flutter run -d chrome
```

## Current Status

This is an actively iterated product prototype, not a fully commercialized app yet.

What is strong now:

- the core timer flow
- local persistence
- the product loop is easy to understand

What would come next:

- cloud sync
- auth
- richer session history
- configurable session lengths
- shipping to App Store / Play Store

## Why It Matters In My Portfolio

`1% Better Focus` is intentionally smaller than a full SaaS product. That is the point.

It demonstrates:

- product restraint
- shipping speed
- mobile/frontend execution
- consistency with the broader `1% Better` brand
