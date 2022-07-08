import 'package:flutter/material.dart';
import 'package:modul_2/searchUI/favoriteSite.dart';
import 'package:provider/provider.dart';

class editLinkUI extends StatefulWidget {
  const editLinkUI({Key? key}) : super(key: key);

  @override
  State<editLinkUI> createState() => _editLinkUIState();
}

class _editLinkUIState extends State<editLinkUI> {
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

    var linkController = TextEditingController();

    return Container(
      padding: EdgeInsets.all(8),
      height: 200,
      width: 400,
      child: Consumer<favoriteSite>(
        builder: (context, favorite, child) =>
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('Edit Link',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.blueAccent,
                ),),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: buildTextField(favorite.listFavorite[favorite.selectedIndex!]['link'], linkController),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.zero,
                  child: ElevatedButton(
                    onPressed: (){
                      favorite.updateFavoriteSite(favorite.selectedIndex!, linkController.text);
                      Navigator.pop(context);
                    },
                    child: Text('EDIT'),
                  ),),
                Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text('OR'),),
                Padding(padding: EdgeInsets.zero,
                  child: ElevatedButton(
                    onPressed: (){
                      favorite.deleteFavoriteSite(favorite.selectedIndex!);
                      Navigator.pop(context);
                    },
                    child: Text('DELETE'),
                  ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}

