import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color backgroundColor = Colors.black87;
  Color appBarColor = Colors.grey.shade800;
  Color textColor = Colors.white;
  Color buttonColor = Colors.grey.shade800;
  Color operatorColor = Colors.grey.shade600;
  Color resultTextColor = Colors.deepPurpleAccent;

  String usertext = '';
  String result = '';

  final List<String> buttons = [
    'C', '^', '%', 'DEL', '1', '2', '3', '+', '4', '5', '6', '-', '7', '8',
    '9', '*', '0', '.', '=', '/'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: Text('Calculator',style: TextStyle(color: textColor),),
        ),
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(20),
                      child: Text(
                        usertext,
                        style: TextStyle(fontSize: 22, color: textColor),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        result,
                        style: TextStyle(fontSize: 35, color: resultTextColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return CircularButton(
                          buttonText: buttons[index],
                          color: buttonColor,
                          textColor: textColor,
                          onTap: () {
                            setState(() {
                              usertext = '';
                              result = '0';
                            });
                          },
                        );
                      } else if (index == 1) {
                        return CircularButton(
                          buttonText: buttons[index],
                          color: operatorColor,
                          textColor: textColor,
                          onTap: () {
                            setState(() {
                              usertext += buttons[index];
                            });
                          },
                        );
                      } else if (index == 2) {
                        return CircularButton(
                          buttonText: buttons[index],
                          color: operatorColor,
                          textColor: textColor,
                          onTap: () {
                            setState(() {
                              usertext += buttons[index];
                            });
                          },
                        );
                      } else if (index == 3) {
                        return CircularButton(
                          buttonText: buttons[index],
                          color: operatorColor,
                          textColor: textColor,
                          onTap: () {
                            setState(() {
                              usertext =
                                  usertext.substring(0, usertext.length - 1);
                            });
                          },
                        );
                      } else if (index == 18) {
                        return CircularButton(
                          buttonText: buttons[index],
                          color: Colors.deepPurpleAccent,
                          textColor: textColor,
                          onTap: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                        );
                      } else {
                        return CircularButton(
                          buttonText: buttons[index],
                          color: isOperator(buttons[index])
                              ? operatorColor
                              : buttonColor,
                          textColor: textColor,
                          onTap: () {
                            setState(() {
                              usertext += buttons[index];
                            });
                          },
                        );
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  void equalPressed() {
    String finaluserinput = usertext;
    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    result = eval.toString();
  }
}

bool isOperator(String x) {
  if (x == '/' || x == '*' || x == '-' || x == '+' || x == '=') {
    return true;
  }
  return false;
}

class CircularButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String buttonText;
  final Function() onTap;

  CircularButton({
    required this.color,
    required this.textColor,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipOval(
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
