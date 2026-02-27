import 'package:flutter/material.dart';

import '../../theme/colors_theme.dart';

class CircularCheckbox extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  const CircularCheckbox(
      {Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        activeColor: Colors.transparent,
        checkColor: AppColors.complete,
        shape: const CircleBorder(),
        side: MaterialStateBorderSide.resolveWith(
          (states) => BorderSide(
              width: 1.0,
              color: value == true ? AppColors.complete : AppColors.neutral50),
        ),
        value: value,
        onChanged: onChanged);
  }
}
