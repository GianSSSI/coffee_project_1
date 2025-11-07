import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee/features/coffee/model/coffee/remote_coffee/remote_coffee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoffeeGridCard extends StatelessWidget {
  final RemoteCoffee coffee;
  const CoffeeGridCard({required this.coffee, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),

              child: Hero(
                tag: coffee.id,
                child: CachedNetworkImage(
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
          ),

          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                coffee.title,
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
