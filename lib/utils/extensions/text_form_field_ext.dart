import 'package:flutter/material.dart';

extension TextEditingControllerExt on TextEditingController {
  void setTextIfNew(String newText) {
    if (text != newText) {
      text = newText;
    }
  }
}
