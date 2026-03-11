import 'package:shared_preferences/shared_preferences.dart';

/// Local-first persistence layer.
/// Designed to be replaced/extended with Supabase sync in Phase 2.
class SessionStorage {
  static const _keyTotalSessions = 'total_sessions';
  static const _keyCurrentStreak = 'current_streak';
  static const _keyLastSessionDate = 'last_session_date';

  final SharedPreferences _prefs;

  SessionStorage(this._prefs);

  int get totalSessions => _prefs.getInt(_keyTotalSessions) ?? 0;
  int get currentStreak => _prefs.getInt(_keyCurrentStreak) ?? 0;
  String? get lastSessionDate => _prefs.getString(_keyLastSessionDate);

  Future<void> recordSession() async {
    final today = _todayKey();
    final last = lastSessionDate;

    await _prefs.setInt(_keyTotalSessions, totalSessions + 1);

    if (last == null) {
      await _prefs.setInt(_keyCurrentStreak, 1);
    } else if (_isYesterday(last, today)) {
      await _prefs.setInt(_keyCurrentStreak, currentStreak + 1);
    } else if (last != today) {
      // Streak broken
      await _prefs.setInt(_keyCurrentStreak, 1);
    }
    // Same day: streak unchanged, just increment total.

    await _prefs.setString(_keyLastSessionDate, today);
  }

  Future<void> clear() async {
    await _prefs.remove(_keyTotalSessions);
    await _prefs.remove(_keyCurrentStreak);
    await _prefs.remove(_keyLastSessionDate);
  }

  String _todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  bool _isYesterday(String last, String today) {
    final lastDate = DateTime.parse(last);
    final todayDate = DateTime.parse(today);
    return todayDate.difference(lastDate).inDays == 1;
  }
}
