import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:math';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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
  final List<String> _stateTypeList = ["done", "not yet"];
  final List<Word> _wordList = [];

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(widget.title),
    );
  }

  Widget _buildBody() {
    return Center(
      child: _buildRandomEnglishWordListView(),
    );
  }

  Widget _buildRandomEnglishWordListView() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      itemBuilder: (context, index) =>
          _buildRandomEnglishWordDismissibleCard(index),
    );
  }

  Widget _buildDismissibleCardBackground(AlignmentGeometry align) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: const Text(
          'remove',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 3.0),
        ),
        alignment: align,
        color: Colors.red);
  }

  Widget _buildRandomEnglishWordDismissibleCard(int index) {
    _addWordListUntilIndex(index);
    return Dismissible(
      key: Key(_wordList[index].word),
      background: _buildDismissibleCardBackground(Alignment.centerLeft),
      secondaryBackground:
          _buildDismissibleCardBackground(Alignment.centerRight),
      child: Card(
          child: ListTile(
        title: Text(_wordList[index].word),
        subtitle: Text(_wordList[index].status),
        trailing: Icon(
          _wordList[index].isSaved ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ),
        onTap: () {
          setState(() {
            _wordList[index].isSaved = !_wordList[index].isSaved;
          });
        },
        onLongPress: () {},
      )),
      onDismissed: (dir) {
        setState(() {
          _wordList.removeAt(index);
        });
      },
    );
  }

  void _addWordListUntilIndex(int index) {
    while (index >= _wordList.length) {
      generateWordPairs().take(10).forEach((element) {
        _wordList.add(Word(element.asPascalCase,
            status_: _stateTypeList[Random().nextInt(_stateTypeList.length)]));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}

class Word {
  final String _word;
  String status = "not yet";
  bool isSaved = false;

  Word(String word_, {String status_ = "not yet", bool isSaved_ = false})
      : status = status_,
        isSaved = isSaved_,
        _word = word_;

  String get word {
    return _word;
  }
}
