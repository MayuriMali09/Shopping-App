import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/auth_service.dart';
import 'package:shoppingapp/cart_provider.dart';
import 'package:shoppingapp/alreadyauser.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final auth=AuthService();
  final TextEditingController mail=TextEditingController();
  final TextEditingController password=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final orders=Provider.of<CartProvider>(context).myOrders;
    bool signup=Provider.of<CartProvider>(context).isSignUP;
    return Scaffold(
      appBar:AppBar(
        title:const Text('User SignUp'),
      ),
      body: Padding(
        padding:const EdgeInsets.all(20.0),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('SignUp',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            const SizedBox(height: 25),
            TextField(
              controller: mail,
              decoration:const  InputDecoration(
              hintText: 'Email',
              hintStyle:TextStyle(
                color: Colors.black,
              ),
                prefixIcon: Icon(Icons.email_outlined),
                prefixIconColor: Colors.black
            ),

            ),
            const SizedBox(height: 25),
            TextField(
              obscureText: true,
              controller: password,
              decoration:const InputDecoration(
              hintText: 'Password',
              hintStyle:TextStyle(
                color: Colors.black,
              ),
                prefixIcon: Icon(Icons.password_outlined),
                prefixIconColor: Colors.black,
            ),
            ),
            const SizedBox(height: 35),
            Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(onPressed: () async{
                    final User=await auth.createUserWithEmailAndPassword(mail.text,password.text);
                    if(User!=null) {
                      Provider.of<CartProvider>(context,listen: false).SignedUp();
                      Provider.of<CartProvider>(context,listen: false).getMail(mail.text);
                       showDialog(context: context, builder: (context){
                        return Dialog(
                          child: Container(
                            height: 100,
                            width: 50,
                            padding:const EdgeInsets.all(10),
                            child:const Text('Siggned in succesfully',style:TextStyle(color:Colors.blue),),
                          )
                        );
                      });
                    }
                    else{
                      showDialog(context: context, builder: (context){
                        return Dialog(
                            child: Container(
                              height: 100,
                              width: 50,
                              padding:const EdgeInsets.all(10),
                              child:const Text('Unable to Sign in, please recheck email and password',
                                style:TextStyle(color:Colors.red),),
                            )
                        );
                      });
                    }
                    }, child:const Text('SignUp'),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(onPressed: (){
                    Provider.of<CartProvider>(context,listen: false).isSignUP=false;
                    auth.signOut();
                   }, child:const Text('SignOut'),),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(width: 100,),
                const Text('Already a user!'),
                SizedBox(
                  height: 50,
                  width: 80,
                  child: TextButton(onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context){
                          return Login();
                        })
                    );
                   }, child:const Text('Login'),
                  ),
                ),
              ],
            ),
            const Text('My Orders'),
            
               Expanded(
                 child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder:(context,index){
                      final cartItem=orders[index];
                      return ListTile(
                        leading: Text(cartItem['title']),
                        trailing: Text(cartItem['price'].toString()),
                 
                      );
                    }
                    ),
               ),
            
            // SizedBox(
            //   width: 100,
            //   child: ElevatedButton(onPressed: (){
            //     auth.signOut();
            //    }, child:const Text('SignOut'),),
            // ),
          ],
        ),
      )
    );
  }
}
