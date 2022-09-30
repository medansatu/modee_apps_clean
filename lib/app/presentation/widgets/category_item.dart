import 'package:flutter/material.dart';



class CategoryItem extends StatelessWidget {
  final int id;
  final String? categoryName;
  final String? imageUrl;
  final VoidCallback route;

  CategoryItem(
    {required this.id, required this.categoryName, required this.imageUrl, required this.route});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              route();
              // Navigator.of(context).pushNamed(CategoryItemsScreen.routeName, arguments: ({"id" : id, "name": categoryName}));
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
          Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
              child: Text(
                categoryName!,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )),
        ],
      ),
    );
  }
}
