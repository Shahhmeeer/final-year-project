import 'package:flutter/material.dart';
import 'package:fyp/models/product_model.dart';
import 'package:fyp/screens/items_detail_screen.dart';

class ItemCard extends StatelessWidget {
  final Product _product = Product(
    name: 'Fiddle Leaf',
    price: 1200,
    category: 'plant',
    id: 1,
    imageUrl: 'test',
  );
  ItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ItemsDetail.route);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade900, Colors.green.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/plant.png',
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _product.name,
                      style: const TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Outdoor',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0),
                ),
                child: Container(
                  color: Colors.green.shade100,
                  height: 80.0,
                  width: 90.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Price',
                        style: TextStyle(color: Colors.green.shade900),
                      ),
                      Text(
                        '${_product.price} PKR',
                        style: TextStyle(color: Colors.green.shade900),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
