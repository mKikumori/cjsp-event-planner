import 'package:flutter/cupertino.dart';

class LogoTitleWidget extends StatelessWidget {
  final double iconSize;
  final double fontSize;
  final MainAxisAlignment alignment;

  const LogoTitleWidget({
    super.key,
    this.iconSize = 40,
    this.fontSize = 28,
    this.alignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        Image.asset(
          'assets/images/clave_de_sol.jpg',
          width: iconSize,
          height: iconSize,
        ),
        const SizedBox(width: 8),
        Text(
          'Coral CJSP',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: CupertinoColors.white,
          ),
        ),
      ],
    );
  }
}
