import 'package:flutter/material.dart';
import 'package:recipe_app/custom_clipper.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
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
        // flexibleSpace: ClipPath(
        //   clipper: AppBarClipper(),
        //   child: Container(
        //     height: 150,
        //     width: MediaQuery.of(context).size.width,
        //     decoration: BoxDecoration(
        //       gradient: LinearGradient(colors: [
        //         Colors.pink,
        //         // Colors.green.shade200,
        //         Colors.purple.shade400,
        //       ]),
        //     ),
        //     child: Center(
        //       child: SizedBox(
        //         height: 35,
        //         child: Text(
        //           "Favourite",
        //           style: TextStyle(
        //             fontSize: 30,
        //             color: Colors.white,
        //             fontWeight: FontWeight.w500,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
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
                      child: Image.asset("assets/images/food2.png",
                          width: 85, height: 85),
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
                          "Bhature",
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
                          "time - 30 min",
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
      ),
    );
  }
}
