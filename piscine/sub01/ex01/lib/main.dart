import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('ex01'),
    );
  }

  Widget _buildBody() {
    return Center(
        child: Column(
      children: [
        Table(
          border: TableBorder.symmetric(
              inside: const BorderSide(width: 4, color: Colors.black)),
          children: [
            TableRow(children: [
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1),
                },
                children: const [
                  TableRow(children: [
                    Text(''),
                    Icon(Icons.star, size: 50.0),
                    Text('')
                  ]),
                  TableRow(children: [
                    Icon(Icons.star, size: 50.0),
                    Icon(Icons.star, size: 100.0),
                    Icon(Icons.star, size: 50.0),
                    // Text(''),
                  ]),
                  TableRow(children: [
                    Text(''),
                    Icon(Icons.star, size: 50.0),
                    Text('')
                  ]),
                ],
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              ),
              TableCell(
                child: Container(
                  color: Colors.blue,
                  height: 100,
                ),
                verticalAlignment: TableCellVerticalAlignment.top,
              ),
            ]),
            TableRow(children: [
              Column(
                children: [
                  Container(
                    height: 50,
                  ),
                  Container(height: 100, color: Colors.green),
                ],
              ),
              TableCell(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                      child: Container(
                        color: const Color.fromARGB(255, 255, 196, 0),
                        height: 50,
                        width: 150,
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )
            ]),
          ],
        ),
        Expanded(
          child: Container(color: Colors.yellow),
          flex: 2,
        ),
        Expanded(
          child: Container(color: Colors.brown),
          flex: 1,
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}
