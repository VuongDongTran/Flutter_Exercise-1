import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

import '../common/dimens.dart';
import '../common/app_localizations.dart';
import '../theme/colors_theme.dart';

class SearchInput extends StatefulWidget {
  final double? width;
  final double? height;
  final String? hintText;
  final String? initialValue;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const SearchInput({
    Key? key,
    this.width,
    this.height,
    this.hintText,
    this.onSubmitted,
    this.onChanged,
    this.inputFormatters,
    this.initialValue,
    this.controller,
    this.focusNode,
  }) : super(key: key);

  @override
  SearchInputState createState() => SearchInputState();
}

class SearchInputState extends State<SearchInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleSubmitted(String value) {
    if (widget.onSubmitted != null) {
      widget.onSubmitted!(value);
    }
  }

  void _handleOnChanged(String value) {
    if (widget.onChanged != null) {
      EasyDebounce.debounce(
          'onSearchChange', const Duration(milliseconds: 1000), () async {
        widget.onChanged!(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? Dimens.size300,
      height: widget.height ?? Dimens.size48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(39),
        border: Border.all(
          color: AppColors.neutral10,
        ),
        // color: AppColors.white,
      ),
      child: Row(
        children: [
          const SizedBox(width: Dimens.size16),
          InkWell(
            onTap: () => _handleSubmitted(_controller.text),
            child: Icon(
              Iconsax.search_normal_1,
              color: AppColors.neutral70,
              size: Dimens.size20,
            ),
          ),
          const SizedBox(width: Dimens.size16),
          Expanded(
            child: TextField(
              textAlignVertical: TextAlignVertical.top,
              controller: _controller,
              focusNode: _focusNode,
              onSubmitted: _handleSubmitted,
              onChanged: _handleOnChanged,
              inputFormatters: widget.inputFormatters ?? [],
              decoration: InputDecoration(
                hintText: widget.hintText ?? context.tr('search.hint'),
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                border: InputBorder.none,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: Dimens.size16),
        ],
      ),
    );
  }
}
