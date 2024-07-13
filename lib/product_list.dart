import 'package:flutter/material.dart';
import 'package:shoppingapp/globalvariables.dart';
import 'Details_page.dart';
import 'package:shoppingapp/product_card.dart';
class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters=const [
    'All',
    'Adidas',
    'Nike',
    'Puma'
  ];
  late String selectedfilter;
  @override
  void initState() {//used for initialisations before calling built
    // TODO: implement initState
    super.initState();
    selectedfilter=filters[0];//before user selects any filter default selected is filters[0] that is all
  }
  @override
  Widget build(BuildContext context) {
    const border=OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(50),
        )
    );
    return Scaffold(
      body:
      SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding:const EdgeInsets.all(15.0),
                  child: Text('Shoes\nCollection',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Expanded(//take as much space possible in row or column no need to give height and weight
                  //its very imp widget to make app for all screen sizes **
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'search',
                      prefixIcon: Icon(Icons.search),
                      border:border,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 65,
              child: ListView.builder(
                itemCount: filters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  final filter = filters[index];
                  return Padding(//we were returning chip we added padding outside the chip
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0
                    ),
                    child: GestureDetector(//its child is chip
                      onTap: (){
                        setState(() {//will rebuilt the built functions
                          selectedfilter=filter;
                        });
                      },
                      child: Chip(
                        backgroundColor:selectedfilter==filter//it is telling if user has selected any filter the change the color of that chip to primary color
                            ?Theme.of(context).colorScheme.primary
                            : Colors.black12,
                        label:Text(filter),
                        labelStyle:const TextStyle(
                          fontSize: 16,
                        ),
                        padding:const EdgeInsets.all(15),//it is padding inside the chip
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                //here also list view builder tries to take entire length
                //so we will wrap it with expanded
                itemCount: products.length,
                itemBuilder: (context,index){//it is called to built each item in list
                  final product=products[index];//it is accessing every map of product in products list present in global variables page
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context){
                            return ProductDetailsPage(Product:products[index]);
                          })
                      );
                    },
                    child: ProductCard(
                      title: product['title'] as String,//and now I have map of product from that I want value of title key
                      price: product['price'] as double,
                      image: product['imageUrl'] as String,//we are telling that we are sure it is string
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}
