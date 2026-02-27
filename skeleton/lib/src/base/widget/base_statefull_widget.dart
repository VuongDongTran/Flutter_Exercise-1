import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import '../../common/app_helper.dart';

import '../bloc/base_cubit.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({Key? key}) : super(key: key);
}

abstract class BaseStatefulWidgetState<B extends BaseCubit<dynamic>,
        S extends BaseStatefulWidget> extends State<S>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin<S> {
  final B bloc = GetIt.I.get<B>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    
    // Listen to loading state changes
    bloc.loadingStream.listen((event) {
      if (event) {
        EasyLoading.show();
      } else {
        EasyLoading.dismiss();
      }
    });
    
    // Listen to error state changes
    bloc.errorStream.listen((event) {
      showErrorMessage(context, event);
    });
    
    // Call BLoC initialization
    bloc.initState();
    super.initState();
  }

  @override
  // Keep widget state alive when navigating away
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    bloc.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        bloc.onResume();
        onResume();
        break;
      case AppLifecycleState.paused:
        bloc.onPause();
        onPause();
        break;
      case AppLifecycleState.inactive:
        bloc.onInactive();
        onInactive();
        break;
      default:
        bloc.onDetach();
        onDetach();
    }
    super.didChangeAppLifecycleState(state);
  }

  @mustCallSuper
  void onResume() {}

  @mustCallSuper
  void onPause() {}

  @mustCallSuper
  void onDetach() {}

  @mustCallSuper
  void onInactive() {}

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final defaultPadding = EdgeInsets.symmetric(
      vertical: AppHelper.isTablet() ? 16 : 0,
      horizontal: AppHelper.isTablet() ? 34.0 : 0,
    );
    return Padding(
      padding: padding ?? defaultPadding,
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context);

  EdgeInsets? padding;

  void showErrorMessage(BuildContext context, String message) {}
}

