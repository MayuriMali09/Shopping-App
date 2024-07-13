import 'package:flutter/cupertino.dart';
//this cart provider is access able though out the app
class CartProvider extends ChangeNotifier{
  bool isSignUP=false;
  String mail="";
  final List<Map<String,dynamic>> cart=[];
   List<Map<String,dynamic>> myOrders=[];
   void getMail(String mailId){
     mail=mailId;
     notifyListeners();
   }

   void SignedUp(){
     isSignUP=true;
     notifyListeners();
   }

  void addProduct(Map<String,dynamic> product){
    cart.add(product);
    notifyListeners();
  }
  //so whenever add to cart button will be clicked this function will be called

  void removeProduct(Map<String,dynamic> product){
    cart.remove(product);
    notifyListeners();
  }
  void addOrder(){
    myOrders=cart;
    notifyListeners();
  }

}