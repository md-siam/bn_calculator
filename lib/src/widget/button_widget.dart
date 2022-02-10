import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MyButton extends StatefulWidget {
  final String buttonText;
  // ignore: prefer_typing_uninitialized_variables
  final butttonTapped;

  const MyButton({
    Key? key,
    required this.buttonText,
    this.butttonTapped,
  }) : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isElevated = true;
  AudioCache audioCache = AudioCache(prefix: 'assets/audio/');

  void _pressedDown(PointerEvent details) async {
    await audioCache.play(
      'button_press_2.wav',
      mode: PlayerMode.LOW_LATENCY,
    );
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
      onTap: widget.butttonTapped,
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
