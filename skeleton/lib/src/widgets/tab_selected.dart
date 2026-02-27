import 'package:flutter/material.dart';

import 'custom_button.dart';

class TabSelected extends StatefulWidget {
  const TabSelected(
      {super.key,
      required this.items,
      required this.onSelected,
      this.defaultIndex = 0, this.width, this.height});
  final List<String> items;
  final void Function(int index) onSelected;
  final Axis direction = Axis.horizontal;
  final int defaultIndex;
  final double? width;
  final double? height;

  @override
  State<TabSelected> createState() => _TabSelectedState();
}

class _TabSelectedState extends State<TabSelected> {
  int defaultIndex = 0;
  @override
  void initState() {
    defaultIndex = widget.defaultIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(TabSelected oldWidget) {
    if (oldWidget.defaultIndex != widget.defaultIndex) {
      setState(() {
        defaultIndex = widget.defaultIndex;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: widget.items.length,
        scrollDirection: widget.direction,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return Align(
              alignment: Alignment.centerLeft,
              child: CustomButton(
                  width: widget.width,
                  height: widget.height,
                  borderRadius: 12,
                  onTap: () {
                    setState(() {
                      defaultIndex = index;
                    });
                    widget.onSelected(index);
                  },
                  selected: defaultIndex == index,
                  label: widget.items[index]));
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 12));
  }
}
