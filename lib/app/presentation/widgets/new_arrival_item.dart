import 'package:flutter/material.dart';

import '../../utility.dart';

class NewArrivalItem extends StatelessWidget {
  final int id;
  final String? imageUrl;
  final int? price;
  final VoidCallback route;

  NewArrivalItem({
    required this.id, 
    required this.imageUrl, 
    required this.price, 
    required this.route});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              route();
            },
            splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
            child: Ink(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.fill,
                  )),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 5,
            child: Container(
              width: 100,
              color: Colors.black.withOpacity(0.4),
              padding: EdgeInsets.all(5),
              // width: 200,
              child: Text(
                CurrencyFormatter.convertToIdr(price!),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                softWrap: true,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
