import 'package:flutter/material.dart';
import 'package:modul_2/DATABASE/accountDatabase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UIEditProfile extends StatefulWidget {
  const UIEditProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<UIEditProfile> createState() => _UIEditProfileState();
}

class _UIEditProfileState extends State<UIEditProfile> {
  String email = '';
  String password ='';
  String username = '';
  String savedId = 'kosong';

  SharedPreferences? prefs;

  getLocalData()async{
    final prefs = await SharedPreferences.getInstance();
    savedId = prefs.getString('idSave')!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocalData();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildTextField(String hint, TextEditingController controller) {
      return Container(
        margin: EdgeInsets.all(4),
        child: TextField(
          decoration: InputDecoration(
              labelText: hint,
              
          ),
          controller: controller,
        ),
      );
    }

    var usernameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    Map<String, dynamic> currUser = new Map();

    void update(Map<String, dynamic>? user)async{
      await AccountDatabase.instance.update(user!);
      print('berhasil');
    }

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8),
        height: 495,
        width: 500,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Text('EDIT PROFILE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 89, 0),
              child: Text('Insert new Username :', style: TextStyle(
                fontSize: 12,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: buildTextField('USERNAME', usernameController),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 130, 0),
              child: Text('Insert email :', style: TextStyle(
      fontSize: 13,)),
            ),
            buildTextField('EMAIL', emailController),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 110, 0),
              child: Text('Insert password :', style: TextStyle(
      fontSize: 13,)),
            ),
            buildTextField('PASSWORD', passwordController),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          email = emailController.text;
                          password = passwordController.text;
                          username = usernameController.text;
                          currUser['id'] = int.parse(savedId);
                          currUser['email'] = email;
                          currUser['password'] = password;
                          currUser['username'] = username;
                          print(currUser['username']);
                          update(currUser);
                          Navigator.pop(context);
                        },
                        child: Text('CONFIRM'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
