# CLAUDE.md — 1% Better Focus

## Repo Role

Supporting product in the main `1% Better` brand.

This is a small-focus-loop product:

- start a session
- complete a timer
- log a lightweight reflection
- preserve local progress

It supports the same simple-product thesis as `1% Better Today`.
It is not a poker repo.

## Repo Identity

- Repo: `sukminc/one-percent-better-focus`
- Landing slug: `onepercent-focus`
- Public role: supporting product, not primary hero

## Guardrails

- Keep the scope narrow and local-first.
- Preserve the repo's strongest signal: simple loop, understandable UX, quick iteration.
- Do not turn this into a broad productivity suite.
- Cloud sync, auth, and premium features are phase-two items, not the current story.

## Current Truth

Trust `README.md` for implemented features and status.

Current shape:

- Flutter app
- Riverpod state management
- local persistence via `shared_preferences`
- timer + milestones + reflection flow

## Source Of Truth

- Shared brand rules: `/Users/chrisyoon/GitHub/one-percent-better-os/brand.json`
- Shared project state: `/Users/chrisyoon/GitHub/one-percent-better-os/projects.json`
- Public profile story: `/Users/chrisyoon/GitHub/one-percent-better-os/public_profile.json`

## Commands

```bash
flutter pub get
flutter run
flutter run -d chrome
```
