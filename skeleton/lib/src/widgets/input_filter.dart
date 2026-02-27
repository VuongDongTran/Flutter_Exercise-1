import 'package:flutter/material.dart';

import '../common/dimens.dart';
import '../theme/colors_theme.dart';

class InputFilter extends StatelessWidget {
  const InputFilter(
      {super.key,
      required this.hintText,
      this.value,
      required this.iconData,
      this.onTap,
      this.widget,
      required this.headertText});
  final String hintText;
  final String? value;
  final String headertText;
  final IconData iconData;
  final VoidCallback? onTap;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(color: AppColors.neutral70);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Dimens.size60,
        decoration: BoxDecoration(
            color: AppColors.transparent,
            border: Border(
                bottom: BorderSide(color: AppColors.neutral10, width: 1))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: widget ??
                  Text(
                    headertText,
                    style: textStyle?.copyWith(color: AppColors.neutral70),
                  ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                    child: Text(
                      value ?? hintText,
                      style: textStyle?.copyWith(
                          color: value != null
                              ? AppColors.neutral70
                              : AppColors.neutral50),
                    ),
                  ),
                ),
                const SizedBox(width: Dimens.size16),
                SizedBox(
                    child: Icon(
                  iconData,
                  color: AppColors.neutral50,
                  size: 20.0,
                )),
                const SizedBox(width: Dimens.size16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
