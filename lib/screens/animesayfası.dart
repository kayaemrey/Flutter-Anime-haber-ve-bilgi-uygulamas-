import 'package:animetab/screens/resimsayfas%C4%B1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class getanime extends StatelessWidget {
  final String documentId;
  getanime(this.documentId);
  TextEditingController txtcoment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('animeler');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios_sharp,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                child: Container(
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(data["resim"]),
                                    maxRadius: 60,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              resimpage(data["name"])));
                                },
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      data["name"],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 30),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      "Puan : ${data["puan"]}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.08),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tür : ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                              Text(
                                data["tür"],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Bölüm sayısı : ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                              Text(
                                data["bölüm sayısı"],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Yapım yılı : ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                              Text(
                                data["çıkış tarihi"],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Konu : ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              Expanded(
                                  child: Text(
                                data["konu"],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical:25.0,horizontal: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: txtcoment,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: 'Yorum yazınız'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return CircularProgressIndicator();
      },
    );
  }
}
