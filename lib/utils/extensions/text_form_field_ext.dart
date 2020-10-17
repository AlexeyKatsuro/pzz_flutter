import 'package:flutter/material.dart';

extension TextEditingControllerExt on TextEditingController {
  void setTextIfNew(String newText) {
    if (this.text != newText) {
      this.text = newText;
    }
  }
}
