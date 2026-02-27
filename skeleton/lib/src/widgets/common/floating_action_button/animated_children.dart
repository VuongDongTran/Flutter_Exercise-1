import 'package:flutter/material.dart';

import 'flutter_action_button.dart';

class AnimatedChildren extends StatelessWidget {
  final Animation<double> animation;
  final List<SpeedDialChild> children;
  final Future<dynamic> Function() close;
  final bool invokeAfterClosing;

  const AnimatedChildren({
    Key? key,
    required this.animation,
    required this.children,
    required this.close,
    required this.invokeAfterClosing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: animation,
        builder: (context, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(children.length, (i) => i).map((i) {
            final speedDialChild = children[i];
            final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Interval(
                    ((children.length - 1 - i) / children.length), 1,
                    curve: Curves.easeInOutCubic));

            Future<void> onPressed() async {
              invokeAfterClosing ? await close() : close();
              speedDialChild.onPressed?.call();
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onPressed,
                child: Row(
                  children: [
                    Center(child: speedDialChild.label),
                    const SizedBox(width: 16),
                    ScaleTransition(
                      scale: curvedAnimation,
                      child: Container(
                        width: 56,
                        height: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                              speedDialChild.backgroundColor ?? Colors.white70,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            )
                          ],
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          icon: speedDialChild.child ?? const SizedBox(),
                          color: speedDialChild.backgroundColor ??
                              Theme.of(context).primaryColor,
                          onPressed: onPressed,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
}

class AnimatedFAB extends StatelessWidget {
  final Animation<double> animation;
  final Color? backgroundColor,
      expandedBackgroundColor,
      foregroundColor,
      expandedForegroundColor;
  final VoidCallback? onClosePressed;
  final Widget? child, expandedChild;

  const AnimatedFAB({
    Key? key,
    required this.animation,
    this.backgroundColor,
    this.expandedBackgroundColor,
    this.foregroundColor,
    this.expandedForegroundColor,
    this.onClosePressed,
    this.child,
    this.expandedChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColorTween = ColorTween(
        begin: backgroundColor,
        end: expandedBackgroundColor ?? backgroundColor);
    final foregroundColorTween = ColorTween(
        begin: foregroundColor,
        end: expandedForegroundColor ?? foregroundColor);
    final angleTween = Tween<double>(begin: 0, end: 1);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => FloatingActionButton(
        onPressed: onClosePressed,
        shape: const CircleBorder(),
        backgroundColor: backgroundColorTween.lerp(animation.value),
        foregroundColor: foregroundColorTween.lerp(animation.value),
        child: Stack(
          children: [
            Transform.rotate(
                angle: angleTween.animate(animation).value,
                child: Opacity(opacity: 1 - animation.value, child: child)),
            Transform.rotate(
                angle: angleTween.animate(animation).value - 1,
                child: Opacity(opacity: animation.value, child: expandedChild)),
          ],
        ),
      ),
    );
  }
}
