import 'package:animetab/screens/animesayfas%C4%B1.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class aramapage extends StatefulWidget {
  @override
  _aramapageState createState() => _aramapageState();
}

class _aramapageState extends State<aramapage> {
  TextEditingController t1 = TextEditingController();

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    t1.text;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    t1.text;
  }

  String name = "";

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('animeler');

    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
              controller: t1,
              decoration: InputDecoration(
                hintText: "Anime ara",
                hintStyle: TextStyle(color: Colors.black),
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: users.orderBy('name').startAt([name]).endAt([name + '\uf8ff']).limit(6).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                print(t1.text);
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                return new GridView.count(
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(document.data()["resim"]),
                              fit: BoxFit.cover),
                          //color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                            child: InkWell(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3)),
                              child: Text(
                                document.data()["name"],
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              )),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => getanime(document.data()["name"])));
                              },
                        )),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
