// ignore_for_file: constant_identifier_names

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';

import '../common/dimens.dart';
import '../common/app_localizations.dart';
import '../common/enum_values.dart';
import '../theme/app_theme.dart';
import '../theme/colors_theme.dart';
import 'skeleton/skeleton_loading.dart';

enum ButtonState {
  APPROVED,
  WAITINGFORAPPROVE,
  WAITINGASSIGNMENT,
  CANCEL,
  CANCELLED,
  ASSIGNED,
  NOTSTARTYET,
  CHECKING,
  PDCHECK,
  QCCHECK,
  RHCHECK,
  MATERIALREQUEST,
  WAITINGEXWAREHOUSE,
  EXPORTED,
  REPAIRING,
  DONEWAITINGKTVCONFIRM,
  DOING,
  WAITINGREVIEW,
  COMPLETED,
  KTVCONFIRM,
  NOTPASS,
  MOVED,
  HIGH,
  MEDIUM,
  LOW
}

final statusValues = EnumValues({
  tr('status.approved'): ButtonState.APPROVED,
  tr('status.cancel'): ButtonState.CANCEL,
  tr('status.waiting_for_approve'): ButtonState.WAITINGFORAPPROVE,
  tr('status.cancelled'): ButtonState.CANCELLED,
  tr('status.assigned'): ButtonState.ASSIGNED,
  tr('status.waiting_for_assigment'): ButtonState.WAITINGASSIGNMENT,
  tr('status.not_start_yet'): ButtonState.NOTSTARTYET,
  tr('status.checking'): ButtonState.CHECKING,
  tr('status.pd_check'): ButtonState.PDCHECK,
  tr('status.qc_check'): ButtonState.QCCHECK,
  tr('status.rh_check'): ButtonState.RHCHECK,
  tr('status.material_request'): ButtonState.MATERIALREQUEST,
  tr('status.waiting_for_warehouse'): ButtonState.WAITINGEXWAREHOUSE,
  tr('status.exported'): ButtonState.EXPORTED,
  tr('status.repairing'): ButtonState.REPAIRING,
  tr('status.done_waiting_ktv_confirm'): ButtonState.DONEWAITINGKTVCONFIRM,
  tr('status.doing'): ButtonState.DOING,
  tr('status.waiting_review'): ButtonState.WAITINGREVIEW,
  tr('status.completed'): ButtonState.COMPLETED,
  tr('status.ktv_confirmed'): ButtonState.KTVCONFIRM,
  tr('status.not_pass'): ButtonState.NOTPASS,
  tr('status.moved'): ButtonState.MOVED,
  tr('status.high'): ButtonState.HIGH,
  tr('status.low'): ButtonState.LOW,
  tr('status.medium'): ButtonState.MEDIUM,
});

const int _kNumberDots = 3;

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.label,
      this.selected = false,
      this.isLoading = false,
      this.onTap,
      this.width,
      this.height,
      this.backgroundColor = AppColors.ceriseColor,
      this.textColor = AppColors.white,
      this.borderSide,
      this.borderRadius,
      this.prefixIcon,
      this.fontWeight});
  final String label;
  final bool? selected;
  final bool isLoading;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderSide? borderSide;
  final Widget? prefixIcon;
  final double? borderRadius;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? Dimens.size48,
      child: ElevatedButton(
        onPressed: () => EasyDebounce.debounce(
            'customButton', const Duration(milliseconds: 100), onTap ?? () {}),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: selected! ? backgroundColor : AppColors.neutral5,
          foregroundColor: AppColors.background100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? Dimens.size30,
            ),
          ),
          side: selected! ? borderSide : null,
          padding: const EdgeInsets.only(
              bottom: Dimens.size5,
              left: Dimens.size16,
              right: Dimens.size16,
              top: Dimens.size5),
        ),
        child: isLoading
            ? const DotsLoading()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefixIcon != null)
                    Padding(
                      padding: const EdgeInsets.only(
                          right: Dimens.size8, top: Dimens.size2),
                      child: prefixIcon,
                    ),
                  Text(
                    label,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: selected! ? textColor : AppColors.neutral70,
                          fontWeight: fontWeight ?? FontWeight.w600,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}

class DotsLoading extends StatefulWidget {
  const DotsLoading({
    Key? key,
  }) : super(key: key);

  @override
  State<DotsLoading> createState() => _DotsLoadingState();
}

class _DotsLoadingState extends State<DotsLoading>
    with TickerProviderStateMixin {
  List<AnimationController>? _animationControllers;

  final List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    for (final controller in _animationControllers!) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initAnimation() {
    _animationControllers = List.generate(
      _kNumberDots,
      (index) {
        return AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 300),
        );
      },
    ).toList();

    const double iHeight = -6;
    for (int i = 0; i < _kNumberDots; i++) {
      final ratio = i == 0 ? iHeight : iHeight + (iHeight * ((i + 1) * 1 / 10));
      _animations.add(Tween<double>(begin: 0, end: ratio)
          .animate(_animationControllers![i]));
    }

    for (int i = 0; i < _kNumberDots; i++) {
      _animationControllers![i].addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          if (mounted) {
            await _animationControllers![i].reverse();
          }
        }

        const iDuration = 50;
        await Future.delayed(Duration(milliseconds: iDuration * (i + 1)));
        if (i != _kNumberDots - 1 && status == AnimationStatus.forward) {
          if (mounted) {
            await _animationControllers![i + 1].forward();
          }
        }
        if (i == _kNumberDots - 1 && status == AnimationStatus.dismissed) {
          if (mounted) {
            await _animationControllers!.first.forward();
          }
        }
      });
    }

    if (mounted) {
      _animationControllers!.first.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _animationControllers![index],
            builder: (context, child) {
              return Container(
                padding: const EdgeInsets.all(2),
                child: Transform.translate(
                  offset: Offset(0, _animations[index].value),
                  child: SkeletonLoading.instance(
                    duration: const Duration(milliseconds: 1000),
                    color: Colors.white.withOpacity(0.7),
                    highLightColor: Colors.white,
                    child: const _Dot(
                      color: Colors.white,
                      radius: 6.0,
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color? color;
  final double? radius;

  const _Dot({
    Key? key,
    @required this.color,
    @required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      height: radius,
      width: radius,
    );
  }
}

class ButtonStatus extends StatelessWidget {
  const ButtonStatus(
      {super.key,
      this.state,
      this.label,
      this.radius = 31.0,
      this.mainAxisAlignment = MainAxisAlignment.end});
  final ButtonState? state;
  final String? label;
  final double radius;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    var temp = state != null
        ? state!
        : ButtonState.values.firstWhere((element) => element.name == label);
    final color =
        state != null ? buttonStatusColor(state!) : buttonStatusColor(temp);
    final text = statusValues.reverse[temp] ?? statusValues.reverse[state];
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 24.0,
          decoration: ShapeDecoration(
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          child: Center(
            child: Text(text!,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.buttonStatus),
          ),
        ),
      ],
    );
  }

  Color buttonStatusColor(ButtonState state) {
    try {
      switch (state) {
        case ButtonState.APPROVED:
        case ButtonState.COMPLETED:
          return AppColors.complete;
        case ButtonState.WAITINGFORAPPROVE:
        case ButtonState.MEDIUM:
          return AppColors.warning;
        case ButtonState.CANCEL:
        case ButtonState.CANCELLED:
        case ButtonState.HIGH:
          return AppColors.red;
        case ButtonState.NOTPASS:
          return AppColors.error;
        case ButtonState.ASSIGNED:
          return AppColors.blue;
        case ButtonState.WAITINGASSIGNMENT:
          return AppColors.purple;
        case ButtonState.NOTSTARTYET:
          return AppColors.neutral70;
        case ButtonState.CHECKING:
        case ButtonState.LOW:
          return AppColors.yellowDark15;
        case ButtonState.PDCHECK:
          return AppColors.yellowDark25;
        case ButtonState.QCCHECK:
          return AppColors.yellowDark35;
        case ButtonState.MATERIALREQUEST:
        case ButtonState.REPAIRING:
          return AppColors.organgeDark15;
        case ButtonState.WAITINGEXWAREHOUSE:
          return AppColors.purpleDark15;
        case ButtonState.EXPORTED:
        case ButtonState.KTVCONFIRM:
          return AppColors.inProgress;
        case ButtonState.DONEWAITINGKTVCONFIRM:
        case ButtonState.WAITINGREVIEW:
          return AppColors.purpleDark25;
        case ButtonState.DOING:
        case ButtonState.MOVED:
          return AppColors.orange;
        default:
          return AppColors.complete;
      }
    } catch (ex) {
      return AppColors.complete;
    }
  }
}
