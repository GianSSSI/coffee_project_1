import 'package:coffee/core/injection/dependency_injection.dart';
import 'package:coffee/features/index/bloc/local_bloc/fetching/fetch_local_coffee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});
  void _onTap(int index) {
    if (index == navigationShell.currentIndex) {
      navigationShell.goBranch(index, initialLocation: true);
    } else {
      navigationShell.goBranch(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<FetchLocalCoffeeBloc>()),
      ],
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromRGBO(223, 215, 193, 1),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.brown,
          currentIndex: navigationShell.currentIndex,
          onTap: _onTap,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
        ),
      ),
    );
  }
}
