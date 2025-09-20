import 'package:flutter/cupertino.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final brightness = CupertinoTheme.of(context).brightness;

    final gradientColors = brightness == Brightness.dark
        ? [
            const Color(0xFF0F2027),
            const Color(0xFF203A43),
            const Color(0xFF2C5364),
          ]
        : [
            const Color.fromARGB(255, 128, 199, 197),
            const Color.fromARGB(255, 65, 66, 104),
          ];

    return CupertinoPageScaffold(
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
            tileMode: TileMode.mirror,
          ),
        ),
        child: SafeArea(
          child: child,
        ),
      ),
    );
  }
}
