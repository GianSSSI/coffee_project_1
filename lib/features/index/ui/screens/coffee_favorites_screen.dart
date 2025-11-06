import 'package:coffee/features/index/bloc/local_bloc/fetching/fetch_local_coffee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeFavoritesScreen extends StatefulWidget {
  const CoffeeFavoritesScreen({super.key});

  @override
  State<CoffeeFavoritesScreen> createState() => _CoffeeFavoritesScreenState();
}

class _CoffeeFavoritesScreenState extends State<CoffeeFavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
      body: BlocBuilder<FetchLocalCoffeeBloc, FetchLocalCoffeeState>(
        builder: (context, state) {
          if (state.status == FetchCoffeeStatus.failed) {
            return Center(child: Text(state.errorMessage!));
          }

          if (state.status == FetchCoffeeStatus.success) {
            final coffeeList = state.coffeeList;
            return ListView.builder(
              itemCount: coffeeList.length,
              itemBuilder: (context, index) {
                final coffee = coffeeList[index];
                return ListTile(title: Text(coffee.title));
              },
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
