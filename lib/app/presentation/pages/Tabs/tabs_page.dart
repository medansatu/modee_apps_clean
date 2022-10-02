import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:injector/injector.dart';

import './tabs_controller.dart';
import '../Cart/cart_page.dart';
import '../Home/home_page.dart';
import '../wishlist/wishlist_page.dart';
import '../Profile/profile_page.dart';

class TabsPage extends View{
  static const routeName = '/tabs';
  final int idx;
  TabsPage(this.idx, {Key? key}) : super(key: key);  
  
  @override
  State<StatefulWidget> createState() {
    final tabsController = Injector.appInstance.get<TabsController>();
    return _TabsViewState(tabsController);
  }
}

class _TabsViewState extends ViewState<TabsPage, TabsController> {
  _TabsViewState(super.controller);
  // List<Map<String, Object>> _pages = [];  

  
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _selectedPageIndex = widget.idx;    
    super.initState();
  }

  final List<Map<String, Object>> _pages = [
      {
        'page': HomePage(),
        'title' : 'Home',
      },
      {
        'page': CartPage(),
        'title' : 'Cart',
      },
      {
        'page': WishlistPage(),
        'title' : 'Wishlist',
      },
      {
        'page': ProfilePage(),
        'title' : 'Profile',
      },
    ];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }


  
  @override
  // TODO: implement view
  Widget get view => Scaffold(
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed ,
        onTap: _selectPage,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label:  "Profile",
          ),
        ],
      ),
    );
}