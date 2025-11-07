import 'package:coffee/core/router/app_routes.dart';
import 'package:coffee/features/coffee/bloc/local_bloc/fetching/fetch_local_coffee_bloc.dart';
import 'package:coffee/features/coffee/ui/widgets/coffee_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CoffeeFavoritesScreen extends StatefulWidget {
  const CoffeeFavoritesScreen({super.key});

  @override
  State<CoffeeFavoritesScreen> createState() => _CoffeeFavoritesScreenState();
}

class _CoffeeFavoritesScreenState extends State<CoffeeFavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Coffee List")),
      body: BlocBuilder<FetchLocalCoffeeBloc, FetchLocalCoffeeState>(
        builder: (context, state) {
          if (state.status == FetchCoffeeStatus.failed) {
            return Center(child: Text(state.errorMessage!));
          }

          if (state.status == FetchCoffeeStatus.success) {
            final coffeeList = state.coffeeList;

            if (coffeeList.isEmpty) {
              return const Center(
                child: Text(
                  "No saved coffee yet",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              itemCount: coffeeList.length,
              itemBuilder: (context, index) {
                final coffee = coffeeList[index];
                return InkWell(
                  onTap: () => context.pushNamed(
                    AppRoutes.localDetails.name,
                    extra: coffee,
                  ),
                  child: CoffeeListCard(coffee: coffee),
                );
              },
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
