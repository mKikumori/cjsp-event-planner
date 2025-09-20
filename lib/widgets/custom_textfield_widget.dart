import 'package:flutter/cupertino.dart';

TextStyle _textStyle({
  Color color = CupertinoColors.white,
  double fontSize = 17,
  FontWeight fontWeight = FontWeight.w400,
  double height = 1.0,
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

BoxDecoration _cupertinoDecoration() {
  return BoxDecoration(
    color: CupertinoColors.systemGrey.withOpacity(0.3),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: CupertinoColors.white, width: 2.0),
  );
}

/// A reusable Cupertino-style text field with a placeholder and optional prefix.
class CustomTextfieldWidget extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final Widget? prefix;
  final void Function(String)? onChanged;

  const CustomTextfieldWidget({
    super.key,
    required this.text,
    required this.controller,
    this.prefix,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: CupertinoTextField(
        controller: controller,
        placeholder: text,
        placeholderStyle:
            _textStyle(color: CupertinoColors.white.withOpacity(0.7)),
        style: _textStyle(color: CupertinoColors.white),
        decoration: _cupertinoDecoration(),
        padding: const EdgeInsets.all(12),
        prefix: prefix != null
            ? Padding(
                padding: const EdgeInsets.only(left: 12),
                child: prefix,
              )
            : null, // optional prefix
        onChanged: onChanged,
      ),
    );
  }
}

/// A reusable Cupertino-style password field with obscured text.
class CustomTextPswfield extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const CustomTextPswfield({
    super.key,
    required this.text,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: CupertinoTextField(
        controller: controller,
        placeholder: text,
        placeholderStyle:
            _textStyle(color: CupertinoColors.white.withOpacity(0.7)),
        style: _textStyle(color: CupertinoColors.white),
        obscureText: true,
        decoration: _cupertinoDecoration(),
        padding: const EdgeInsets.all(12),
        onChanged: onChanged,
      ),
    );
  }
}

class CustomTextfieldErrorWidget extends StatelessWidget {
  final String? error;

  const CustomTextfieldErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    if (error == null) return const SizedBox.shrink();

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            error!,
            style: const TextStyle(
              color: CupertinoColors.systemRed,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
