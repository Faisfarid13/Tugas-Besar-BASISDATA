import 'package:flutter/material.dart';
import 'package:modul_2/DATABASE/accountDatabase.dart';
import 'package:modul_2/ProfileScreen/regisUI.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modul_2/Authentication/authGoogle.dart';
import 'UIprofile.dart';

class loginUI extends StatefulWidget {
  const loginUI({Key? key}) : super(key: key);

  @override
  _loginUIState createState() => _loginUIState();
}

class _loginUIState extends State<loginUI> {
  bool checkLogin = false;
  String nama = 'nama';
  bool checkEmail = false;
  bool checkPass = false;
  String savedId = 'kosong';
  String idByPass = 'kosong';

  SharedPreferences? prefs;

  saveToLocal()async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('checkLogin', checkLogin);
    await prefs.setString('idSave', savedId);
  }

  Color error = Colors.white;

  @override
  void initState() {
    super.initState();
  }

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

    void showRegisUI(){
      showDialog(context: context, builder: (_){
        return AlertDialog(
          content: regisUI(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },);
    }

    var usernameController = TextEditingController();
    var passwordController = TextEditingController();


    List<Map<String, dynamic>> Listid;
    Future<String> getID(String email) async{
      try{
        Listid = await AccountDatabase.instance.getID(email);
        String ID = Listid[0]['id'].toString();
        return ID;
      }catch(exception){
        setState((){
          error = Colors.red;
        });
        return 'kosong';
      }
    }

    List<Map<String, dynamic>> listIdbyPass;
    Future<String> getIDbyPass(String password) async {
      try{
        listIdbyPass = await AccountDatabase.instance.getIDbyPass(password);
        String ID = listIdbyPass[0]['id'].toString();
        return ID;
      }catch(exception){
       setState((){
         error = Colors.red;
       });
       return 'kosong';
      }
    }

    return Container(
      padding: EdgeInsets.all(8),
      height: 315,
      width: 400,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text('SIGN IN',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.blueAccent,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 5),
            child: Text('WRONG EMAIL/PASSWORD',
            style: TextStyle(
              color: error,
              fontSize: 13,
            ),),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: buildTextField('EMAIL', usernameController),
          ),
          buildTextField('PASSWORD', passwordController),
          Padding(
              padding: const EdgeInsets.only(top: 10),
            child: Wrap(
              children: [
                Text("Don't have account yet? ", style: TextStyle(fontSize: 13),),
                GestureDetector(
                  child: Text('click here',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                  ),
                  ),
                  onTap: showRegisUI,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async{
                        var email = usernameController.text;
                        var password = passwordController.text;

                        checkLogin = true;
                        savedId = await getID(email);
                        idByPass = await getIDbyPass(password);

                        if(savedId.contains('kosong') || idByPass.contains('kosong')){

                        }else {
                          print(savedId);
                          saveToLocal();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => UIprofile()));
                        }
                      },
                      child: Text('LOGIN'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text('OR'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ClipOval(
                      child: Container(
                        height: 40,
                        width: 40,
                        child: GestureDetector(
                          onTap: (){
                            authenticationServiceGoogle service = authenticationServiceGoogle();

                            service.signIn();
                          },
                          child: Image.network('https://th.bing.com/th/id/OIP.atekzJaXPtCjCJ81KBR8lwHaGY?pid=ImgDet&w=1348&h=1162&rs=1'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}