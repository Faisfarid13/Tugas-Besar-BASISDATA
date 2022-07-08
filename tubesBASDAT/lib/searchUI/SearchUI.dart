import 'package:flutter/material.dart';
import 'package:modul_2/data.dart';
import 'package:provider/provider.dart';
import 'favoriteSite.dart';
import 'addFavSiteUI.dart';
import 'editLinkUI.dart';
import 'package:modul_2/DATABASE/historyModel.dart';
import 'package:modul_2/DATABASE/historyDatabase.dart';

class searchUI extends StatefulWidget {
  @override
  _searchUIState createState() => _searchUIState();
}

class _searchUIState extends State<searchUI> {

  TextEditingController searchText = TextEditingController();

  void showAddLinkUI(){
    showDialog(context: context, builder: (_){
      return AlertDialog(
        content: addFavSiteUI(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
    },);
  }

  void showEditLinkUI(){
    showDialog(context: context, builder: (_){
      return AlertDialog(
        content: editLinkUI(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
    },);
  }

  late String link;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: TextField(
            controller: searchText,
            autofocus: true,
            maxLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide.none
              ),
              contentPadding: EdgeInsets.only(left: 20),
              hintText: 'Search or type web address',
            ),
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(fontSize: 15),
            onEditingComplete: (){
              link = searchText.text;
              if(link.length == 0){

              }else{
                addHistory();
              }
              searchText.clear();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text('BOOKMARK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),),
              SingleChildScrollView(
                child: Container(
                  width: 320,
                  height: 200,
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Consumer<favoriteSite>(
                    builder: (context, favorite, _) => ListView.builder(
                      itemCount: favorite.listFavorite.length,
                      itemBuilder: (context, index){
                        return Card(
                          child: ListTile(
                            title: Text(favorite.listFavorite[index]['link'],style: TextStyle(
                              fontSize: 15,
                            ),
                            ),
                            onTap: (){
                              favorite.selectedIndex = index;
                              showEditLinkUI();
                            },
                          ),
                        );
                      }
                    )
                  ),
                ),
              ),
              GestureDetector(
                onTap: showAddLinkUI,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Icon(Icons.add),
                      ],
                    ),
                    Column(
                      children: [
                        Text('ADD FAVORITE SITE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future addHistory()async{
    final history  = History(
      link: link,
    );
    await HistoryDatabase.instance.create(history);
  }
}
