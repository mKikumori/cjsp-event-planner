/*
=====================================================
CUSTOM BUTTON COMPONENTS FOR NAVIGATION
=====================================================

This file provides reusable button components for navigation 
and UI styling in a Flutter app using Cupertino widgets.

Button Types:
1. CustomButton - Standard button with navigation options.
2. CustomTransparentButton - Transparent button for subtle UI elements.

Usage:
--------------------------------
Navigate to a new page:
CustomButton(
  text: "Go to Details",
  nextPage: DetailsView(),
  width: 200,
),

Go back to the previous page:
CustomButton(
  text: "Go Back",
  shouldPop: true,
  width: 200,
),

Button with Icon:
CustomButtonWidget(
  text: "Button with Icon",
  width: 200,
  hasIcon: true,
  icon: CupertinoIcons.person,
)


Use accent style (purple background, white text):
CustomButton(
  text: "Accent Button",
  width: 200,
  accent: true, // Enables purple background
),

Use default style (white background, purple text):
CustomButton(
  text: "Default Button",
  width: 200,
),

=====================================================
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

/// Returns a reusable text style with configurable properties.
TextStyle _textStyle({
  Color color = CupertinoColors.white,
  double fontSize = 17, // iOS standard button font size
  FontWeight fontWeight = FontWeight.w600, // Semi-bold for clarity
  double height = 1.2,
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

/// Handles navigation logic for both push (next page) and pop (go back).
void handleNavigation(BuildContext context,
    {Widget? nextPage, bool shouldPop = false}) {
  print("Navigating to next page: $nextPage");

  if (shouldPop) {
    Navigator.pop(context); // Navigate back
  } else if (nextPage != null) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => nextPage),
    );
  }
}

/// A customizable button with an optional accent color.
class CustomButtonWidget extends StatelessWidget {
  final String text;
  final Widget? nextPage;
  final double width;
  final bool shouldPop;
  final bool accent;
  final VoidCallback? onPressed;
  final bool hasIcon;
  final IconData? icon;
  final double iconSize;
  final Color? iconColor;
  final double iconSpace;

  const CustomButtonWidget(
      {super.key,
      required this.text,
      this.nextPage,
      required this.width,
      this.shouldPop = false,
      this.accent = false,
      this.onPressed,
      this.hasIcon = false,
      this.icon,
      this.iconSize = 25,
      this.iconColor,
      this.iconSpace = 25});

  @override
  Widget build(BuildContext context) {
    final brightness = CupertinoTheme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final textColor = accent
        ? CupertinoColors.white
        : isDark
            ? const Color(0xFF0F2027)
            : const Color.fromARGB(255, 65, 66, 104);

    return SizedBox(
        width: width,
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 0, 0),
            borderRadius: BorderRadius.circular(8),
            border: accent
                ? Border.all(width: 2, color: CupertinoColors.white)
                : null,
          ),
          child: CupertinoButton(
            onPressed: () {
              print('CustomButton pressed');
              if (onPressed != null) {
                onPressed!();
              }
              handleNavigation(context,
                  nextPage: nextPage, shouldPop: shouldPop);
            },
            color: accent
                ? isDark
                    ? const Color(0xFF0F2027)
                    : const Color.fromARGB(255, 65, 66, 104)
                : CupertinoColors.white,
            borderRadius: BorderRadius.circular(8),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisSize: hasIcon ? MainAxisSize.max : MainAxisSize.min,
              children: [
                if (hasIcon && icon != null) ...[
                  SizedBox(width: 30),
                  Icon(
                    icon,
                    size: iconSize,
                    color: iconColor ?? textColor,
                  ),
                  SizedBox(width: iconSpace),
                ],
                Text(
                  text,
                  style: _textStyle(color: textColor),
                ),
              ],
            ),
          ),
        ));
  }
}

/// A transparent button with navigation capability.
class CustomTransparentButton extends StatelessWidget {
  final String text;
  final Widget? nextPage;
  final double width;
  final bool shouldPop;
  final VoidCallback? onPressed;

  const CustomTransparentButton({
    super.key,
    required this.text,
    this.nextPage,
    required this.width,
    this.shouldPop = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: CupertinoButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed!(); // Execute custom function if provided
          }
          handleNavigation(context, nextPage: nextPage, shouldPop: shouldPop);
        },
        padding: const EdgeInsets.symmetric(vertical: 12),
        borderRadius: BorderRadius.circular(8),
        child: Text(
          text,
          style: _textStyle(), // No redundant parameters
        ),
      ),
    );
  }
}
