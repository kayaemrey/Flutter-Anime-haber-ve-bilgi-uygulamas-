import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class resimpage extends StatelessWidget {

  final String documentId;
  resimpage(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('animeler');

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
              body: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.black,),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    Expanded(child: Center(child: Image.network(data["resim"])))
                  ],
                ),
              )
            ),
          );
        }

        return CircularProgressIndicator();
      },
    );
  }
}
