// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Converter',
      home: TemperatureConverterPage(),
    );
  }
}

class TemperatureConverterPage extends StatefulWidget {
  @override
  _TemperatureConverterPageState createState() =>
      _TemperatureConverterPageState();
}

class _TemperatureConverterPageState extends State<TemperatureConverterPage> {
  double _inputTemperature = 0.0;
  double _convertedTemperature = 0.0;
  String _conversionType = 'f-to-c';
  List<String> _conversionHistory = [];
  final _inputController = TextEditingController();
  final _outputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  void _convertTemperature() {
    if (_conversionType == 'f-to-c') {
      _convertedTemperature = ((_inputTemperature - 32) * 5 / 9).toDouble();
    } else {
      _convertedTemperature = ((_inputTemperature * 9 / 5) + 32).toDouble();
    }

    String conversionDescription;
    if (_conversionType == 'f-to-c') {
      conversionDescription =
          'F to C: ${_inputTemperature.toStringAsFixed(1)} = ${_convertedTemperature.toStringAsFixed(1)}';
    } else {
      conversionDescription =
          'C to F: ${_inputTemperature.toStringAsFixed(1)} = ${_convertedTemperature.toStringAsFixed(1)}';
    }

    setState(() {
      _conversionHistory.add(conversionDescription);
      _outputController.text = _convertedTemperature.toStringAsFixed(1);
      _inputController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Temperature Converter',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 120, 86, 167),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 170, 179, 104),
              Color.fromARGB(255, 148, 69, 147),
              Color.fromARGB(255, 75, 154, 219),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Positioned(
                top: 100,
                right: -20,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.9),
                  ),
                ),
              ),
              Positioned(
                bottom: -20,
                left: -20,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 'f-to-c',
                        groupValue: _conversionType,
                        onChanged: (value) {
                          setState(() {
                            _conversionType = value!;
                          });
                        },
                      ),
                      const Text('Fahrenheit to Celsius'),
                      const SizedBox(width: 16.0),
                      Radio(
                        value: 'c-to-f',
                        groupValue: _conversionType,
                        onChanged: (value) {
                          setState(() {
                            _conversionType = value!;
                          });
                        },
                      ),
                      const Text('Celsius to Fahrenheit'),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 40,
                        child: TextField(
                          controller: _inputController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter Value',
                            filled: true,
                            fillColor: Colors.grey[400],
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _inputTemperature = double.parse(value);
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      const Text('=',
                          style: TextStyle(
                            fontSize: 26.0,
                          )),
                      const SizedBox(width: 16.0),
                      Container(
                        width: 150,
                        height: 40,
                        child: TextField(
                          controller: _outputController,
                          enabled: false,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[400],
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            hintText: '',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Center(
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _convertTemperature,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        child: const Text(
                          'CONVERT',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        itemCount: _conversionHistory.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_conversionHistory[index],
                                style: const TextStyle(color: Colors.black)),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
