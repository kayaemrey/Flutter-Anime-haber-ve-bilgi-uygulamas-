import 'package:animetab/screens/animesayfas%C4%B1.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class toplistpage extends StatefulWidget {
  @override
  _toplistpageState createState() => _toplistpageState();
}

class _toplistpageState extends State<toplistpage> {

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('animeler');

    return StreamBuilder<QuerySnapshot>(
      stream: users.orderBy('puan', descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        int sayac = 0;
        List listsira = [];

        return Container(
          color: Colors.white,
          child: new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              sayac++;
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
                            color: Colors.red.withOpacity(0.6),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "#$sayac",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.27,
                            height: MediaQuery.of(context).size.height * 0.22,
                            child: Image.network(
                              "${document.data()["resim"]}",
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.48,
                            child: Column(
                              children: [
                                Text(
                                  document.data()["name"],
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Tür: ${document.data()["tür"]}",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Puan: ${document.data()["puan"]}",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => getanime(document.data()["name"])));
                    }),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
