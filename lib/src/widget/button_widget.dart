import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/sound_provider.dart';

class MyButton extends StatefulWidget {
  final String buttonText;
  // ignore: prefer_typing_uninitialized_variables
  final buttonTapped;

  const MyButton({
    Key? key,
    required this.buttonText,
    this.buttonTapped,
  }) : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isElevated = true;

  void _pressedDown(PointerEvent details) {
    // provides playButtonSound() from SoundProvider
    context.read<SoundProvider>().playButtonSound();
    setState(() {
      _isElevated = !_isElevated;
    });
  }

  void _pressedUp(PointerEvent details) {
    setState(() {
      _isElevated = !_isElevated;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: widget.buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Listener(
          onPointerDown: _pressedDown,
          onPointerUp: _pressedUp,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: _isElevated
                  ? [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        offset: const Offset(4, 4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Theme.of(context).splashColor,
                        offset: const Offset(-4, -4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      )
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                widget.buttonText,
                style: TextStyle(
                  fontSize: deviceHeight < 670 ? 30 : 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
