import 'package:flutter/widgets.dart';

class ProfilData extends StatelessWidget {
  final String title;
  final String content;
  const ProfilData({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title), Text(content)],
    );
  }
}
