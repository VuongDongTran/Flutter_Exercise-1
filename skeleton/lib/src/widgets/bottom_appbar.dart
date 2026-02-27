import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_dependency.dart';
import '../bloc/menu/menu_cubit.dart';
import '../common/app_helper.dart';
import '../models/view/menu/menu_item.dart';
import '../theme/app_theme.dart';
import '../theme/colors_theme.dart';

class CustomBottomAppbar extends StatelessWidget {
  const CustomBottomAppbar({
    super.key, 
    this.currentIndex = 0,
    this.onTabChanged,
  });
  
  final int currentIndex;
  final void Function(int)? onTabChanged;
  
  @override
  Widget build(BuildContext context) {
    final menuCubit = AppDependencies.injector.get<MenuCubit>();
    return !AppHelper.isTablet()
        ? Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.neutral10, width: 1.0),
              ),
            ),
            child: BlocBuilder(
              bloc: menuCubit,
              builder: (context, state) {
                int currentChanged = 0;
                if (state is MenuSelectedState) {
                  currentChanged = state.index;
                }
                return BottomNavigationBar(
                  currentIndex: currentChanged,
                  onTap: (value) {
                    menuCubit.onChangeIndex(value);
                    onTabChanged?.call(value);
                  },
                  items: [...menuDefault],
                );
              },
            ),
          )
        : Container(
            width: 105.0,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 1.0,
                  color: AppColors.neutral15,
                ),
              ),
              color: AppColors.background100,
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(51, 61, 71, 0.08),
                    blurRadius: 15,
                    spreadRadius: 0,
                    offset: Offset(0, 0))
              ],
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 32.0, bottom: 64.0),
                  height: 80,
                  child: Image.asset('assets/images/logo.png', width: 56),
                ),
                BlocBuilder(
                  bloc: menuCubit,
                  builder: (context, state) {
                    int currentChanged = 0;
                    if (state is MenuSelectedState) {
                      currentChanged = state.index;
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: navigation.length,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 40.0),
                            child: VerticalMenu(
                              item: navigation[index].bottomNavigationBarItem,
                              selected: currentChanged == index,
                              onSelected: () {
                                menuCubit.onChangeIndex(index);
                                onTabChanged?.call(index);
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
  }
}

class VerticalMenu extends StatelessWidget {
  const VerticalMenu(
      {super.key,
      required this.item,
      required this.selected,
      required this.onSelected});
  final BottomNavigationBarItem item;
  final bool selected;
  final VoidCallback onSelected;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onSelected,
      style:
          const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
      child: SizedBox(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          selected ? item.activeIcon : item.icon,
          Text(item.label ?? '',
              style: selected
                  ? Theme.of(context)
                      .textTheme
                      .appBarTextStyle
                      .copyWith(color: AppColors.ceriseColor)
                  : Theme.of(context)
                      .textTheme
                      .appBarTextStyle
                      .copyWith(color: AppColors.neutral90))
        ],
      )),
    );
  }
}
