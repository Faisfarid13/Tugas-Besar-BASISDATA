import 'package:flutter/material.dart';

class favoriteSite extends ChangeNotifier {
  int? selectedIndex;

  List<Map<String, dynamic>> listFavorite = [
    {
      'link' : 'www.instagram.com',
    },
    {

      'link' : 'www.infotech.umm.ac.id',
    }
  ];

  void updateFavoriteSite(int index, String link){
    List<Map<String, dynamic>> listTemp = [];
    for(var i=0; i<listFavorite.length; i++){
      if(i == index){
        listTemp.add({
          'link' : link,
        });
        continue;
      }
      listTemp.add(listFavorite[i]);
    }
    listFavorite = listTemp;
    notifyListeners();
  }

  void addFavoriteSite(String link){
    listFavorite.add({
    'link' : link,
    });
    notifyListeners();
  }

  void deleteFavoriteSite(int index){
    for(var i = 0; i < listFavorite.length; i++){
      if(i == index){
        listFavorite.removeAt(index);
      }
    }
    notifyListeners();
  }
}