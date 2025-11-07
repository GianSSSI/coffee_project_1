import 'package:coffee/core/router/app_routes.dart';
import 'package:coffee/features/coffee/bloc/remote_bloc/coffee_bloc.dart';
import 'package:coffee/features/coffee/ui/widgets/coffee_gird_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CoffeeHomeScreen extends StatefulWidget {
  const CoffeeHomeScreen({super.key});

  @override
  State<CoffeeHomeScreen> createState() => _CoffeeHomeScreenState();
}

class _CoffeeHomeScreenState extends State<CoffeeHomeScreen> {
  @override
  void initState() {
    context.read<CoffeeBloc>().add(FetchHotCoffee());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.coffee, color: Colors.brown),
            SizedBox(width: 8),
            Text("Coffee Catalog"),
          ],
        ),
      ),
      body: BlocBuilder<CoffeeBloc, CoffeeState>(
        builder: (context, state) {
          if (state.status == CoffeeStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.status == CoffeeStatus.failure) {
            return Center(
              child: Text(state.errorMessage ?? "Unexpected Error"),
            );
          }

          final coffeeList = state.coffeeList;

          if (coffeeList.isEmpty) {
            return Center(child: Text("No Coffees for YOU"));
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(207, 201, 164, 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: Theme.of(context).textTheme.titleLarge,
                            children: [
                              TextSpan(text: 'Life '),
                              TextSpan(
                                text: 'begins\n ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: 'after '),
                              TextSpan(
                                text: 'coffee.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),

                        SvgPicture.asset(
                          width: 150,
                          height: 150,
                          'assets/svg/coffee_mug.svg',
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: coffeeList.length,
                    itemBuilder: (context, index) {
                      final coffee = coffeeList[index];
                      return InkWell(
                        onTap: () =>
                            context.go(AppRoutes.details.path, extra: coffee),
                        child: CoffeeGridCard(coffee: coffee),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
