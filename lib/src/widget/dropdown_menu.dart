import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import '../view/history.dart';
import 'util/arrow_clipper.dart';
import '../provider/sound_provider.dart';

class CustomDropdownMenu extends StatefulWidget {
  final List<Icon> icons;
  final BorderRadius? borderRadius;
  final Color backgroundColor;
  final ValueChanged<int>? onChange;
  const CustomDropdownMenu({
    Key? key,
    required this.icons,
    required this.borderRadius,
    required this.backgroundColor,
    this.onChange,
  }) : super(key: key);

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu>
    with SingleTickerProviderStateMixin {
  GlobalKey? _key;
  bool isMenuOpen = false;
  late Offset buttonPosition;
  late Size buttonSize;
  late OverlayEntry _overlayEntry;
  BorderRadius? _borderRadius;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _borderRadius = widget.borderRadius ?? BorderRadius.circular(4);
    _key = LabeledGlobalKey("button_icon");
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  findButton() {
    RenderBox renderBox = _key!.currentContext!.findRenderObject() as RenderBox;
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  void closeMenu() {
    _overlayEntry.remove();
    _animationController.reverse();
    isMenuOpen = !isMenuOpen;
  }

  void openMenu() {
    findButton();
    _animationController.forward();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context)!.insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      decoration: BoxDecoration(borderRadius: _borderRadius),
      // Consumer provides playMenuClose() & playMenuOpen()
      // from SoundProvider
      child: Consumer<SoundProvider>(
        builder: (context, soundProvider, child) {
          return IconButton(
            splashRadius: 1,
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _animationController,
            ),
            iconSize: 35,
            onPressed: () {
              if (isMenuOpen) {
                soundProvider.playMenuClose();
                closeMenu();
              } else {
                soundProvider.playMenuOpen();
                openMenu();
              }
            },
          );
        },
      ),
    );
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition.dy + buttonSize.height - 13.0,
          left: buttonPosition.dx,
          width: buttonSize.width,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Material(
                  elevation: 10,
                  color: Colors.transparent,
                  shadowColor: Theme.of(context).shadowColor,
                  shape: ShapeBorder.lerp(
                    const CircleBorder(),
                    const CircleBorder(),
                    1.0,
                  ),
                  child: ClipPath(
                    clipper: ArrowClipper(),
                    child: Container(
                      width: 17,
                      height: 17,
                      color: widget.backgroundColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Material(
                  elevation: 10,
                  color: Colors.transparent,
                  shadowColor: Theme.of(context).shadowColor,
                  child: Container(
                    height: widget.icons.length * buttonSize.height,
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      borderRadius: _borderRadius,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        widget.icons.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              onSelected(context, index);
                              //widget.onChange!(index);
                              closeMenu();
                            },
                            child: SizedBox(
                              width: buttonSize.width,
                              height: buttonSize.height,
                              child: widget.icons[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => const HistoryPage(),
        ),
      );

      break;

    case 1:
      showAboutDialog(
        context: context,
        applicationIcon: const Icon(
          Icons.calculate_outlined,
          size: 80,
        ),
        applicationName: 'BN Calculator',
        applicationVersion: '0.2.1',
        applicationLegalese: '©2022, mdsiam.xyz',
        children: const [
          Padding(
            padding: EdgeInsets.only(top: 1.0),
            child: Text(
              'This app is designed with a custom neumorphic button, with a custom button press sound, that imitates the sound of a physical calculator. In addition to that, it has a beautiful dark theme, and a user can turn On/Off the dark theme using a custom animated button on the AppBar.',
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      );
      break;
  }
}
