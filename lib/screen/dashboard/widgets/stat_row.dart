import 'package:flutter/material.dart';
class StatRow extends StatelessWidget {
  final List<Widget> children;

  const StatRow({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
