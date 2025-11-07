import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee/features/coffee/model/coffee/local_coffee/local_coffee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoffeeListCard extends StatelessWidget {
  final LocalCoffee coffee;
  const CoffeeListCard({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                height: 100,
                imageUrl: coffee.image,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => SvgPicture.asset(
                  fit: BoxFit.fill,
                  'assets/svg/coffee_bean.svg',
                ),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coffee.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(coffee.label),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
