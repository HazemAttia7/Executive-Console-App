import 'package:flutter/material.dart';
import 'core/di/di_setup.dart';
import 'features/executive_console/presentation/screens/executive_console_screen.dart';
import 'core/theme/app_tokens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();
  runApp(const ExecutiveConsoleApp());
}

class ExecutiveConsoleApp extends StatelessWidget {
  const ExecutiveConsoleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Executive Console',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const ExecutiveConsoleScreen(),
    );
  }
}
