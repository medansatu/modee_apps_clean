import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../utility.dart';

class CartItem extends StatelessWidget {
  final int id;
  final String productName, imageUrl;
  final int price, quantity, productId;
  final VoidCallback action;
  final VoidCallback addQty;
  final VoidCallback deductQty;

  const CartItem({
    required this.id,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.productId,
    required this.imageUrl,
    required this.action,
    required this.addQty,
    required this.deductQty,
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
                    child: Text(productName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 2, overflow: TextOverflow.clip,)),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05,),              
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.57,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Quantity"),
                        const SizedBox(width: 10,),
                        Row(
                          children: [
                            IconButton(constraints: BoxConstraints(maxHeight: 40, maxWidth: 40), onPressed: deductQty, icon: const Icon(Icons.remove, size: 20,)),
                            Text(quantity.toString()),
                            IconButton(constraints: BoxConstraints(maxHeight: 40, maxWidth: 25), onPressed: addQty, icon: const Icon(Icons.add, size: 20,)),
                          ],
                        ),
                      ],
                    ),
                  ),   
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),               
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
    );
  }
}
