import 'package:flutter/material.dart';

showPopupSetState(BuildContext context, Widget child) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      int selectedRadio = 0; // Declare your variable outside the builder
      return AlertDialog(
        content: StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              // Then, the content of your dialog.
              mainAxisSize: MainAxisSize.min,
              children: List<Widget>.generate(4, (int index) {
                return Radio<int>(
                  value: index,
                  groupValue: selectedRadio,
                  onChanged: (int? value) {
                    // Whenever you need, call setState on your variable
                    setState(() => selectedRadio = value!.toInt());
                  },
                );
              }),
            );
          },
        ),
      );
    },
  );
}
