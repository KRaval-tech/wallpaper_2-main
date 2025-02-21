import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomControls extends StatefulWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onSwipeUp;

  const BottomControls({
    Key? key,
    required this.onPrevious,
    required this.onNext,
    required this.onSwipeUp,
  }) : super(key: key);

  @override
  _BottomControlsState createState() => _BottomControlsState();
}

class _BottomControlsState extends State<BottomControls> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _positionAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _positionAnimation = Tween<double>(begin: 0.0, end: -75.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left Icon for Previous
        Padding(
          padding: const EdgeInsets.only(),
          child: GestureDetector(
            onTap: widget.onPrevious,
            child: SvgPicture.asset('assets/svg/left_icon.svg'),
          ),
        ),

        // Swipe Up to Apply Animation (Centered)
        Column(
          children: [
            Container(
              height: 130,
              width: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(39.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    offset: Offset(0, 8),
                    spreadRadius: 0,
                    blurRadius: 15.33,
                  ),
                ],
              ),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Opacity(
                        opacity: _opacityAnimation.value,
                        child: Column(
                          children: [
                            Icon(Icons.keyboard_arrow_up_rounded, color: Colors.black),
                            Icon(Icons.keyboard_arrow_up_rounded, color: Colors.black.withOpacity(0.7)),
                            Icon(Icons.keyboard_arrow_up_rounded, color: Colors.black.withOpacity(0.2)),
                          ],
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, _positionAnimation.value),
                        child: GestureDetector(
                          onVerticalDragEnd: (details) {
                            if (details.primaryVelocity! < 0) {
                              // Start animation and trigger the callback
                              _animationController.forward();
                              widget.onSwipeUp();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.all(2),
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(0, 4),
                                  spreadRadius: 0,
                                  blurRadius: 6.2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Swipe Up To Apply",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ],
        ),

        // Right Icon for Next
        Padding(
          padding: const EdgeInsets.only(),
          child: GestureDetector(
            onTap: widget.onNext,
            child: SvgPicture.asset('assets/svg/right_icon.svg'),
          ),
        ),
      ],
    );
  }
}