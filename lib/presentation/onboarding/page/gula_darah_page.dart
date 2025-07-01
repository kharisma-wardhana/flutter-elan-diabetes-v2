import 'package:flutter/material.dart';

class GulaDarahPage extends StatefulWidget {
  const GulaDarahPage({super.key});

  @override
  State<GulaDarahPage> createState() => _GulaDarahPageState();
}

class _GulaDarahPageState extends State<GulaDarahPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Gula Darah')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hasil pemeriksaan gula darah Anda:'),
              const SizedBox(height: 16.0),
              Text('Gula darah Anda berada dalam rentang normal.'),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
