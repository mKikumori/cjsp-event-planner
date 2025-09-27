import 'package:event_planner/view/launch/launch_view.dart';
import 'package:event_planner/view_model/auth/login_viewmodel.dart';
import 'package:event_planner/view_model/auth/password_reset_viewmodel.dart';
import 'package:event_planner/view_model/auth/registration_viewmodel.dart';
import 'package:event_planner/view_model/core/home_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:event_planner/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => ThemeProvider()),
                ChangeNotifierProvider(create: (_) => LoginViewModel()),
                ChangeNotifierProvider(create: (_) => RegistrationViewModel()),
                ChangeNotifierProvider(create: (_) => HomeViewModel()),
                ChangeNotifierProvider(create: (_) => PasswordResetViewModel()),
              ],
              child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return CupertinoApp(
                    title: 'Event Planner',
                    theme: CupertinoThemeData(
                      brightness: themeProvider.brightness,
                    ),
                    home: const LaunchView(),
                  );
                },
              ),
            );
          }
          return Center(
            child: Image.asset(
              'assets/animations/music_icon.gif',
              width: 100,
              height: 100,
            ),
          );
        });
  }
}
