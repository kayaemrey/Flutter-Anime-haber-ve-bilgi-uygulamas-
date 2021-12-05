import 'package:animetab/screens/habersayfas%C4%B1.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class anasayfapage extends StatefulWidget {
  @override
  _anasayfapageState createState() => _anasayfapageState();
}

class _anasayfapageState extends State<anasayfapage> {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('haberler');

    return StreamBuilder<QuerySnapshot>(
      stream: users.orderBy('tarih', descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            child: Text(
                          document.data()["başlık"],
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Container(
                            child: Text(
                          document.data()["özet"],
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                            child: Text(
                          "Devamı için dokunun!",
                          style: TextStyle(
                              fontSize: 12, color: Colors.red.shade200),
                        )),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => gethaber(document.data()["başlık"])));
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
