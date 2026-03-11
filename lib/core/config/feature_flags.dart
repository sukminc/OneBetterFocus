/// Feature flags for freemium gating.
/// Set via remote config or local override in Phase 3.
class FeatureFlags {
  FeatureFlags._();

  /// Premium: allow custom work/break durations.
  static const bool customTimeSets = false;

  /// Premium: allow custom reflection prompts & emoji sets.
  static const bool customReflection = false;

  /// Premium: advanced session analytics & heatmap.
  static const bool advancedAnalytics = false;
}
