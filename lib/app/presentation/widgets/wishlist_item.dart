import 'package:flutter/material.dart';

import '../../utility.dart';

class WishlistItem extends StatelessWidget {
  final int id;
  final String productName, imageUrl;
  final int productId, price;
  final VoidCallback action;
  final VoidCallback route;
  const WishlistItem({
    required this.id,
    required this.productName,    
    required this.productId,
    required this.imageUrl,
    required this.price,
    required this.action,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        action();
      },
      child: GestureDetector(
        onTap: route,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
          margin: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(imageUrl,fit: BoxFit.fill,))),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.57,
                    height: MediaQuery.of(context).size.height * 0.05,
                      child: Text(productName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 2, overflow: TextOverflow.clip,)),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.08,),             
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.57,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Price:"),
                          Text(CurrencyFormatter.convertToIdr(price).toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),        
                                      
                  ],
                
              )
            ],
          ),),
        ),
      ),
    );
  }
}
