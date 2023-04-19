import 'package:calculator/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          inputUser,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: textGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          result,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: textGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 62,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _getRow('ac', 'ce', '%', '/'),
                      _getRow('7', '8', '9', '*'),
                      _getRow('4', '5', '6', '-'),
                      _getRow('1', '2', '3', '+'),
                      _getRow('00', '0', '.', '='),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getRow(
    String text1,
    String text2,
    String text3,
    String text4,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            shape: const CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            backgroundColor: getBackgroundColor(text1),
          ),
          onPressed: () {
            // if(text1.contains('%%') && text1.contains('%%')){}
            if (text1 == 'ac') {
              setState(() {
                inputUser = '';
                result = '';
              });
            } else {
              buttonPressed(text1);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text1,
              style: TextStyle(
                fontSize: 28,
                color: getForgroundColor(text1),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: const CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            backgroundColor: getBackgroundColor(text2),
          ),
          onPressed: () {
            if (text2 == 'ce') {
              if (inputUser.isNotEmpty) {
                setState(() {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                });
              }
            } else {
              buttonPressed(text2);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text2,
              style: TextStyle(
                fontSize: 28,
                color: getForgroundColor(text2),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: const CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            backgroundColor: getBackgroundColor(text3),
          ),
          onPressed: () {
            buttonPressed(text3);
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text3,
              style: TextStyle(
                fontSize: 28,
                color: getForgroundColor(text3),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: const CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            backgroundColor: getBackgroundColor(text4),
          ),
          onPressed: () {
            if (text4 == '=') {
              if (inputUser.isNotEmpty) {
                try {
                  Parser parser = Parser();
                  Expression expression = parser.parse(inputUser);
                  ContextModel contextModel = ContextModel();
                  double eval =
                      expression.evaluate(EvaluationType.REAL, contextModel);
                  setState(() {
                    result = eval.toStringAsFixed(2);
                  });
                } catch (e) {
                  setState(() {
                    result = '';
                    inputUser = '';
                  });
                }
              } else {
                setState(() {
                  result = '';
                });
              }
            } else {
              buttonPressed(text4);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text4,
              style: TextStyle(
                fontSize: 28,
                color: getForgroundColor(text4),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  bool isOperator(String text) {
    List<String> operator = <String>[
      'ac',
      'ce',
      '%',
      '/',
      '*',
      '-',
      '+',
      '=',
    ];
    for (String item in operator) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color getBackgroundColor(String text) {
    if (isOperator(text)) {
      return backgroundGreyDark;
    } else {
      return backgroundGrey;
    }
  }

  Color getForgroundColor(String text) {
    if (isOperator(text)) {
      return textGreen;
    } else {
      return textGrey;
    }
  }

  String inputUser = '';
  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  String result = '';
}
