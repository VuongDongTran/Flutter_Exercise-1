import 'package:flutter/material.dart';
import '../../common/dimens.dart';
import 'circular_checkbox.dart';

class CheckBoxItem {
  final bool value;
  final String title;
  CheckBoxItem(this.title, this.value);
}

class GroupCheckBoxField extends StatelessWidget {
  const GroupCheckBoxField(
      {super.key,
      required this.title,
      required this.list,
      required this.initValue,
      required this.onSelected});
  final String title;
  final List<String> list;
  final int initValue;
  final void Function(bool value) onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: Dimens.size16),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(Dimens.size8),
            ),
            child: Text(title, style: Theme.of(context).textTheme.bodySmall)),
        const SizedBox(
          height: Dimens.size4,
        ),
        SizedBox(
          width: double.infinity,
          height: 40,
          child: GroupCheckBox(
            list: list,
            initValue: initValue,
            onSelected: (bool value) {
              onSelected(value);
            },
          ),
        ),
      ],
    );
  }
}

class GroupCheckBox extends StatefulWidget {
  const GroupCheckBox(
      {Key? key,
      required this.list,
      required this.onSelected,
      required this.initValue})
      : super(key: key);
  final void Function(bool value) onSelected;
  final int initValue;
  @override
  State<GroupCheckBox> createState() => _GroupCheckBoxState();
  final List<String> list;
}

class _GroupCheckBoxState extends State<GroupCheckBox> {
  int selectedValue = 0;
  @override
  void initState() {
    super.initState();
    selectedValue = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.list.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: Dimens.size113,
            ),
            child: Row(
              children: [
                CircularCheckbox(
                  value: selectedValue == index,
                  onChanged: (value) {
                    widget.onSelected(index == 0);
                    setState(() {
                      selectedValue = index;
                    });
                  },
                ),
                Text(
                  widget.list[index],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        });
  }
}
