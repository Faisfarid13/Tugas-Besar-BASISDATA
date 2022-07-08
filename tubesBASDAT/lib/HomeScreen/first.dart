import 'package:flutter/material.dart';
import 'package:modul_2/DATABASE/historyDatabase.dart';
import 'bottomBar.dart';
import 'package:modul_2/searchUI/SearchUI.dart';
import 'package:modul_2/ProfileScreen/addProfileUI.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modul_2/ProfileScreen/UIprofile.dart';

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  _firstState createState() => _firstState();
}

class _firstState extends State<first> {
  bool checkLogin = false;
  getLocalData()async{
    final prefs = await SharedPreferences.getInstance();
    checkLogin = prefs.getBool('checkLogin')!;
  }

  @override
  void initState() {
    getLocalData();
    allHistory();
    super.initState();
  }

  List<Map<String, dynamic>> Listhistory = [];
  void allHistory()async{
    final data = await HistoryDatabase.instance.getHistory();
    setState((){
      Listhistory = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.zero,
                      child: IconButton(
                        icon: Icon(
                          Icons.account_circle_rounded,
                          size: 35,
                          color: Colors.blueAccent,
                        ),
                        onPressed: () {
                          getLocalData();
                          print(checkLogin);
                          if (checkLogin == true) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UIprofile()));
                          }else if(checkLogin == false){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => addProfile()));
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'Nama User',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 150),
                      child: IconButton(
                        icon: Icon(
                          Icons.settings,
                          size: 35,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100, bottom: 100),
                  child: Text(
                    'BROWSER',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    child: Container(
                      width: 300,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Search or type web address',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => searchUI()),
                      );
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 40, left: 20),
                            child: Text(
                              'Recent history',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 43, left: 8),
                            child: Icon(
                              Icons.access_time,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: SingleChildScrollView(
                          child: Container(
                            width: 320,
                            height: 200,
                            color: Colors.white,
                            child: ListView.builder(
                              itemCount: Listhistory.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: EdgeInsets.all(4),
                                  elevation: 0,
                                  child: ListTile(
                                    title: Text(Listhistory[index]['link']),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: botBar(),
    );
  }
}
