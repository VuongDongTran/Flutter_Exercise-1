import 'package:flutter/material.dart';

import '../theme/colors_theme.dart';
import 'common/dotted_line.dart';
import 'custom_button.dart';

class ItemBuildHeader extends StatelessWidget {
  const ItemBuildHeader({
    super.key,
    required this.title,
    this.direction = Axis.horizontal,
    this.buttonState = ButtonState.APPROVED,
  });
  final String title;
  final Axis direction;
  final ButtonState buttonState;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: direction == Axis.horizontal ? double.infinity : null,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Flex(
              direction: direction,
              mainAxisAlignment: direction == Axis.horizontal
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.start,
              crossAxisAlignment: direction == Axis.horizontal
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 4),
                ButtonStatus(state: buttonState)
              ],
            )),
        Divider(height: 1, color: AppColors.neutral10, thickness: 1),
      ],
    );
  }
}

class ItemBuildHeaderLabel extends StatelessWidget {
  const ItemBuildHeaderLabel({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text(title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.charcoal)),
        ),
        SizedBox(
          width: double.maxFinite,
          height: 1,
          child: CustomPaint(
            painter:
                DottedLinePainter(strokeWidth: 1, color: AppColors.neutral15),
          ),
        ),
      ],
    );
  }
}
