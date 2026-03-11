import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/app_theme.dart';
import 'features/milestones/providers/milestone_provider.dart';
import 'features/timer/widgets/focus_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
  ));

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const BetterFocusApp(),
    ),
  );
}

class BetterFocusApp extends StatelessWidget {
  const BetterFocusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '1% Better',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const FocusScreen(),
    );
  }
}
