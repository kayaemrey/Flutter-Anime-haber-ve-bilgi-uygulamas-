import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class gethaber extends StatelessWidget {

  final String documentId;
  gethaber(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('haberler');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                          borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ) ,
                          SizedBox(height: 20,),
                          Text(data["başlık"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
                          SizedBox(height: 8,),
                          Text(data["tarih"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 12),),
                          SizedBox(height: 30,),
                          Container(child: Center(child: Image.network(data["resim"],fit: BoxFit.cover,))),
                          SizedBox(height: 30,),
                          Text(data["konu"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 18),)
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