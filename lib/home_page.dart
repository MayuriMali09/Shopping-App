import 'package:flutter/material.dart';
import 'package:shoppingapp/cart_page.dart';
import 'package:shoppingapp/login_page.dart';
import 'package:shoppingapp/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentpage=0;//variable that will keep track of current page
  //so now zero is indication home

  List<Widget>pages=const [
    ProductList(),
    CartPage(),
    LoginPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: //currentpage==0 ?ProductList():currentpage==1?CartPage():LoginPage(),
            pages[currentpage],//same task but in better way
       //**--->after body
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        onTap: (value){
          //value will be what we select 0-home,1-car,2-profile
          setState(() {
            currentpage=value;
          });
        },
        currentIndex: currentpage,
          items:const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Profile',
            ),
          ],
      ),
    );
  }
}
