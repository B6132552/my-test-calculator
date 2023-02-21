// ignore_for_file: prefer_interpolation_to_compose_strings, unrelated_type_equality_checks

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CACULATOR',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Prompt'),
      home: const CalculatorPage(
        title: 'Calculator',
      ),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key, required this.title});

  final String title;

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String answer = "0";
  String answerTemp = "";
  String inputFull = "";
  String operator = "";
  bool calculateMode = false;

  @override
  void initState() {
    super.initState();
  }

  void clearAnswer() {
    setState(() {
      answer = "0";
    });
  }

  void clearAll() {
    setState(() {
      answer = "0";
      inputFull = "";
      calculateMode = false;
      operator = "";
    });
  }

  void removeAnswerLast() {
    if (answer == "0") {
    } else {
      setState(() {
        if (answer.length > 1) {
          answer = answer.substring(0, answer.length - 1);
          if (answer.length == 1 && (answer == "." || answer == "-")) {
            answer = "0";
          }
        } else {
          answer = "0";
        }
      });
    }
  }

  void addOperatorToAnswer(String op) {
    setState(() {
      if (answer != "0" && !calculateMode) {
        calculateMode = true;
        answerTemp = answer;
        inputFull += operator + " " + answerTemp;
        operator = op;
        answer = op != "%" ? "0" : "100";
        if (op == "%") {
          calculate();
        }
      } else if (calculateMode) {
        if (answer.isNotEmpty) {
          calculate();
          answerTemp = answer;
          inputFull = "";
          operator = "";
        } else {
          operator = op;
        }
      }
    });
  }

  void calculate() {
    setState(() {
      if (calculateMode) {
        bool decimalMode = false;
        double value = 0;

        if (answer.contains(".") ||
            answerTemp.contains(".") ||
            operator == "%") {
          decimalMode = true;
        }

        if (operator == "+") {
          value = (double.parse(answerTemp) + double.parse(answer));
        } else if (operator == "-") {
          value = (double.parse(answerTemp) - double.parse(answer));
        } else if (operator == "×") {
          value = (double.parse(answerTemp) * double.parse(answer));
        } else if (operator == "÷") {
          value = (double.parse(answerTemp) / double.parse(answer));
        } else if (operator == "%") {
          value = (double.parse(answerTemp) / 100);
        }

        if (!decimalMode) {
          answer = value.toInt().toString();
        } else {
          answer = value.toString();
        }

        calculateMode = false;
        operator = "";
        answerTemp = "";
        inputFull = "";
      }
    });
  }

  void addNumberToAnswer(int number) {
    setState(() {
      if (number == 0 && answer == "0") {
      } else if (number != 0 && answer == "0") {
        answer = number.toString();
      } else {
        answer += number.toString();
      }
    });
  }

  void toggleNegative() {
    setState(() {
      if (answer.contains("-")) {
        answer = answer.replaceAll("-", "");
      } else {
        answer = "-" + answer;
      }
    });
  }

  void addDotToAnswer() {
    setState(() {
      if (!answer.contains(".")) {
        answer = answer + ".";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF36474f),
        title: Text(widget.title,
            style: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 30,
                fontFamily: 'Prompt')),
        elevation: 0,
      ),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [buildAnswerWidget(), buildNumPadWidget()]),
    );
  }

  Widget buildAnswerWidget() {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFF36474f),
            child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      operator != "%"
                          ? Text(inputFull + " " + operator,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white))
                          : Container(),
                      Text(answer,
                          style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w200,
                              color: Colors.white))
                    ]))));
  }

  Widget buildNumPadWidget() {
    return Container(
      color: const Color(0xFF18202a),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              buildNumberButton(
                "C",
                onTap: () {
                  clearAll();
                },
              ),
              buildNumberButton("⌫", onTap: () {
                removeAnswerLast();
              }),
              buildNumberButton(
                "%",
                onTap: () {
                  addOperatorToAnswer("%");
                },
              ),
              buildNumberButton("÷", numberButton: false, onTap: () {
                addOperatorToAnswer("÷");
              }),
            ],
          ),
          Row(
            children: [
              buildNumberButton(
                "7",
                onTap: () {
                  addNumberToAnswer(7);
                },
              ),
              buildNumberButton(
                "8",
                onTap: () {
                  addNumberToAnswer(8);
                },
              ),
              buildNumberButton("9", onTap: () {
                addNumberToAnswer(9);
              }),
              buildNumberButton("x", numberButton: false, onTap: () {
                addOperatorToAnswer("×");
              }),
            ],
          ),
          Row(
            children: [
              buildNumberButton(
                "4",
                onTap: () {
                  addNumberToAnswer(4);
                },
              ),
              buildNumberButton(
                "5",
                onTap: () {
                  addNumberToAnswer(5);
                },
              ),
              buildNumberButton("6", onTap: () {
                addNumberToAnswer(6);
              }),
              buildNumberButton("-", numberButton: false, onTap: () {
                addOperatorToAnswer("-");
              }),
            ],
          ),
          Row(
            children: [
              buildNumberButton(
                "1",
                onTap: () {
                  addNumberToAnswer(1);
                },
              ),
              buildNumberButton(
                "2",
                onTap: () {
                  addNumberToAnswer(2);
                },
              ),
              buildNumberButton("3", onTap: () {
                addNumberToAnswer(3);
              }),
              buildNumberButton("+", numberButton: false, onTap: () {
                addOperatorToAnswer("+");
              }),
            ],
          ),
          Row(
            children: [
              buildNumberButton(
                "±",
                onTap: () {
                  toggleNegative();
                },
              ),
              buildNumberButton(
                "0",
                onTap: () {
                  addNumberToAnswer(0);
                },
              ),
              buildNumberButton(".", onTap: () {
                addDotToAnswer();
              }),
              buildNumberButton("=", numberButton: false, onTap: () {
                calculate();
              }),
            ],
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  Widget buildNumberButton(String str,
      {required Function() onTap, bool numberButton = true}) {
    Widget widget;
    if (numberButton) {
      widget = Material(
          color: const Color(0xFF18202a),
          child: InkWell(
              onTap: onTap,
              // splashColor: const Color.fromARGB(255, 114, 115, 116),
              child: SizedBox(
                  height: 70,
                  child: Center(
                      child: Text(str,
                          style: const TextStyle(
                              fontSize: 30,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Prompt'))))));
    } else {
      widget = Container(
          margin: const EdgeInsets.all(1),
          child: Material(
              color: const Color(0xFF18202a),
              child: InkWell(
                  onTap: onTap,
                  // splashColor: const Color.fromARGB(255, 172, 172, 172),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        height: 75,
                        decoration: BoxDecoration(
                            color: str == '='
                                ? const Color(0xFFff6531)
                                : Colors.white,
                            shape: BoxShape.circle),
                        child: Center(
                            child: Text(str,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Prompt',
                                    color: str == '='
                                        ? Colors.white
                                        : Colors.black)))),
                  ))));
    }

    return Expanded(child: widget);
  }
}
