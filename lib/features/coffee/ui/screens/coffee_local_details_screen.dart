import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee/features/coffee/model/coffee/local_coffee/local_coffee_model.dart';
import 'package:coffee/helpers/validation/url_checker/url_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoffeeLocalDetailsScreen extends StatefulWidget {
  final LocalCoffee coffee;
  const CoffeeLocalDetailsScreen({super.key, required this.coffee});

  @override
  State<CoffeeLocalDetailsScreen> createState() =>
      _CoffeeLocalDetailsScreenState();
}

class _CoffeeLocalDetailsScreenState extends State<CoffeeLocalDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final coffee = widget.coffee;
    return Scaffold(
      appBar: AppBar(title: Text("My Coffee Summary")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Hero(
              tag: coffee.coffeeId,
              child: isValidUrl(coffee.image)
                  ? CachedNetworkImage(
                      imageUrl: coffee.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    )
                  : SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: SvgPicture.asset(
                        'assets/svg/coffee_bean.svg',
                        fit: BoxFit.cover,
                      ),
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
                    coffee.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 15),
                  Text(
                    "Label/Note",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    coffee.label,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 15),

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
