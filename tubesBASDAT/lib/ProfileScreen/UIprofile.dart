import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modul_2/DATABASE/accountDatabase.dart';
import 'UIEditProfile.dart';
import '../HomeScreen/first.dart';

class UIprofile extends StatefulWidget {
  const UIprofile({Key? key}) : super(key: key);

  @override
  State<UIprofile> createState() => _UIprofileState();
}

class _UIprofileState extends State<UIprofile> {
  String savedId = 'kosong';
  bool checkLogin = false;
  String emailUser = 'defaultEmail';
  String namaUser = 'defaultUser';
  List<Map<String, dynamic>>? currUser;

  SharedPreferences? prefs;

  getLocalData()async{
    final prefs = await SharedPreferences.getInstance();
    setState((){
      savedId = prefs.getString('idSave')!;
    });

    currUser = await AccountDatabase.instance.getAccount(int.parse(savedId));

    setState((){
      emailUser = currUser![0]['email'].toString();
      namaUser = currUser![0]['username'].toString();
    });
  }

  setLocalData() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('checkLogin', checkLogin);
    await prefs.setString('idSave', savedId);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocalData();
  }

  @override
  Widget build(BuildContext context) {

    void showEditUI(){
      showDialog(context: context, builder: (_){
        return AlertDialog(
          content: UIEditProfile(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },);
    }

    void deleteAccount(int id)async{
      await AccountDatabase.instance.delete(id);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 5,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.sync),
                      onPressed: (){
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => UIprofile()));
                      },
                    ),
                    Padding(padding: EdgeInsets.zero,
                    child: Text(
                      '$emailUser',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.dangerous_outlined,
                        color: Colors.red,
                        size: 30,),
                        onPressed: (){
                          deleteAccount(int.parse(savedId));
                          checkLogin = false;
                          savedId = 'kosong';
                          setLocalData();
                          Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => first()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.zero,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.FjSRywv2jSoO2kdlijRZ4gHaHa?pid=ImgDet&rs=1'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(18, 15, 0, 0),
                    child: Text('$namaUser',
                    style: TextStyle(
                      fontSize: 17,
                    ),),
                  ),
                ],
              ),),
              Padding(padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      width: 320,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.blueAccent),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Edit Profile', style: TextStyle(
                            color: Colors.blueAccent,
                          ),),
                        ],
                      ),
                    ),
                    onTap: (){
                      print('saved id profile : $savedId');
                      showEditUI();
                    },
                  ),
                ],
              ),)
            ],
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black38),
              ),
              onPressed: (){
                checkLogin = false;
                savedId = 'kosong';
                setLocalData();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => first()));
              },
              child: Text('LOGOUT'),
            ),),
            Padding(padding: EdgeInsets.fromLTRB(70, 0, 0, 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black38),
                ),
                onPressed: (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => first()));
                },
                child: Text('HOME'),
              ),),
          ],
        ),
      ),
    );
  }
}
