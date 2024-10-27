import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/custom%20clipper/custom_clipper.dart';
import 'package:recipe_app/provider/favourite_provider.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    final favProvider = FavouriteProvider.of(context);
    final favourites = favProvider.favouriteList;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar:  AppBar(
        toolbarHeight: 110,
        backgroundColor: Colors.pink[300],

        elevation: 0,
        title: const Center(
          child: Text(
            "Favourite",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),  
      body: ListView.builder(
        itemCount: favourites.length,
        itemBuilder: (context, index) {
          String favourate = favourites[index];
          return FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("recipe_details")
                  .doc(favourate)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(
                    child: Text("No data found"),
                  );
                }
                var favouriteItem = snapshot.data!;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                padding: const EdgeInsets.only(left: 8),
                                // child: Image.asset("assets/images/food2.png",
                                //     width: 85, height: 85),
                                child: Image.network(
                                  favouriteItem['image'], 
                                  height: 83,
                                  width: 85,
                                 // fit: BoxFit.contain,
                              ),
                              ),
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 28,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 6),
                                  child: Text(
                                    favouriteItem['name'],
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.purple[300],
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 6),
                                  child: Text(
                                    "time " +
                                        favouriteItem['time'].toString() +
                                        " min",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            favProvider.toggleFavourite(favouriteItem);
                            print(" delete   ");
                          },
                          child: Padding(
                            // padding: EdgeInsets.only(right: 8, left: 8, top: 2, bottom: 2),
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                              size: 30,
                              weight: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );

    // return Scaffold(
    //   backgroundColor: Colors.grey[300],
      // appBar: AppBar(
      //   toolbarHeight: 110,
      //   backgroundColor: Colors.pink[300],

      //   elevation: 0,
      //   title: const Center(
      //     child: Text(
      //       "Favourite",
      //       style: TextStyle(
      //         fontSize: 30,
      //         color: Colors.white,
      //         fontWeight: FontWeight.w500,
      //       ),
      //     ),
      //   ),
    //     // flexibleSpace: ClipPath(
    //     //   clipper: AppBarClipper(),
    //     //   child: Container(
    //     //     height: 150,
    //     //     width: MediaQuery.of(context).size.width,
    //     //     decoration: BoxDecoration(
    //     //       gradient: LinearGradient(colors: [
    //     //         Colors.pink,
    //     //         // Colors.green.shade200,
    //     //         Colors.purple.shade400,
    //     //       ]),
    //     //     ),
    //     //     child: Center(
    //     //       child: SizedBox(
    //     //         height: 35,
    //     //         child: Text(
    //     //           "Favourite",
    //     //           style: TextStyle(
    //     //             fontSize: 30,
    //     //             color: Colors.white,
    //     //             fontWeight: FontWeight.w500,
    //     //           ),
    //     //         ),
    //     //       ),
    //     //     ),
    //     //   ),
    //     // ),
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Container(
    //       height: 100,
    //       width: double.infinity,
    //       decoration: const BoxDecoration(
    //         color: Colors.white54,
    //         borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
    //       ),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             //crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               ClipRRect(
    //                 borderRadius: BorderRadius.circular(50),
    //                 child: Container(
    //                   padding: const EdgeInsets.only(left: 8),
    //                   child: Image.asset("assets/images/food2.png",
    //                       width: 85, height: 85),
    //                 ),
    //               ),
    //               Column(
    //                 children: [
    //                   const SizedBox(
    //                     height: 28,
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.only(left: 6),
    //                     child: Text(
    //                       "Bhature",
    //                       style: TextStyle(
    //                         fontSize: 22,
    //                         color: Colors.purple[300],
    //                         fontWeight: FontWeight.w400,
    //                       ),
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.only(left: 6),
    //                     child: Text(
    //                       "time - 30 min",
    //                       style: TextStyle(
    //                         color: Colors.grey[600],
    //                         fontSize: 18,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //           InkWell(
    //             onTap: () {
    //               print(" delete   ");
    //             },
    //             child: Padding(
    //              // padding: EdgeInsets.only(right: 8, left: 8, top: 2, bottom: 2),
    //              padding: EdgeInsets.all(8.0),
    //               child: Icon(
    //                 Icons.delete,
    //                 color: Colors.redAccent,
    //                 size: 30,
    //                 weight: 40,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
