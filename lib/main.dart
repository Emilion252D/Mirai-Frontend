import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/mirai_theme.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MiraiApp());
}

class MiraiApp extends StatelessWidget {
  const MiraiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mirai',
      debugShowCheckedModeBanner: false,
      theme: MiraiTheme.theme,
      home: const HomeScreen(),
    );
  }
}
