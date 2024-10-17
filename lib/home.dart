import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/favourite.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int indexCategory = 0;
  final CollectionReference categoryItems =
      FirebaseFirestore.instance.collection("categories");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: ListView(
          children: [
            Header(),
            SizedBox(
              height: 10,
            ),
            search(),
            SizedBox(
              height: 20,
            ),
            explore(),
            SizedBox(height: 10),

            category(indexCategory, categoryItems, (index) {
              setState(() {
                indexCategory = index;
              });
            }),
            // category_details(),
          ],
        ),
        bottomNavigationBar: stylish_bar(context));
  }
}

Widget Header() {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(6, 10, 8, 0),
          child: Text(
            "What are you",
            style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.orange),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(6, 0, 8, 8),
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
    InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          //clipBehavior: Clip.hardEdge,
          child: Image.asset("assets/images/user.png", width: 40, height: 40),
        ),
      ),
      onTap: () {},
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
    child: TextField(
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
            Text(
              "Cook at Home \n Eat at home",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
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

Widget category(
    int indexCategory, CollectionReference categoryItems, Function callback) {
  List list = [
    'All',
    'Dinner',
    'Lunch',
    'Breakfast',
  ];
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

      //color: Colors.white,
      SizedBox(
        height: 40,
        child: StreamBuilder(
            stream: categoryItems.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> StreamSnapshot) {
              if (StreamSnapshot.hasData) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(StreamSnapshot.data!.docs.length,
                        (index) => GestureDetector(
                          onTap: () {
                            indexCategory = index;
                    callback(index); // Update the UI
                          },
                          child: Container(
                            decoration:  BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: indexCategory == index ? Colors.pink[400]:Colors.grey.shade400
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            margin: EdgeInsets.only(right: 20),
                            child: Text(StreamSnapshot.data!.docs[index]["category"],
                                 style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: indexCategory == index ? Colors.white: Colors.black54),
                            ),
                          ),
                        )),
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            }),
        // child: ListView.builder(
        //     itemCount: list.length,
        //     scrollDirection: Axis.horizontal,
        //     itemBuilder: (context, index) {
        //       return GestureDetector(
        //           onTap: () {
        //             indexCategory = index;
        //             callback(index); // Update the UI
        //           },
  
        //             child: Container(
        //               height: 30,
        //               alignment: Alignment.center,
        //                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //                margin: EdgeInsets.only(right: 10),
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(20),
        //                 color: indexCategory == index
        //                     ? Colors.pink[400]
        //                     : Colors.white,
        //               ),
        //               child: Padding(
        //                 padding: const EdgeInsets.all(0),
        //                 child: Text(
        //                   list[index],
        //                   style: TextStyle(
        //                       fontSize: 18,
        //                       color: indexCategory == index
        //                           ? Colors.white
        //                           : Colors.pink[400],
        //                       fontWeight: indexCategory == index
        //                           ? FontWeight.bold
        //                           : FontWeight.normal),
        //                 ),
        //               ),
        //             ),
        //           );
        //     }),
      ),
    ],
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
          MaterialPageRoute(builder: (context) => Favourite()),
);
        } else {
          print(3);
        }
      },
      items: [
        Icon(
          Icons.settings,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.favorite,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.home,
          size: 30,
          color: Colors.white,
        ),
      ]);
}
