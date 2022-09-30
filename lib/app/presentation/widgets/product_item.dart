import 'package:flutter/material.dart';

import '../../utility.dart';

class ProductItem extends StatelessWidget {
  final int id;
  final String? productName;
  final int? price;
  final String? description;
  final String? imageUrl;
  final VoidCallback route;

  ProductItem({
    required this.id,
    required this.description,
    required this.price,
    required this.productName,
    required this.imageUrl,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        route();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                imageUrl!,
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  productName!,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                CurrencyFormatter.convertToIdr(price!),
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
