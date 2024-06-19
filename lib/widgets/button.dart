import 'package:first_quiz/contants/colors.dart';
import 'package:flutter/material.dart';

class Button1 extends StatefulWidget {
  const Button1({
    Key? key,
    required this.label,
    this.textColor = Colors.white,
  }) : super(key: key);

  final String label;
  final Color textColor;

  @override
  _Button1State createState() => _Button1State();
}

class _Button1State extends State<Button1> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (hovering) {
        setState(() {
          _isHovered = hovering;
        });
      },
      child: Material(
        elevation: _isHovered ? 8 : 3,
        color: Colors.transparent,
        child: CircleAvatar(
          radius: 25,
          backgroundColor: _isHovered ? Colors.blue : AppColors.secondaryColor,
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: widget.textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class Button2 extends StatefulWidget {
  const Button2({
    Key? key,
    required this.label,
    this.textColor = Colors.white,
  }) : super(key: key);

  final String label;
  final Color textColor;

  @override
  _Button2State createState() => _Button2State();
}

class _Button2State extends State<Button2> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (hovering) {
        setState(() {
          _isHovered = hovering;
        });
      },
      child: Material(
        elevation: _isHovered ? 8 : 3,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          margin: const EdgeInsets.only(left: 1.0),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.green : Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: widget.textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Button3 extends StatefulWidget {
  const Button3({
    Key? key,
    required this.label,
    this.backgroundColor = Colors.red,
    this.textColor = Colors.white,
  }) : super(key: key);

  final String label;
  final Color backgroundColor;
  final Color textColor;

  @override
  _Button3State createState() => _Button3State();
}

class _Button3State extends State<Button3> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (hovering) {
        setState(() {
          _isHovered = hovering;
        });
      },
      child: Material(
        elevation: _isHovered ? 8 : 3,
        color: Colors.transparent,
        child: CircleAvatar(
          radius: 25,
          backgroundColor: _isHovered ? Colors.blue : widget.backgroundColor,
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: widget.textColor,
            ),
          ),
        ),
      ),
    );
  }
  
}
