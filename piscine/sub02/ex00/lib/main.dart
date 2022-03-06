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
      home: const MyHomePage(title: "Check In"),
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
  final formKey = GlobalKey<FormState>();
  String cardNum = "";

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(widget.title),
      centerTitle: false,
    );
  }

  Widget _buildBody() {
    return Center(
        child: Padding(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              onSaved: (cardNum) {
                this.cardNum = cardNum!;
              },
              validator: (cardNum) {
                if (cardNum == null || cardNum.isEmpty) {
                  return "입력이 올바르지 않습니다.";
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "카드 번호를 입력하세요.",
              ),
            ),
            const Divider(
              thickness: 1.0,
              height: 50.0,
              color: Colors.black,
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  String Message = "";
                  if (cardNum == "42") {
                    Message = "Success";
                  } else {
                    Message = "Check in failed";
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(Message),
                    duration: const Duration(milliseconds: 500),
                  ));
                }
            },
              child: const Text('Check In'),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
            )
          ],
        ),
      ),
      padding: const EdgeInsets.all(20.0),
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
