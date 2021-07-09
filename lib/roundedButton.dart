import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.colour, this.title, this.onPressed});

  final Color colour;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Material(
        color: colour,
        borderRadius: BorderRadius.circular(30),
        elevation: 8,
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          height: 42,
          minWidth: 200,
        ),
      ),
    );
  }
}
