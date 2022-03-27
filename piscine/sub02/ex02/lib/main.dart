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
        primaryColorDark: Colors.black,
      ),
      home: const MyHomePage(title: 'Fluent Gauage'),
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
  double numValue = 0.0;
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(widget.title),
      backgroundColor: const Color.fromARGB(255, 94, 93, 93),
      centerTitle: false,
    );
  }

  Widget _buildBody() {
    return Center(
      child: Container(
        color: const Color.fromARGB(255, 58, 58, 58),
        child: Column(
          children: [
            SfRadialGauge(axes: <RadialAxis>[
              RadialAxis(
                axisLineStyle: const AxisLineStyle(color: Colors.white),
                majorTickStyle: const MajorTickStyle(color: Colors.white),
                minorTickStyle: const MinorTickStyle(color: Colors.white),
                axisLabelStyle: const GaugeTextStyle(color: Colors.white),
                minimum: 0,
                maximum: 150,
                ranges: <GaugeRange>[
                  GaugeRange(startValue: 0, endValue: 50, color: Colors.green),
                  GaugeRange(
                      startValue: 50, endValue: 100, color: Colors.orange),
                  GaugeRange(startValue: 100, endValue: 150, color: Colors.red)
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(
                    enableAnimation: true,
                    value: numValue,
                    needleColor: Colors.white,
                    knobStyle: const KnobStyle(color: Colors.white),
                  )
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Container(
                          child: Text(numValue.toString(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                      angle: 90,
                      positionFactor: 0.7)
                ],
              )
            ]),
            Slider(
              value: numValue,
              divisions: 1500,
              max: 150,
              label: numValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  value = (value * 10).roundToDouble() / 10;
                  numValue = value;
                });
              },
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
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
