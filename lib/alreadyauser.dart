import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/auth_service.dart';
import 'package:shoppingapp/cart_provider.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final auth=AuthService();
  final TextEditingController mail=TextEditingController();
  final TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Login')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const Text('ALready a User',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
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
          const SizedBox(height: 30,),
          ElevatedButton(onPressed: ()async{
            final User=await auth.loginUserWithEmailAndPassword(mail.text, password.text);
            if(User!=null) {
              Provider.of<CartProvider>(context,listen: false).SignedUp();
              Provider.of<CartProvider>(context,listen: false).getMail(mail.text);
              showDialog(context: context, builder: (context){
                return Dialog(
                    child: Container(
                      height: 100,
                      width: 50,
                      padding:const EdgeInsets.all(10),
                      child:const Text('Login in succesfully',style:TextStyle(color:Colors.blue),),
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
                      child:const Text('Unable to Login in, please recheck email and password',
                        style:TextStyle(color:Colors.red),),
                    )
                );
              });
            }

            }
            , child: const Text('Login'),),
      ]
    )
    );
  }
}
