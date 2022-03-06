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
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(
        title: 'First Page',
        subtitle: 'Go to Second Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  final String title;
  final String subtitle;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(widget.title),
      centerTitle: false,
    );
  }

  Widget _buildBody() {
    return Center(
      child: TextButton(
        child: Text(widget.subtitle),
        onPressed: () {
          if (widget.title == "First Page") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                        title: 'Second Page', subtitle: 'Go to First Page')));
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}
