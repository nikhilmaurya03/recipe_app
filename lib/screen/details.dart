import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const DetailsPage({super.key, required this.documentSnapshot});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: (MediaQuery.of(context).size.height) * 0.45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.documentSnapshot['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  top: 400,
                  // right: 10,
                  left: 10,
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          widget.documentSnapshot['name'],
                          style: TextStyle(fontSize: 30, color: Colors.amber),
                        ),
                      ),
                      Text(widget.documentSnapshot['category']),
                    ],
                  )),
              Positioned(
                top: 10,
                left: 10,
                // child: Container(
                //   padding: EdgeInsets.all(6.0),
                //   decoration: BoxDecoration(
                //       color: Colors.grey[600],
                //       borderRadius: BorderRadius.circular(20)),
                //   child: Center(
                //     child: IconButton(
                //         onPressed: () {
                //           Navigator.pop(context);
                //         },
                //         icon: Icon(
                //           Icons.arrow_back_ios,
                //           color: Colors.grey[400],
                //         )),
                //   ),
                // )
                child: FloatingActionButton(
                  backgroundColor: Colors.grey[500],
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios_new),
                ),
              )
            ],
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: Text(
                    widget.documentSnapshot['name'],
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.amber,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.category_rounded,
                        color: Colors.teal[300],
                      ),
                      Text(
                        "Category: " + widget.documentSnapshot['category'],
                        style: TextStyle(fontSize: 18, color: Colors.teal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timelapse_rounded,
                        color: Colors.limeAccent[400],
                      ),
                      Text(
                        "Time: " +
                            widget.documentSnapshot['time'].toString() +
                            " min",
                        style: TextStyle(
                            fontSize: 18, color: Colors.limeAccent[300]),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.energy_savings_leaf_rounded,
                        color: Colors.red[400],
                      ),
                      Text(
                        "Calorie: " + widget.documentSnapshot['cal'].toString(),
                        style: TextStyle(fontSize: 18, color: Colors.redAccent),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Colors.green[400],
                          ),
                          Text(
                            "Rating: " + widget.documentSnapshot['rating'],
                            style: TextStyle(fontSize: 18, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.people_outline_rounded,
                            color: const Color.fromARGB(255, 217, 10, 79),
                          ),
                          Text(
                            "Reviews: " + widget.documentSnapshot['reviews'],
                            style: TextStyle(
                                fontSize: 18,
                                color: const Color.fromARGB(255, 218, 8, 226)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Text(
                      " Ingredients ",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        margin: EdgeInsets.only(left: 8),
                        padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: widget
                                  .documentSnapshot["ingredient's images"]
                                  .map<Widget>(
                                    (imageUrl) => Container(
                                      height: 40,
                                      width: 40,
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Colors.grey[300],
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(imageUrl)),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: widget.documentSnapshot["ingredients"]
                                  .map<Widget>((ingredient) => SizedBox(
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            ingredient,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.amber[400]),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:
                                  widget.documentSnapshot["ingredient's amount"]
                                      .map<Widget>((amount) => SizedBox(
                                            height: 50,
                                            child: Center(
                                              child: Text(
                                                amount,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
