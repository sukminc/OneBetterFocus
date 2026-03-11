# Project: 1% Better (OnePercentBetter)
## Vision: "1% Better Every Day"

1% Better is a minimalist deep-work engine designed to eliminate digital noise and foster consistency. As a Senior Data Engineer-led project, the codebase must prioritize clean architecture, observability, and performance.

---

## 🛠 Tech Stack & Architecture
- **Frontend:** Flutter 3.35+ (Web, iOS, Android)
- **State Management:** Riverpod 2.x (NotifierProvider pattern, no code-gen in Phase 1)
- **Local Persistence:** shared_preferences (local-first; Supabase sync in Phase 2)
- **Backend/Storage:** Supabase (Phase 2 — Auth, PostgreSQL)
- **App Name:** "1% Better" (display), package: `better_focus` (internal Dart/bundle ID)
- **Design Philosophy:** Minimalist, high-contrast dark theme, distraction-free.

---

## 📁 Project Structure

```
lib/
├── core/
│   ├── theme/app_theme.dart          # Dark palette, typography
│   ├── storage/session_storage.dart  # Local persistence abstraction
│   └── config/feature_flags.dart     # Freemium feature gating
├── features/
│   ├── timer/
│   │   ├── providers/timer_provider.dart   # Pure Dart timer engine (Riverpod)
│   │   └── widgets/
│   │       ├── focus_screen.dart           # Main screen with dimming overlay
│   │       └── circular_progress.dart      # Arc progress ring
│   ├── session/
│   │   └── widgets/reflection_sheet.dart  # Post-session emoji bottom sheet
│   └── milestones/
│       ├── providers/milestone_provider.dart  # Streak + session count
│       └── widgets/milestone_bar.dart         # Footer stats display
└── main.dart                                  # App entry, ProviderScope setup
```

---

## 🎯 Core Features (MVP — Phase 1 Complete)
1. **Goal Setting:** Text input for current session's focus goal.
2. **Deep Work Timer:** 25-min work / 5-min break Pomodoro, decoupled from UI.
3. **Dimming Animation:** UI dims to 35% opacity during active focus sessions.
4. **Circular Progress Ring:** Thin arc indicator around timer display.
5. **Celebration:** Confetti burst (confetti package) on session completion.
6. **Self-Reflection:** 😊/🙁 bottom sheet post-session.
7. **Milestones:** Persistent streak + total session count via shared_preferences.
8. **Premium Gating:** `FeatureFlags` class ready for custom time sets (Phase 3).

---

## 🏗 Architecture Decisions
- **Timer engine is pure Dart** — `TimerNotifier` has zero UI dependencies.
- **TimerState is immutable** — `copyWith` pattern, easy to test.
- **SessionStorage is an abstraction** — swap to Supabase without touching features.
- **ProviderScope override** — `SharedPreferences` injected at app root for testability.
- **AnimatedOpacity** for dimming (800ms ease) — no package needed, buttery smooth.

---

## 📜 Development Principles

### 1. Zero Noise UI
- No ads, no social feeds, no unnecessary navigation.
- Dark palette: `#0D0D0D` bg, `#E8D5B7` warm-white accent.
- Focus sessions are sacred — no interruptions during timer (UI dims, no modals).

### 2. Clean Code Standard
- **Fail-fast:** Providers throw `UnimplementedError` if not overridden (e.g., SharedPreferences).
- **Local-First:** All data writes go to `SessionStorage`; Supabase sync is async and additive.
- **Modular:** Timer logic, UI, and storage are fully decoupled.

### 3. Business Logic
- **Freemium Ready:** `FeatureFlags.customTimeSets` and `FeatureFlags.customReflection` gate premium features.
- **Privacy:** No analytics, no tracking. Data owned by the user.

---

## 🚀 Roadmap

### ✅ Phase 1 — Local Flutter MVP
- [x] Flutter project scaffold (iOS, Android, Web)
- [x] Riverpod state management
- [x] Immutable `TimerState` with `TimerNotifier`
- [x] Circular progress ring widget
- [x] Dimming overlay during focus sessions
- [x] Confetti on completion
- [x] Emoji reflection bottom sheet
- [x] `SessionStorage` (local-first)
- [x] Milestone bar (streak + total sessions)
- [x] Feature flags structure

### 🔲 Phase 2 — Supabase Integration
- [ ] Supabase auth (email + Apple/Google)
- [ ] Async session sync to PostgreSQL
- [ ] Replace `SessionStorage` with `SupabaseSessionRepository`
- [ ] Remote feature flag support

### 🔲 Phase 3 — Custom Time Sets & Reflection (Premium)
- [ ] Custom work/break duration picker (behind `FeatureFlags.customTimeSets`)
- [ ] Custom emoji sets for reflection (behind `FeatureFlags.customReflection`)
- [ ] In-App Purchase integration (RevenueCat or native)

### 🔲 Phase 4 — Public Release
- [ ] 7-day session heatmap / analytics widget
- [ ] App icon, splash screen, store assets
- [ ] TestFlight (iOS) + Google Play Internal Track
- [ ] Web deployment (Vercel or Firebase Hosting)

---

## 🔑 Key Commands
```bash
flutter pub get                  # Install dependencies
flutter run -d chrome            # Run on web
flutter run                      # Run on connected device
flutter build apk                # Android release
flutter build ipa                # iOS release
```

---

## 📦 Dependencies
| Package | Version | Purpose |
|---|---|---|
| flutter_riverpod | ^2.6.1 | State management |
| shared_preferences | ^2.3.2 | Local persistence |
| confetti | ^0.7.0 | Celebration effect |
| flutter_haptic_feedback | ^1.0.0 | Mobile haptics |

---

"High-stakes engineering for high-stakes focus."
