import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  int _counter = 41;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  PreferredSizeWidget _buildAppBar(Text title) {
    return AppBar(
      centerTitle: false,
      title: title,
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headline4,
          ),
          FloatingActionButton.extended(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            onPressed: () {
              setState(() {
                _counter++;
              });
              if (_counter == 42) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('This is State'), duration: Duration(seconds: 1),));
              }
            },
            tooltip: 'Increment',
            label: const Text('Add'),
            extendedPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(const Text('Stateless? or Stateful?')),
      body: _buildBody(),
    );
  }
}
