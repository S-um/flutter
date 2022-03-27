import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
      home: const MyHomePage(title: 'BMI Calculator'),
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
  double _height = 0;
  double _weight = 0;
  bool _isErrored = false;
  String _weightType = "digit";

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(widget.title),
      centerTitle: false,
    );
  }

  Widget _buildBody() {
    return Center(
        child: SingleChildScrollView(
            child: Padding(
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: TextFormField(
                keyboardType: TextInputType.number,
                onSaved: (height) {
                  _height = double.parse(height!);
                },
                validator: (height) {
                  if (height == null || height.isEmpty && !_isErrored) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Error')));
                    _isErrored = true;
                    return "Input Height";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Input Height(cm)",
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: TextFormField(
                obscureText: _weightType == "****",
                obscuringCharacter: "*",
                keyboardType: TextInputType.number,
                onSaved: (weight) {
                  _weight = double.parse(weight!);
                },
                validator: (weight) {
                  if (weight == null || weight.isEmpty && !_isErrored) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Error')));
                    _isErrored = true;
                    return "Input Weight";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Input Weight(kg)",
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Switch(
                value: _weightType == "****",
                onChanged: (value) {
                  setState(() {
                    if (value) {
                      _weightType = "****";
                    } else {
                      _weightType = "digit";
                    }
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              alignment: Alignment.centerLeft,
              child: Text("Weight:" + _weightType),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: ElevatedButton(
                onPressed: () {
                  _isErrored = false;
                  if (formKey.currentState!.validate()) {
                    /*
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Height : ' +
                            _height.toString() +
                            '| Weight' +
                            _weight.toString())));
                            */
                    formKey.currentState!.save();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BmiResult(
                                title: "BMI Result",
                                bmiNum: (_weight /
                                    (_height / 100 * _height / 100)))));
                  }
                },
                child: const Text('Check In'),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50)),
              ),
            ),
          ],
        ),
      ),
      padding: const EdgeInsets.all(20.0),
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}

class BmiResult extends StatelessWidget {
  final double bmiNum;
  final String title;
  const BmiResult({Key? key, required this.title, required this.bmiNum})
      : super(key: key);

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(title),
      centerTitle: false,
    );
  }

  Widget _buildBody() {
    return Center(
      child: SfRadialGauge(
          enableLoadingAnimation: true,
          animationDuration: 2000,
          axes: <RadialAxis>[
            RadialAxis(
              axisLineStyle: const AxisLineStyle(color: Colors.white),
              majorTickStyle: const MajorTickStyle(color: Colors.white),
              minorTickStyle: const MinorTickStyle(color: Colors.white),
              minimum: 0,
              maximum: 45,
              ranges: <GaugeRange>[
                GaugeRange(
                  startValue: 0,
                  endValue: 18.5,
                  color: Colors.lightBlue,
                  label: "저체중",
                  labelStyle: const GaugeTextStyle(color: Colors.white),
                ),
                GaugeRange(
                  startValue: 18.6,
                  endValue: 23,
                  color: Colors.green,
                  label: "정상",
                  labelStyle: const GaugeTextStyle(color: Colors.white),
                ),
                GaugeRange(
                  startValue: 23.1,
                  endValue: 25,
                  color: Colors.orange,
                  label: "과체중",
                  labelStyle: const GaugeTextStyle(color: Colors.white),
                ),
                GaugeRange(
                  startValue: 25.1,
                  endValue: 45,
                  color: Colors.red,
                  label: "비만",
                  labelStyle: const GaugeTextStyle(color: Colors.white),
                ),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  enableAnimation: true,
                  value: bmiNum,
                  needleColor: Colors.black,
                  knobStyle: const KnobStyle(color: Colors.black),
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Container(
                        child: Text("BMI : " + bmiNum.toStringAsFixed(1),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    angle: 90,
                    positionFactor: 0.7)
              ],
            )
          ]),
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
