import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NumberList(),
    );
  }
}

class NumberList extends StatelessWidget {
  const NumberList({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    int columns = isLandscape ? 2 : 1;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey[200],
          title: Center(child: Text("Classwork 3 (Making a Responsive List)"))),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          childAspectRatio: 7,
        ),
        itemCount: 20,
        itemBuilder: (context, index) => NumberItem(number: index + 1),
      ),
    );
  }
}

class NumberItem extends StatelessWidget {
  final int number;
  const NumberItem({required this.number});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal,
      margin: const EdgeInsets.all(8),
      child: Center(
        child: Text(
          "Number $number",
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
