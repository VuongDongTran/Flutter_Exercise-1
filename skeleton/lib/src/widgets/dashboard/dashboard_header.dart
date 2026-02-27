import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

import '../../common/app_helper.dart';
import '../../common/dimens.dart';
import '../../theme/colors_theme.dart';
import '../custom_button.dart';

class DashBoardHeader extends StatelessWidget {
  const DashBoardHeader({
    super.key,
    required this.status,
    this.code,
  });

  final ButtonState? code;
  final String status;
  Color get colorStatus {
    if (StringUtils.isNotNullOrEmpty(code.toString())) {
      if (code.toString().contains('NOTSTARTYET')) {
        return AppColors.neutral70;
      }
      if (code.toString().contains('COMPLETED')) {
        return AppColors.complete;
      }
    }
    return AppColors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppHelper.isTablet()
          ? MediaQuery.of(context).size.width / 4 + 16
          : 225,
      padding: const EdgeInsets.all(Dimens.size12),
      decoration: BoxDecoration(
        color: colorStatus,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimens.size8),
          topRight: Radius.circular(Dimens.size8),
        ),
      ),
      child: Center(
          child: Text(status,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColors.white))),
    );
  }
}
