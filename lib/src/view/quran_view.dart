import 'package:flutter/material.dart';

/// [QuranView]
class QuranView extends StatelessWidget {
  /// [QuranView] constructor
  const QuranView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (context, index) {
        return Container();
      },
    );
  }
}
