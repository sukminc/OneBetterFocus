import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/storage/session_storage.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Override in ProviderScope');
});

final sessionStorageProvider = Provider<SessionStorage>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SessionStorage(prefs);
});

class MilestoneState {
  final int totalSessions;
  final int currentStreak;

  const MilestoneState({
    this.totalSessions = 0,
    this.currentStreak = 0,
  });

  MilestoneState copyWith({int? totalSessions, int? currentStreak}) =>
      MilestoneState(
        totalSessions: totalSessions ?? this.totalSessions,
        currentStreak: currentStreak ?? this.currentStreak,
      );
}

class MilestoneNotifier extends Notifier<MilestoneState> {
  @override
  MilestoneState build() {
    final storage = ref.watch(sessionStorageProvider);
    return MilestoneState(
      totalSessions: storage.totalSessions,
      currentStreak: storage.currentStreak,
    );
  }

  Future<void> recordSession() async {
    final storage = ref.read(sessionStorageProvider);
    await storage.recordSession();
    state = state.copyWith(
      totalSessions: storage.totalSessions,
      currentStreak: storage.currentStreak,
    );
  }
}

final milestoneProvider =
    NotifierProvider<MilestoneNotifier, MilestoneState>(MilestoneNotifier.new);
