// Separate Widget for Bottom Control Bar
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomControlBar extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onSwipeUp;
  final AnimationController animationController;
  final Animation<double> positionAnimation;
  final Animation<double> opacityAnimation;

  const BottomControlBar({
    Key? key,
    required this.onPrevious,
    required this.onNext,
    required this.onSwipeUp,
    required this.animationController,
    required this.positionAnimation,
    required this.opacityAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            onSwipeUp();
          }
        },
        child: Container(
          height: 210,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.2)],
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: SvgPicture.asset('assets/svg/left_icon.svg'), onPressed: onPrevious),
                  AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Opacity(
                            opacity: opacityAnimation.value,
                            child: Column(
                              children: [
                                Icon(Icons.keyboard_arrow_up_rounded, color: Colors.black),
                                Icon(Icons.keyboard_arrow_up_rounded, color: Colors.black.withOpacity(0.7)),
                                Icon(Icons.keyboard_arrow_up_rounded, color: Colors.black.withOpacity(0.2)),
                              ],
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0, positionAnimation.value),
                            child: Container(
                              margin: const EdgeInsets.all(2),
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  IconButton(icon: SvgPicture.asset('assets/svg/right_icon.svg'), onPressed: onNext),
                ],
              ),
              const SizedBox(height: 10),
              const Text("Swipe Up To Apply", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
