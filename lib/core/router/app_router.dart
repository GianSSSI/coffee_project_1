import 'package:coffee/core/injection/dependency_injection.dart';
import 'package:coffee/core/router/app_routes.dart';
import 'package:coffee/core/widgets/main_shell.dart';
import 'package:coffee/features/coffee/bloc/local_bloc/fetching/fetch_local_coffee_bloc.dart';
import 'package:coffee/features/coffee/bloc/remote_bloc/coffee_bloc.dart';
import 'package:coffee/features/coffee/model/coffee/local_coffee/local_coffee_model.dart';
import 'package:coffee/features/coffee/model/coffee/remote_coffee/remote_coffee_model.dart';
import 'package:coffee/features/coffee/ui/screens/coffee_favorites_screen.dart';
import 'package:coffee/features/coffee/ui/screens/coffee_home_screen.dart';
import 'package:coffee/features/coffee/ui/screens/coffee_local_details_screen.dart';
import 'package:coffee/features/coffee/ui/screens/coffeee_details_screen.dart';
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
                create: (context) =>
                    // sl<FetchLocalCoffeeBloc>()..add(FetchLocalCoffee()), //uses sqflite methods to insert
                    sl<FetchLocalCoffeeBloc>()..add(FetchLocalCoffeeViaXml()),
                child: const CoffeeFavoritesScreen(),
              ),
              routes: [
                GoRoute(
                  name: AppRoutes.localDetails.name,
                  path: AppRoutes.localDetails.path,
                  builder: (context, state) {
                    final coffee = state.extra as LocalCoffee;
                    return CoffeeLocalDetailsScreen(coffee: coffee);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
