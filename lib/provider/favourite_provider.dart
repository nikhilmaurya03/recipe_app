import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteProvider extends ChangeNotifier {
  List<String> _favouriteList =
      []; // create a favourite list to store favourite recipes
  List<String> get favouriteList => _favouriteList; // map the favourite list

  FavouriteProvider() {
    getFavouriteList();
  } // initialise the favourite list

  void toggleFavourite(DocumentSnapshot recipe) {
    if (favouriteList.contains(recipe.id)) {
      _favouriteList
          .remove(recipe.id); // remove the recipe from the favourite list
      _removeFavourite(recipe.id); //remove from database
    } else {
      _favouriteList.add(recipe.id); // add the recipe to the favourite list
      _addFavourite(recipe.id); //add in database
    }
    notifyListeners();
  }

// function to add in database
  Future<void> _addFavourite(String recipe_id) async {
    try {
      await FirebaseFirestore.instance
          .collection("favourite")
          .doc(recipe_id)
          .set({
        'isFavourite': true,
      });
    } catch (e) {
      print(e.toString());
    }
  }

// function to remove from database
  Future<void> _removeFavourite(String recipe_id) async {
    try {
      await FirebaseFirestore.instance
          .collection("favourite")
          .doc(recipe_id)
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

  // function to fetch favourite list from database

  Future<void> getFavouriteList() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("favourite").get();
      _favouriteList = querySnapshot.docs.map((docs) => docs.id).toList();
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  //moethod to find item is favourite or not
 bool isExist(DocumentSnapshot recipe) {
    return  _favouriteList.contains(recipe.id);
  }

// static method to access the provider
  static FavouriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavouriteProvider>(context, listen: listen);
  }
}
