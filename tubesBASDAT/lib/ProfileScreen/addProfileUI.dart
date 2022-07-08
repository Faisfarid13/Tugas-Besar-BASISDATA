import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modul_2/ProfileScreen/loginUI.dart';
import 'package:modul_2/ProfileScreen/regisUI.dart';
import 'package:shared_preferences/shared_preferences.dart';

class addProfile extends StatefulWidget {
  const addProfile({Key? key}) : super(key: key);

  @override
  _addProfileState createState() => _addProfileState();
}

class _addProfileState extends State<addProfile> {
  String savedId = 'savedID';

  getLocalData()async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedId = prefs.getString('idSave')!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocalData();
  }

  @override
  Widget build(BuildContext context) {

    void showLoginUI(){
      showDialog(context: context, builder: (_){
        return AlertDialog(
          content: loginUI(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },);
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 5,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 350, 25, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                        child: Text(
                            'There is no account yet',
                          style: TextStyle(
                            fontSize: 22
                          ),
                        ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 300),
                        child: ClipOval(
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                            ),
                            child: IconButton(
                                onPressed: (){
                                  print('save id add profile : $savedId');
                                  showLoginUI();
                                },
                                icon: Icon(Icons.add, color: Colors.white, size: 40,)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
