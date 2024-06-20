import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class CalculatorProvider extends ChangeNotifier {
  final compController = TextEditingController(text: "0");

  setValue(String value) {
    String str = compController.text;

    switch (value) {
      case "C":
        compController.clear();
        compController.text = "0";
        break;
      case "AC":
        if (str.length > 1) {
          compController.text = str.substring(0, str.length - 1);
        } else {
          compController.text = "0";
        }
        break;
      case "X":
        compController.text += "*";
        break;
      case "=":
        compute();
        break;
      default:
        if (str == "0") {
          compController.text = value;
        } else {
          compController.text += value;
        }
    }
    compController.selection = TextSelection.fromPosition(
        TextPosition(offset: compController.text.length));
  }

  compute() {
    String text = compController.text;
    try {
      compController.text = text.interpret().toString();
    } catch (e) {
      compController.text = "Error";
    }
  }

  @override
  void dispose() {
    super.dispose();
    compController.dispose();
  }
}
