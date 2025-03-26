import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Калькулятор',
      theme: ThemeData.dark(),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _expression = "";
  String _current = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operator = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _expression = "";
        _current = "";
        _num1 = 0;
        _num2 = 0;
        _operator = "";
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
        _num1 = double.parse(_current);
        _operator = buttonText;
        _expression = "$_num1 $_operator";
        _current = "";
      } else if (buttonText == "=") {
        _num2 = double.parse(_current);
        if (_operator == "+") {
          _output = (_num1 + _num2).toString();
        } else if (_operator == "-") {
          _output = (_num1 - _num2).toString();
        } else if (_operator == "×") {
          _output = (_num1 * _num2).toString();
        } else if (_operator == "÷") {
          _output = _num2 != 0 ? (_num1 / _num2).toString() : "Ошибка";
        }
        _expression = "$_num1 $_operator $_num2 =";
        _current = _output;
      } else if (buttonText == "ln") {
        double value = double.tryParse(_current) ?? 0;
        _output = value > 0 ? log(value).toString() : "Ошибка"; // Натуральный логарифм
        _current = _output;
        _expression = "ln($value)";
      } else if (buttonText == "log") {
        double value = double.tryParse(_current) ?? 0;
        double base = double.tryParse(_current) ?? 10; // В данном случае используется основание 10
        _output = value > 0 && base > 0 && base != 1
            ? (log(value) / log(base)).toString() // Логарифм по произвольному основанию
            : "Ошибка";
        _current = _output;
        _expression = "log($value, $base)";
      } else if (buttonText == "√") {
        double value = double.tryParse(_current) ?? 0;
        _output = value >= 0 ? sqrt(value).toString() : "Ошибка"; // Квадратный корень
        _current = _output;
        _expression = "√($value)";
      } else {
        // Добавляем цифры или оператор
        if (_current == "0" && buttonText != ".") {
          _current = buttonText; // Для первой цифры
        } else {
          _current += buttonText; // Для добавления следующих цифр
        }
        _output = _current;
        _expression += buttonText;
      }
    });
  }

  Widget _buildButton(String text, {Color color = const Color(0xFF800000)}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(text),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: color,
            shadowColor: Colors.white,
            elevation: 8,
          ),
          child: Text(text, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3E2723),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Text(_expression, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white54)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Text(_output, style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Color(0xFFD32F2F),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                        children: [
                          _buildButton("C", color: Color(0xFF9E9E9E)),
                          _buildButton("ln", color: Color(0xFF9E9E9E)),
                          _buildButton("log", color: Color(0xFF9E9E9E)),
                          _buildButton("√", color: Color(0xFF9E9E9E)),
                        ]
                    ),
                  ),
                  Expanded(
                    child: Row(
                        children: [
                          _buildButton("7"),
                          _buildButton("8"),
                          _buildButton("9"),
                          _buildButton("×", color: Color(0xFFB71C1C)),
                        ]
                    ),
                  ),
                  Expanded(
                    child: Row(
                        children: [
                          _buildButton("4"),
                          _buildButton("5"),
                          _buildButton("6"),
                          _buildButton("-", color: Color(0xFFB71C1C)),
                        ]
                    ),
                  ),
                  Expanded(
                    child: Row(
                        children: [
                          _buildButton("1"),
                          _buildButton("2"),
                          _buildButton("3"),
                          _buildButton("+", color: Color(0xFFB71C1C)),
                        ]
                    ),
                  ),
                  Expanded(
                    child: Row(
                        children: [
                          _buildButton("0"),
                          _buildButton(".", color: Color(0xFF9E9E9E)),
                          _buildButton("=", color: Color(0xFFB71C1C)),
                          _buildButton("÷", color: Color(0xFFB71C1C)),
                        ]
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
