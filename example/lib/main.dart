import 'package:flutter/material.dart';
import 'package:single_centered_multi_child_layout/single_centered_multi_child_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(Object context) {
    return SingleCenteredMultiChildLayout(
      Container(
        color: Colors.amber,
        width: 500,
        height: 500,
      ),
      topGap: 10,
      topWidget: Container(
        color: Colors.red,
        width: 100,
        height: 200,
      ),
      leftGap: 30,
      leftWidget: Container(
        color: Colors.blue,
        width: 100,
        height: 100,
      ),
      rightGap: 10,
      rightWidget: Container(
        color: Colors.green,
        width: 200,
        height: 100,
      ),
      bottomGap: 10,
      bottomWidget: Container(
        color: Colors.black,
        width: 200,
        height: 300,
      ),
    );
  }
}
