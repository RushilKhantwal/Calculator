import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:math_expressions/math_expressions.dart';
//import 'package:marquee/marquee.dart';
import 'package:flutter/services.dart';
import 'package:new_calculator_app/colors.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: primaryBlack),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "";
        equationFontSize = 48.0;
        resultFontSize = 38.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {equation = "0";
        result ="";
        }
        else
          {
            result = equation;
          }
      }
      else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        if(equation =="0" || equation =="00") {
          equation = "0";
          result = "";
        }
        else {
          expression = expression.replaceAll('×', '*');
          expression = expression.replaceAll('÷', '/');
          expression = expression.replaceAll('%', '/100');

          while(expression.endsWith("+") || expression.endsWith("-")||expression.endsWith("*")||expression.endsWith("/"))
            {
              expression = expression.substring(0,expression.length -1);
            }
          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);
            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.VECTOR, cm)}';
          } catch (e) {
            result = "ERROR!";
          }
        }
      }
      else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0")
          {equation = buttonText;}
        else
          {equation = equation + buttonText;}

      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: Colors.black,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
            color: primaryBlack,
            width: 0.0,
            style: BorderStyle.solid,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ),
    );
  }

  Widget buildButtonNumbers(String buttonText, double buttonHeight) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: primaryBlack,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
            color: Colors.black87,
            width: 0.0,
            style: BorderStyle.solid,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CALCULATOR',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        verticalDirection: VerticalDirection.up,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("AC", 1),
                        buildButton("⌫", 1),
                        buildButton('%', 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButtonNumbers("7", 1),
                        buildButtonNumbers("8", 1),
                        buildButtonNumbers("9", 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButtonNumbers("4", 1),
                        buildButtonNumbers("5", 1),
                        buildButtonNumbers("6", 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButtonNumbers("1", 1),
                        buildButtonNumbers("2", 1),
                        buildButtonNumbers("3", 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButtonNumbers(".", 1),
                        buildButtonNumbers("0", 1),
                        buildButtonNumbers("00", 1),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('÷', 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('×', 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("-", 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("+", 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("=", 1),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            color: primaryBlack,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            height: 100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                result,
                style: TextStyle(
                  fontSize: resultFontSize,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            color: primaryBlack,
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            height: 232.36,
            child: SingleChildScrollView(
              child: Text(
                equation,
                style: TextStyle(
                  fontSize: equationFontSize,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
