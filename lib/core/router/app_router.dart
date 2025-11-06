import 'package:coffee/core/injection/dependency_injection.dart';
import 'package:coffee/core/router/app_routes.dart';
import 'package:coffee/core/widgets/main_shell.dart';
import 'package:coffee/features/index/bloc/remote_bloc/coffee_bloc.dart';
import 'package:coffee/features/index/model/coffee/remote_coffee_model.dart';
import 'package:coffee/features/index/ui/screens/coffee_favorites_screen.dart';
import 'package:coffee/features/index/ui/screens/coffee_home_screen.dart';
import 'package:coffee/features/index/ui/screens/coffeee_details_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: AppRoutes.home.path,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoutes.home.name,
              path: AppRoutes.home.path,
              builder: (context, state) => BlocProvider(
                create: (context) => sl<CoffeeBloc>()..add(FetchHotCoffee()),
                child: const CoffeeHomeScreen(),
              ),
              routes: [
                GoRoute(
                  name: AppRoutes.details.name,
                  path: AppRoutes.details.path,
                  builder: (context, state) {
                    final coffee = state.extra as RemoteCoffee;
                    return CoffeeDetailsScreen(coffee: coffee);
                  },
                ),
              ],
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoutes.favorites.name,
              path: AppRoutes.favorites.path,
              builder: (context, state) => BlocProvider(
                create: (context) => sl<CoffeeBloc>(),
                child: const CoffeeFavoritesScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
