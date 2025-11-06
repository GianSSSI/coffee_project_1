import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee/core/injection/dependency_injection.dart';
import 'package:coffee/features/index/model/coffee/coffee_model.dart';
import 'package:coffee/features/index/ui/widgets/bottom_drawer.dart';
import 'package:coffee/helpers/validation/cubit/form_validation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeDetailsScreen extends StatefulWidget {
  final Coffee coffee;
  const CoffeeDetailsScreen({required this.coffee, super.key});

  @override
  State<CoffeeDetailsScreen> createState() => _CoffeeDetailsScreenState();
}

class _CoffeeDetailsScreenState extends State<CoffeeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final coffee = widget.coffee;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => BlocProvider(
              create: (context) => sl<FormValidationCubit>(),
              child: BottomDrawer(
                title: 'Save Coffee Info',
                content: BlocBuilder<FormValidationCubit, FormValidationState>(
                  buildWhen: (previous, current) =>
                      previous.fieldInput != current.fieldInput,
                  builder: (context, state) {
                    return Column(
                      children: [
                        Text("What should we call this coffee?"),

                        const SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorText: state.fieldInput.errorMessage,
                          ),
                          onChanged: (value) {
                            context.read<FormValidationCubit>().inputChanged(
                              value,
                            );
                          },
                        ),
                        const SizedBox(height: 15),

                        ElevatedButton(onPressed: () {}, child: Text("Save")),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
        backgroundColor: Colors.brown,
        foregroundColor: Color.fromRGBO(223, 215, 193, 1),
        child: Icon(Icons.bookmark),
      ),
      appBar: AppBar(title: Text(coffee.title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Hero(
              tag: coffee.id,
              child: CachedNetworkImage(
                imageUrl: coffee.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    coffee.description,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    "Ingredients",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  ...coffee.ingredients.map(
                    (ingredient) => Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        "• $ingredient",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
