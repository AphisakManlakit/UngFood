import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chatapp extends StatefulWidget {
  @override
  _ChatappState createState() => _ChatappState();
}

class _ChatappState extends State<Chatapp> {

  String nameUser;

  @override
  void initState() {
    super.initState();
    findUser();
  }


  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('NameFood');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                headerBar(context),
                Container(
                  child: Text("user =  $nameUser"),
                ),
                conversation(),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget conversation() {
  return Container(
    child: Stack(
      children: [
        Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.fromLTRB(0.0, 540.0, 00.0, 0),
            child: Container(
              color: Color(0x1F000000),
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          hintText: "   message",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0xFFE8F5E9),
                              const Color(0x0FFFFFFF)
                            ]),
                            borderRadius: BorderRadius.circular(40)),
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/images/send.png")),
                  )
                ],
              ),
            ))
      ],
    ),
  );
}

// Widget chatList(){
//   return Container();
// }

Widget headerBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.brown[900],
    title: Text(
      "Coffee House",
      style: TextStyle(color: Colors.brown[50], fontSize: 27.0),
    ),
    centerTitle: true,
    actions: [
      IconButton(
          onPressed: () {
            // MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (context) => CheckOut());
            // Navigator.of(context).push(materialPageRoute);
          },
          icon: Icon(
            Icons.add_shopping_cart,
            color: Colors.brown[50],
            size: 30.0,
          )),
    ],
  );
}
