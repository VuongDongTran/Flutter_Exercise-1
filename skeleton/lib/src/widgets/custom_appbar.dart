import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../common/app_helper.dart';
import '../theme/colors_theme.dart';
import 'custom_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.onStart,
    this.buttonLabel,
    this.icon,
    this.actions,
  });

  final String title;
  final VoidCallback? onStart;
  final String? buttonLabel;
  final Widget? icon;
  final List<Widget>? actions;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: AppHelper.isTablet()
            ? null
            : Border(
                bottom: BorderSide(color: AppColors.neutral10, width: 1.0),
              ),
      ),
      child: AppBar(
        leading: Navigator.canPop(context)
            ? InkWell(
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Icon(
                  Iconsax.arrow_left_3,
                  color: AppColors.neutral70,
                  size: 32,
                ),
              )
            : null,
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
        actions: actions ??
            [
              Visibility(
                visible: StringUtils.isNotNullOrEmpty(buttonLabel) &&
                    AppHelper.isTablet(),
                child: CustomButton(
                  label: buttonLabel ?? '',
                  selected: true,
                  backgroundColor: AppColors.ceriseColor,
                  prefixIcon: icon,
                  onTap: onStart,
                ),
              ),
            ],
      ),
    );
  }
}

class CustomDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomDetailAppBar(
      {super.key,
      required this.title,
      this.onStart,
      this.buttonLabel,
      this.icon,
      this.actions});
  final String title;
  final VoidCallback? onStart;
  final String? buttonLabel;
  final Widget? icon;
  final List<Widget>? actions;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: AppHelper.isTablet()
            ? null
            : Border(
                bottom: BorderSide(color: AppColors.neutral10, width: 1.0),
              ),
      ),
      child: AppBar(
        backgroundColor: AppColors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: Icon(
            Iconsax.arrow_left_3,
            color: AppColors.neutral70,
            size: 32,
          ),
        ),
        title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
        titleSpacing: 0,
        actions: actions ??
            [
              Visibility(
                visible: StringUtils.isNotNullOrEmpty(buttonLabel) &&
                    AppHelper.isTablet(),
                child: CustomButton(
                  label: buttonLabel ?? '',
                  selected: true,
                  backgroundColor: AppColors.ceriseColor,
                  prefixIcon: icon,
                  height: 48,
                  onTap: onStart,
                ),
              ),
            ],
      ),
    );
  }
}
