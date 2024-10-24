import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/favourite.dart';

class FoodItemDisplay extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const FoodItemDisplay({super.key, required this.documentSnapshot});

  @override
  State<FoodItemDisplay> createState() => _FoodItemDisplayState();
}

class _FoodItemDisplayState extends State<FoodItemDisplay> {
  IconData icon = Icons.favorite_border;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      // child: Container(
      //   height: 150,
      //   width: 150,
      //   padding: EdgeInsets.only(right: 4, left: 6, top: 10),
      //   decoration: BoxDecoration(
      //     color: Colors.green,
      //   )),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 8, top: 4),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Favourite()));
                  },
                  child: Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.pink.shade300, width: 3),
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.documentSnapshot['image'],
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 20,),
                Text(
                  widget.documentSnapshot['name'],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.documentSnapshot['rating'],
                      style: TextStyle(
                          color: Colors.green[600],
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.green[300],
                      size: 18,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.documentSnapshot['time'].toString() + " min",
                      style:
                          const TextStyle(fontSize: 16, color: Colors.purple),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 5,
            right: 7,
            child: const Card(
                elevation: 2,
                shape: CircleBorder(),
                borderOnForeground: false,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.teal,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
