import 'package:flutter/material.dart';

import '../../theme/colors_theme.dart';

BoxDecoration get tCustomBoxDecoration => BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      border: Border.all(color: AppColors.neutral10, width: 1),
      color: AppColors.white,
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(51, 61, 71, 0.08),
          blurRadius: 3,
          spreadRadius: 0,
          offset: Offset(0, 1),
        )
      ],
    );
