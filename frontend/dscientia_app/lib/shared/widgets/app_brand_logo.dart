import 'package:flutter/material.dart';

class AppBrandLogo extends StatelessWidget {
  const AppBrandLogo({super.key, this.height = 28});

  static const String assetPath = 'assets/branding/dscientia_logo.png';

  final double height;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      key: const Key('app-brand-logo'),
      label: 'DscienTia',
      image: true,
      child: Image.asset(
        assetPath,
        height: height,
        fit: BoxFit.contain,
        alignment: Alignment.centerLeft,
        filterQuality: FilterQuality.high,
        excludeFromSemantics: true,
      ),
    );
  }
}
