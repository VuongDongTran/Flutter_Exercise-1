import 'package:flutter/material.dart';

import '../base/widget/base_statefull_widget.dart';
import '../bloc/loading/loading_cubit.dart';
import '../routers/route_key.dart';

class LoadingPage extends BaseStatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState
    extends BaseStatefulWidgetState<LoadingCubit, LoadingPage> {
  @override
  void initState() {
    _initView();
    super.initState();
  }

  Future<void> _initView() async {
    bloc.loadingPage();
    await Future<void>.delayed(const Duration(seconds: 3)).then((value) {
      bloc.loadingSink.add(false);
      Navigator.of(context).pushReplacementNamed(RouteKey.home);
    });
  }

  @override
  Widget buildBody(BuildContext context) {
    return Container();
  }
}
