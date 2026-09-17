import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: Practice()),
  );
}

class Practice extends StatelessWidget {
  const Practice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true, // Centers the title text horizontally
        title: const Text(
          'NAME SCREEN',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(child: Text('Gbagbeke Oghneovo Peter')),
    );
  }
}
