
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/app_helper.dart';
import '../../theme/colors_theme.dart';

class TextFieldWithDateTimeFilter extends StatefulWidget {
  TextFieldWithDateTimeFilter(
      {super.key,
        required this.text,
        this.hint,
        this.valueDefault,
        this.iconSize = 22,
        required this.onSubmit,
        required this.onCancel});
  final String text;
  final double? iconSize;

  final void Function(DateTime startTime, DateTime endDate) onSubmit;
  final void Function() onCancel;

  final String? hint;
  final String? valueDefault;

  @override
  State<TextFieldWithDateTimeFilter> createState() => _TextFieldFilterState();
}

class _TextFieldFilterState extends State<TextFieldWithDateTimeFilter> {
  DateTime? startDate;
  DateTime? endDate;
  final _controller = TextEditingController();
  @override
  void initState() {
    _controller.text = widget.valueDefault!;
    super.initState();
  }

  // Show the CustomDateRangePicker dialog box
  // COMMENTED OUT - custom_date_range_picker package removed
  /*
  showDateRangePicker(
      BuildContext context, {
        DateTime? startDate,
        DateTime? endDate,
        required DateTime minimumDate,
        required DateTime maximumDate,
        required Color backgroundColor,
        required Color primaryColor,
        required bool barrierDismissible,
        required Function(DateTime, DateTime) onApplyClick,
        required Function() onCancelClick,
      }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: SizedBox(
              height: 700,
              width: 500,
              child: CustomDateRangePicker(
                initialEndDate: endDate,
                initialStartDate: startDate,
                minimumDate: minimumDate,
                maximumDate: maximumDate,
                backgroundColor: backgroundColor,
                primaryColor: primaryColor,
                barrierDismissible: barrierDismissible,
                onApplyClick: onApplyClick,
                onCancelClick: onCancelClick,
              ),
            ),
          );
        });
  }

  Future<void> _showTablePicker() async {
    showDateRangePicker(
      context,
      barrierDismissible: true,
      minimumDate: DateTime(2014, 7, 1),
      maximumDate: DateTime.now().add(const Duration(days: 30)),
      endDate: endDate,
      startDate: startDate,
      backgroundColor: Colors.white,
      primaryColor: AppColors.ceriseColor,
      onApplyClick: (start, end) {
        setState(() {
          endDate = end;
          startDate = start;
        });

        final format = DateFormat('dd/M/yyyy');
        widget.onSubmit(startDate!, endDate!);
        var data =
            '${format.format(startDate!).toString()} - ${format.format(endDate!).toString()}';
        _controller.text = data;
      },
      onCancelClick: () {
        setState(() {
          endDate = null;
          startDate = null;
        });
        widget.onCancel();
        _controller.text = '';
      },
    );
    setState(() {});
  }

  void _showPicker() {
    showCustomDateRangePicker(
      context,
      dismissible: true,
      minimumDate: DateTime(2014, 7, 1),
      maximumDate: DateTime.now().add(const Duration(days: 30)),
      endDate: endDate,
      startDate: startDate,
      backgroundColor: Colors.white,
      primaryColor: AppColors.ceriseColor,
      onApplyClick: (start, end) {
        setState(() {
          endDate = end;
          startDate = start;
        });

        final format = DateFormat('dd/M/yyyy');
        widget.onSubmit(startDate!, endDate!);
        var data =
            '${format.format(startDate!).toString()} - ${format.format(endDate!).toString()}';
        _controller.text = data;
      },
      onCancelClick: () {
        setState(() {
          endDate = null;
          startDate = null;
        });
        widget.onCancel();
        _controller.text = '';
      },
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {}, // Disabled - custom_date_range_picker removed
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.only(left: 8),
          height: size.height * 0.03,
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.neutral70,
            ),
          ),
        ),
        SizedBox(
          height: AppHelper.isTablet() ? size.height / 30 : size.height / 27,
          width: AppHelper.isTablet() ? size.width / 3 : size.width,
          child: TextField(
            scrollPadding: const EdgeInsets.all(0),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.neutral90,fontWeight: FontWeight.w600,
            ),
            onTap: () {}, // Disabled - custom_date_range_picker removed
            readOnly: true,
            controller: _controller,
            decoration: InputDecoration(
                contentPadding:  EdgeInsets.only(bottom: AppHelper.isTablet()?8:10, left: 8),
                suffixIcon: Icon(
                  Iconsax.calendar_2,
                  size: widget.iconSize,
                  color: AppColors.neutral70,
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.neutral15)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.neutral15)),
                hintText: widget.valueDefault!.isNotEmpty
                    ? widget.valueDefault
                    : widget.hint,
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.neutral90,
                )),
          ),
        )
      ]),
    );
  }
}
