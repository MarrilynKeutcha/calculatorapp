import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String output = "0"; // Initial display value
  String _output = "0"; // Internal value for calculation
  double num1 = 0; // First operand
  double num2 = 0; // Second operand
  String operand = ""; // Operator (+, -, *, /)

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        // Clear everything when "C" is pressed
        _output = "0";
        num1 = 0;
        num2 = 0;
        operand = "";
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
        // Handle operator input
        num1 = double.parse(_output);
        operand = buttonText;
        _output = "0";
      } else if (buttonText == "=") {
        // Handle calculation when "=" is pressed
        num2 = double.parse(_output);

        if (operand == "+") {
          _output = (num1 + num2).toString();
        } else if (operand == "-") {
          _output = (num1 - num2).toString();
        } else if (operand == "*") {
          _output = (num1 * num2).toString();
        } else if (operand == "/") {
          if (num2 == 0) {
            _output = "Error"; // Handle division by zero
          } else {
            _output = (num1 / num2).toString();
          }
        }
        operand = "";
      } else if (buttonText == ".") {
        // Handle decimal input
        if (!_output.contains(".")) {
          _output += ".";
        }
      } else {
        // Handle number input
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
      }

      output = _output; // Update the display
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(buttonText),
          child: Text(buttonText, style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          // Display Area
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(output, style: TextStyle(fontSize: 48)),
          ),
          Expanded(child: Divider()),

          // Calculator buttons
          Column(
            children: [
              Row(children: [
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("/")
              ]),
              Row(children: [
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("*")
              ]),
              Row(children: [
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-")
              ]),
              Row(children: [
                buildButton("."),
                buildButton("0"),
                buildButton("C"),
                buildButton("+")
              ]),
              Row(children: [
                buildButton("="),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
