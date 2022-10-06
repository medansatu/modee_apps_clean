import 'package:flutter/material.dart';

import '../../utility.dart';

class ProductDetail extends StatelessWidget {
  final String? imageUrl;
  final int? price;
  final String? productName;
  final String? description;

  ProductDetail({
    required this.imageUrl,
    required this.price,
    required this.productName,
    this.description = ""
  });

  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            height: MediaQuery.of(context).size.width,
            child: Image.network(imageUrl!),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
            child: Text(CurrencyFormatter.convertToIdr(price!), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(productName!, style: TextStyle(fontSize: 18, ),),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(description!, style: TextStyle(fontSize: 16,), textAlign: TextAlign.start,),
          ),
        ],
      ),
    );
  }
}
