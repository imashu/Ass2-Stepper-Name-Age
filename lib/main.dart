import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  List<Step>? _steps;
  int? _current;
  TextEditingController? _name;
  TextEditingController? _age;
  String? _nameDisplay;
  String? _ageDisplay;

  @override
  void initState() {
    super.initState();
    _current = 0;
    _name = TextEditingController();
    _age = TextEditingController();
  }

  void _stepContinue() {
    setState(() {
      _current = (_current! + 1);
      if (_current! >= _steps!.length) _current! + _steps!.length - 1;
      if (_current == 2) {
        _ageDisplay = _age!.text;
        _nameDisplay = _name!.text;
      }
    });
  }

  void _stepCancel() {
    setState(() {
      _current = (_current! - 1);
      if (_current! < 0) _current = 0;
    });
  }

  void _stepTap(int index) {
    setState(() {
      _current = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stepper Name and Age"),
      ),
      body: Container(
          padding: const EdgeInsets.all(32.0),
          child: Center(
              child: Stepper(
            type: StepperType.vertical,
            steps: _steps = <Step>[
              Step(
                  title: const Text('Step 1'),
                  isActive: true,
                  content: Column(
                    children: <Widget>[
                      TextField(
                        controller: _name,
                        decoration:
                            const InputDecoration(labelText: 'Enter your name'),
                      )
                    ],
                  )),
              Step(
                  title: const Text('Step 2'),
                  isActive: true,
                  content: Column(
                    children: <Widget>[
                      TextField(
                        controller: _age,
                        decoration:
                            const InputDecoration(labelText: 'Enter your age'),
                        keyboardType: TextInputType.number,
                      )
                    ],
                  )),
              Step(
                  title: const Text('Step 3'),
                  content: Column(
                    children: <Widget>[
                      const Text('You Entered:'),
                      Text('Your name is $_nameDisplay:'),
                      Text('Your age is $_ageDisplay:'),
                    ],
                  )),
            ],
            currentStep: _current!,
            onStepTapped: _stepTap,
            onStepContinue: _stepContinue,
            onStepCancel: _stepCancel,
          ))),
    );
  }
}
