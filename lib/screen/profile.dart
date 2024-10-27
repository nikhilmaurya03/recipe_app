import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/authentication/login.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/profile/profile.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40, left: 40, right: 34),
              child: Text(
                'Your profile',
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/profile/girlprofile.jpg'),
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/profile/boyprofile.jpg'),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text(
                'Your Email',
                style: TextStyle(fontSize: 24),
              ),
              subtitle: Text(widget.user.email!), //user email
              leading: Icon(CupertinoIcons.person),
              trailing: Icon(Icons.arrow_forward),
              tileColor: const Color.fromARGB(255, 100, 188, 228),
            ),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                color: Colors.transparent,
                height: 50,
                width: MediaQuery.of(context).size.width * 0.42,
                child: InkWell(
                  onTap: () {
                    print("hello");
                  },
                  child: Text(
                    'Change Email',
                    style: TextStyle(fontSize: 23),
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: (MediaQuery.of(context).size.height) * 0.02,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                color: Colors.transparent,
                height: 50,
                width: MediaQuery.of(context).size.width * 0.5,
                child: InkWell(
                  onTap: () {
                    print("hello");
                  },
                  child: Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 23),
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: 99,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                color: Colors.transparent,
                height: 70,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: () async{
                    //  print("cow");
                   await FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Logout',
                    style: TextStyle(fontSize: 23),
                  ),
                ),
              ),
              Container(
                height: 70,
                width: 80,
              ),
              Container(
                height: 70,
                width: 150,
                color: Colors.transparent,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back to home',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
