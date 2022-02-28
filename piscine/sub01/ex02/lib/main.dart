import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:math';

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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ex02'),
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
  List<String> _wordList = <String>[];
  final _statTypeList = ['done', 'do not yet'];
  int _cnt = 0;

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(widget.title + " - " + _cnt.toString()),
      backgroundColor: Colors.yellow,
      foregroundColor: Colors.black,
    );
  }

  Widget _buildBody() {
    return Center(
      child: _listView(),
    );
  }

  Widget _listElement(int index) {
    while (index >= _wordList.length) {
      generateWordPairs().take(10).forEach((element) {
        _wordList.add(element.asPascalCase);
      });
    }
    return Card(
      child: ListTile(
        title: Text(_wordList[index]),
        subtitle: Text(_statTypeList[Random().nextInt(_statTypeList.length)]),
        trailing: const Icon(
          Icons.favorite_border,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _listView() {
    return ListView.builder(
      padding: const EdgeInsets.all(20.0),
      itemBuilder: (context, index) {
        return _listElement(index);
      },
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
