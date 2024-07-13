import 'package:flutter/material.dart';
class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final String image;
  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Container(//if you have used box decoration you have to use color
      //property of box decoration only not of container it gives error
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.lightBlue[50],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height:5),
          Text('\$$price',style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height:5),
          Center(
            child: Image(
                image: AssetImage(image),
                height: 300,
                width: 300,
            ),
          )
        ],
      ),
    );
  }
}
