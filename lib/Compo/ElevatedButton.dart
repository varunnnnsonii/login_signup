import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.title,
    required this.color1,
    required this.color2,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final Color color1;
  final Color color2;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(1, 0.4),
          colors: [color1, color2],
          tileMode: TileMode.mirror,// Your gradient colors
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
          backgroundColor: Colors.transparent, // Make button transparent
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed:onPressed,
        child: Text(
          title.toUpperCase(),
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
