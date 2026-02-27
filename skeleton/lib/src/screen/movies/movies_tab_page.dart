import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_dependency.dart';
import '../../bloc/movies/movies_cubit.dart';
import 'movies_page.dart';

class MoviesTabPage extends StatelessWidget {
  const MoviesTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoviesCubit>(
      create: (_) => AppDependencies.injector.get<MoviesCubit>(),
      child: const MoviesPage(),
    );
  }
}
