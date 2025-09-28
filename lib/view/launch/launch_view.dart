import 'package:event_planner/view/auth/login_view.dart';
import 'package:event_planner/view/auth/register_view.dart';
import 'package:event_planner/widgets/background_widget.dart';
import 'package:event_planner/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';

// Reusable text style function
TextStyle _textStyle({
  Color color = CupertinoColors.white,
  double fontSize = 17,
  FontWeight fontWeight = FontWeight.w400,
  double height = 0.08,
  double letterSpacing = -0.43,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    height: height,
    letterSpacing: letterSpacing,
  );
}

class LaunchView extends StatelessWidget {
  const LaunchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title Text
            Text(
              'CJSP Event Planner',
              style: _textStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 35),
            // Subtitle Text
            Text(
              'Organize your events effortlessly',
              style: _textStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 50),
            // Log in button
            CustomButtonWidget(
                text: 'Login', width: 200, nextPage: const LoginView()),
            SizedBox(height: 20),
            // Register button
            CustomTransparentButton(
                text: 'Register', width: 200, nextPage: const RegisterView()),
          ],
        ),
      ),
    );
  }
}
