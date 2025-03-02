import 'package:flutter/material.dart';

class ShowAlert extends StatelessWidget {
  const ShowAlert({
    super.key,
    this.title,
    this.text,
    this.iconData,
    this.onPressed,
  });

  final String? title;
  final String? text;
  final IconData? iconData;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        title ?? 'Complaint Submitted',
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      icon: CircleAvatar(
        radius: 35,
        backgroundColor: Colors.green.shade600,
        child: Icon(
          iconData ?? Icons.check_circle_outline,
          size: 40,
          color: Colors.white,
        ),
      ),
      content: Text(
        text ??
            'Your complaint has been submitted successfully. You will receive a response soon.',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton.icon(
          onPressed: onPressed ?? () => Navigator.pop(context),
          icon: const Icon(Icons.close, size: 20),
          label: const Text(
            'Close',
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class ShowAlertError extends StatelessWidget {
  const ShowAlertError({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Error Occurred',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      icon: const CircleAvatar(
        radius: 35,
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.error_outline, size: 40, color: Colors.white),
      ),
      content: const Text(
        'Something went wrong. Please try again later.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Close',
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
