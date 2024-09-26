import 'package:flutter/services.dart';

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int selectionIndex = newValue.selection.end;
    final StringBuffer newText = StringBuffer();
    int oldNumCount = 0;
    if (oldValue.text == '') {
      newText.write('+7 ${newValue.text}');
    } else if (oldValue.text.length == 2 && newValue.text.length == 2) {
      newText
          .write('${oldValue.text} ${newValue.text[newValue.text.length - 1]}');
    } else {
      for (int i = 0; i < oldValue.text.length; i++) {
        if (oldValue.text[i] != ' ' && oldValue.text[i] != '+') oldNumCount++;
      }
      if (oldNumCount < newValue.text.length) {
        if (oldValue.text.length == 6 || oldValue.text.length == 10) {
          newText.write(
              '${oldValue.text} ${newValue.text[newValue.text.length - 1]}');
        } else if (oldValue.text.length != 16) {
          newText
              .write(oldValue.text + newValue.text[newValue.text.length - 1]);
        }
      } else if (oldNumCount != newValue.text.length) {
        if (oldNumCount == 1) {
          newText.write('');
        } else {
          int step = 1;
          if (oldValue.text[oldValue.text.length - 2] == ' ') step = 2;
          newText
              .write(oldValue.text.substring(0, oldValue.text.length - step));
        }
      } else {
        newText.write(oldValue.text);
      }
    }
    selectionIndex = newText.length;
    return TextEditingValue(
      text: newText.toString(),
      selection:  TextSelection.collapsed(offset: selectionIndex),
    );
  }
}