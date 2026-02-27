import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

import '../../theme/colors_theme.dart';

class WordOrderSubItem extends StatelessWidget {
  const WordOrderSubItem(
      {super.key,
      required this.title,
      required this.subtitle,
      this.subtitle1,
      this.maxline = 1});
  final String title;
  final String subtitle;
  final String? subtitle1;
  final int maxline;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 4),
        Flexible(
            child: Text(title,
                maxLines: maxline,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: Theme.of(context).textTheme.bodySmall)),
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(subtitle,
                  maxLines: maxline,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.charcoal)),
            ),
            if (StringUtils.isNotNullOrEmpty(subtitle1))
              Center(
                child: Container(
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    width: 1,
                    height: 10,
                    color: AppColors.neutral50),
              ),
            if (StringUtils.isNotNullOrEmpty(subtitle1))
              Text(subtitle1 ?? '',
                  maxLines: maxline,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.neutral50)),
          ],
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
