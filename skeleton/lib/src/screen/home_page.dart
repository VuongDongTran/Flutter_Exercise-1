import 'package:flutter/material.dart';
import '../common/app_helper.dart';
import '../theme/colors_theme.dart';
import '../widgets/bottom_appbar.dart';
import 'movies/movies_tab_page.dart';
import 'tv_shows/tv_shows_tab_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  
  // List of tab pages - Only Movies and TV Shows
  final List<Widget> _tabPages = const [
    MoviesTabPage(),
    TVShowsTabPage(),
  ];
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppHelper.isTablet()
            ? CustomBottomAppbar(
                currentIndex: _currentIndex,
                onTabChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              )
            : const SizedBox.shrink(),
        Expanded(
          child: GestureDetector(
            onHorizontalDragUpdate: (details) => _handleBack(details, context),
            child: Scaffold(
              backgroundColor: AppColors.white,
              body: _buildCurrentPage(),
              bottomNavigationBar: AppHelper.isTablet()
                  ? null
                  : CustomBottomAppbar(
                      currentIndex: _currentIndex,
                      onTabChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentPage() {
    // Return the page based on current index
    if (_currentIndex >= 0 && _currentIndex < _tabPages.length) {
      return _tabPages[_currentIndex];
    }
    return const MoviesTabPage(); // Default fallback to Movies
  }

  void _handleBack(DragUpdateDetails details, BuildContext context) {
    int sensitivity = 8;
    if (details.delta.dx > sensitivity) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
  }
}
