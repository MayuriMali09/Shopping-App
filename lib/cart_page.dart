import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/cart_provider.dart';
import 'package:shoppingapp/globalvariables.dart';
import 'package:shoppingapp/login_page.dart';
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String,dynamic>> cart=Provider.of<CartProvider>(context).cart;
    bool signup=Provider.of<CartProvider>(context).isSignUP;
    String mailId=Provider.of<CartProvider>(context).mail;
    return Scaffold(
      appBar:AppBar(
        title:const Text('My Cart'),
      ),
      body: 
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.length,
                    itemBuilder: (context,index){
                       final cartItem=cart[index];
                       //price=price+cartItem['price'];

                       return ListTile(
                         leading: CircleAvatar(
                           backgroundImage: AssetImage(cartItem['imageUrl'].toString()),
                           radius: 45,
                         ),
                         trailing: IconButton(
                           onPressed: (){
                             showDialog(context: context, builder:(context){
                               return Dialog(
                                 child: Container(
                                   height: 150,
                                   width: 140,
                                   padding:const EdgeInsets.all(10),
                                   child: Column(
                                     children: [
                                       const Text('Are you sure you want to delete the product?',
                                       style: TextStyle(
                                         color: Colors.black,
                                       ),
                                       ),
                                       const SizedBox(height: 20,),
                                       Row(
                                         children: [
                                           TextButton(onPressed: (){
                                             Provider.of<CartProvider>(context,listen: false).removeProduct(cartItem);
                                             Navigator.of(context).pop();//to pop the dialog
                                             price=price-cartItem['price'];
                                           },
                                             child:const Text('Yes',
                                               style:TextStyle(color:Colors.red),
                                             ),
                                           ),
                                           TextButton(onPressed: (){
                                             Navigator.of(context).pop();
                                           },
                                             child:const Text('No',
                                               style:TextStyle(color:Colors.blue),
                                             ),
                                           )
                                         ],
                                       ),
                                     ],
                                   ),
                                 ),
                               );
                             });
                           },
                           icon:const Icon(Icons.delete_outline_outlined),color: Colors.red,
                         ),
                         title: Text(cartItem['title'].toString(),
                         style: Theme.of(context).textTheme.bodySmall),
                         subtitle: Text('Size:${cartItem['sizes']}'),
                       );
                    },
                ),
              ),
               // Text('Total Price:$price'),
               Text(
               'Total Price: \$${price.toStringAsFixed(2)}',
               ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                  width: 200,
                  child: ElevatedButton(onPressed: (){
                    if(signup==true){
                      Provider.of<CartProvider>(context,listen: false).addOrder();
                      if(cart.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cart is empty add to cart to place a Order'),
                          ),
                        );
                      }
                      else{
                        String shoeorder = cart.map((shoe) => shoe['title']).join(', ');
                        String size=cart.map((shoe) => shoe['sizes']).join(', ');
                        String prize=price.toStringAsFixed(2);
                        CollectionReference collref=FirebaseFirestore.instance.collection('orders');
                        collref.add({
                          'email':mailId,
                          'order':shoeorder,
                          'prize':prize,
                          'size':size,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Order Placed!'),
                          ),
                        );
                      }
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please SignUp to place order'),
                        ),
                      );
                    }

                    }, child:const Text('Place Order'),
                  ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),





    );
  }
}
