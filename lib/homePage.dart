import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/favourite.dart';
import 'package:recipe_app/food_item_display.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  

  @override
  State<Homepage> createState() => _HomepageState();
  
}

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

class _HomepageState extends State<Homepage> {
  // fetch categorItems
  final CollectionReference categoryItems =
      FirebaseFirestore.instance.collection("categories");

  String category = "All";

  //fetch recipe details based on category
  Query get filteredRecipe => FirebaseFirestore.instance
      .collection("recipe_details")
      .where('category', isEqualTo: category);

  Query get allRecipes =>
      FirebaseFirestore.instance.collection("recipe_details");

  Query get selectedRecipes => category == "All" ? allRecipes : filteredRecipe;

  //fetch current user
  final user = FirebaseAuth.instance.currentUser!;

  //Snackbar


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(user),
          const SizedBox(
            height: 10,
          ),
          search(),
          const SizedBox(
            height: 20,
          ),
          explore(),
          const SizedBox(height: 10),
          selectCategory(),
          SizedBox(
            height: 30,
          ),
          StreamBuilder(
              stream: selectedRecipes.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              final List<DocumentSnapshot> recipes = snapshot.data?.docs ?? [];
              
                return snapshot.hasData ? 
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: recipes.map((e) => FoodItemDisplay(documentSnapshot: e) ).toList()
        //               {
        //                 // Container(
        //                 //   height: 60,
        //                 //   width: 90,
        //                 //   margin: EdgeInsets.only(right: 8, top: 8, left: 4),
        //                 //   decoration: BoxDecoration(
        //                 //     color: Colors.green[200],
        //                 //   ),
        //                 // ),
        //                 Stack(
        //          children: [
        //          Container(
        //         height: 100,
        //         width: double.infinity,
        //         decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(30),
        //         image: DecorationImage(
        //           image: NetworkImage( 
                    
        //             documentSnapshot["image"],
                  
        //            ),
        //         ),  
        //       ),
        //     ),
        //     SizedBox(height: 20,),
        //     Text(documentSnapshot['name'], style: TextStyle(fontSize: 20),),
        //   ],
        // ),
                       
        //       }
     
                    ),
                  ) : Center(child: CircularProgressIndicator());
              }),
              SizedBox(height: 10,),
              
        ],
      ),
      bottomNavigationBar: stylish_bar(context),
    );
  }

  Column selectCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
          child: Text(
            "Category",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.pink[400]),
          ),
        ),
        // SizedBox(
        //   height: 40,
        StreamBuilder(
            stream: categoryItems.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      streamSnapshot.data!.docs.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            category =
                                streamSnapshot.data!.docs[index]["category"];
                          });
                          // indexCategory = index;
                          // callback(index); // Update the UI
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              // border: Border.all(width: 2,
                              // color: indexCategory == index ? Colors.purple.shade400: Colors.grey.shade300,
                              //   ),
                              borderRadius: BorderRadius.circular(25),
                              color: category ==
                                      streamSnapshot.data!.docs[index]
                                          ["category"] //indexCategory == index
                                  ? Colors.pink[400]
                                  : Colors.grey.shade400),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          margin: const EdgeInsets.only(right: 20),
                          child: Text(
                            streamSnapshot.data!.docs[index]["category"],
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: category ==
                                        streamSnapshot.data!.docs[index][
                                            "category"] //indexCategory == index
                                    ? Colors.white
                                    : Colors.black54),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
        // ),
      ],
    );
  }
}

// header method
Widget Header(User user) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(6, 18, 8, 6),
          child: Text(
            "What are you",
            style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.orange),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(6, 0, 8, 8),
          child: Text("cooking today?",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                height: 1,
                color: Colors.orange,
              )),
        ),
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              //clipBehavior: Clip.hardEdge,
              child:
                  Image.asset("assets/images/user2.png", width: 40, height: 40),
            ),
          ),
          onTap: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Text(
            user.email!,
            style: const TextStyle(color: Colors.purple, fontSize: 12),
          ),
        ),
      ],
    ),
  ]);
}

Widget search() {
  return Container(
    height: 50,
    padding: const EdgeInsets.fromLTRB(16, 2, 8, 2),
    margin: const EdgeInsets.fromLTRB(8, 6, 8, 2),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: const TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Search",
        prefixIcon: Icon(Icons.search),
      ),
    ),
  );
}

Widget explore() {
  return Container(
    height: 160,
    padding: const EdgeInsets.all(8.0),
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      //border: Border.all()
      color: Colors.pink[400],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Cook at Home \n Eat at home",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  //alignment: Alignment.center,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(30),
                  //   color: Colors.white,
                  // ),
                  child: Text(
                    "Explore",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[400]),
                  ),
                ))
          ],
        ),
        Image.asset(
          "assets/images/food.png",
          width: 120,
          height: 120,
        ),
      ],
    ),
  );
}

Widget stylish_bar(BuildContext context) {
  return CurvedNavigationBar(
      backgroundColor: Colors.white,
      color: Colors.pink.shade400,
      onTap: (index) {
        if (index == 0) {
          print(1);
        } else if (index == 1) {
          print(2);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Favourite()),
          );
        } else {
          print(3);
          signOut();
          showCustomSnackbar(context, "sign out successfully");
        }
      },
      items: [
        const Icon(
          Icons.settings,
          size: 30,
          color: Colors.white,
        ),
        const Icon(
          Icons.favorite,
          size: 30,
          color: Colors.white,
        ),
        const Icon(
          Icons.home,
          size: 30,
          color: Colors.white,
        ),
      ]);
}

  void showCustomSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 1, 88, 46),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      action: SnackBarAction(
        label: 'DISMISS',
        textColor: Colors.yellow,
        onPressed: () {
          // Dismiss action code
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

//sign out function


