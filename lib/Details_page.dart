import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/cart_provider.dart';
import 'package:shoppingapp/globalvariables.dart';
class ProductDetailsPage extends StatefulWidget {
  final Map<String,Object>Product;
  const ProductDetailsPage({
    super.key,
    required this.Product,
  }
  );

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedsize=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.Product['title'] as String,
              style:Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 5,),
          Padding(
              padding:const EdgeInsets.all(10),
              child: Image.asset(widget.Product['imageUrl'] as String,
              height: 250,),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Container(
                 width: double.infinity,
                decoration:BoxDecoration(
                color:Colors.lightBlue[50],
                  borderRadius:const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
              ),
              child: Column(
               children: [
                 const SizedBox(height: 20),
                Text('\$${widget.Product['price']}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                 const Row(//col centers everything so to bring sizes to left we add it in column
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: 16.0),
                       child: Text(
                         'Sizes:',
                         textAlign: TextAlign.start,
                       ),
                     ),
                   ],
                 ),
                 const SizedBox(height: 15),
                 SizedBox(
                   height: 50,
                   child: ListView.builder(
                     //note that Product['sizes'] is a object
                     //and we cannot access index of object so we have again treat it as something to use index property on it
                     scrollDirection: Axis.horizontal,
                     itemCount: (widget.Product['sizes'] as List<int>).length,//here we are doing .length on an object so we have to do as double and give bracktes as well
                     itemBuilder: (context,index){
                       final size = (widget.Product['sizes'] as List<int>)[index];//it is of type int so selectedsize is also of type int intially when declared
                       return Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: GestureDetector(
                           onTap: (){
                               setState(() {
                                 selectedsize=size;
                               });
                           },
                           child: Chip(
                                 backgroundColor:selectedsize==size//it is telling if user has selected any filter the change the color of that chip to primary color
                                 ?Theme.of(context).colorScheme.primary
                                 : null,
                               label: Text(size.toString()),
                           ),
                         ),
                       );
                     },),
                 ),
              ],
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: (){

                if(selectedsize==0){
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a size!'),
                      ),
                  );
                }
                else {
                  double currprice=widget.Product['price'] as double;
                  price=price+currprice;
                  Provider.of<CartProvider>(context, listen: false).addProduct(
                      {
                        'id': widget.Product['id'],
                        'title': widget.Product['title'],
                        'price': widget.Product['price'],
                        'imageUrl': widget.Product['imageUrl'],
                        'company': widget.Product['company'],
                        'sizes': selectedsize
                      }
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Product added successfully'),
                    ),
                  );
                }
              },//wrapped with padding
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  fixedSize: const Size(350, 60)
              ),
              child:const Text(
                'Add to Cart',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}//products['title'] as String
