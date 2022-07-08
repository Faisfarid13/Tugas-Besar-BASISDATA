import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modul_2/Authentication/auth.dart';
import 'package:modul_2/Database/accountDatabase.dart';
import 'package:modul_2/Database/accountModel.dart';

class regisUI extends StatefulWidget {
  const regisUI({Key? key}) : super(key: key);

  @override
  _regisUIState createState() => _regisUIState();
}

class _regisUIState extends State<regisUI> {

  void initState(){
    super.initState();
  }

  Color _notifColor = Colors.white;

  late String email;
  late String password;
  late String username;

  @override
  Widget build(BuildContext context) {
    Widget buildTextField(String hint, TextEditingController controller) {
      return Container(
        margin: EdgeInsets.all(4),
        child: TextField(
          decoration: InputDecoration(
              labelText: hint,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black38,
                ),
              )
          ),
          controller: controller,
        ),
      );
    }

    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var usernameController = TextEditingController();

    return Container(
      padding: EdgeInsets.all(8),
      height: 400,
      width: 400,
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(bottom: 20),
            child: Text('SIGN UP',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.blueAccent,
            ),),
          ),
          Padding(padding: EdgeInsets.only(bottom: 3),
            child: Text('your account was successfully registered', style: TextStyle(
              color: _notifColor, fontSize: 13,
            ),),
          ),
          Padding(
              padding:EdgeInsets.only(bottom: 10),
            child: buildTextField('EMAIL', emailController),
          ),
         Padding(
           padding: EdgeInsets.only(bottom: 10),
           child:  buildTextField('PASSWORD', passwordController),
         ),
          Padding(
            padding:EdgeInsets.only(bottom: 10),
            child: buildTextField('USERNAME', usernameController),
          ),
          Padding(
              padding: EdgeInsets.only(top: 14),
            child: ElevatedButton(
              onPressed: (){
                email = emailController.text;
                password = passwordController.text;
                username = usernameController.text;

                addAccount();

                emailController.clear();
                passwordController.clear();
                usernameController.clear();

                setState(() {
                  _notifColor = Colors.red;
                });
              }, child: Text("SUBMIT"),
            ),
          ),
        ],
      ),
    );
  }

  Future addAccount()async{
    final account = Account(
      email: email,
      password: password,
      username: username,
    );

    await AccountDatabase.instance.create(account) ;
  }
}
