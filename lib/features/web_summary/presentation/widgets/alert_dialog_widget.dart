import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final Text title;
  final Text message;
  final Text buttontxt;

  const AlertDialogWidget({
    super.key,
    required this.message,
    required this.title,
    required this.buttontxt,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: message,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: buttontxt,
        ),
      ],
    );
  }
}
