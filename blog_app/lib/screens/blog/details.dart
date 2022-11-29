// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Stream<QuerySnapshot> _detailsStream =
      FirebaseFirestore.instance.collection('blog').snapshots();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Details',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _detailsStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something error');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 350,
                    child: Card(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15)),
                                  child: Image.network(
                                    data["img"],
                                    height: MediaQuery.of(context).size.height,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 10, left: 20, right: 10),
                                    child: Text(
                                      data["title"],
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 10, left: 20, right: 10),
                                    child: Text(
                                      data["des"],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: MaterialButton(
                                      color: Color.fromARGB(255, 124, 161, 125),
                                      height: 45,
                                      minWidth: 100,
                                      onPressed: () {
                                        customDialog(data['img'], data['title'],
                                            data['des']);
                                      },
                                      child: Text(
                                        "Veiw Details",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  customDialog(String img, String title, String des) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
                height: 500,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/blog-bad54.appspot.com/o/blog%2Findia.jpg?alt=media&token=b89a03fa-a87d-4ec1-887e-9aae807dc3ef',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'India',
                      style: TextStyle(fontSize: 35),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                          'India, officially the Republic of India (Hindi: Bhārat Gaṇarājya),[25] is a country in South Asia. It is the seventh-largest country by area, the second-most populous country, and the most populous democracy in the world.'),
                    )
                  ],
                )),
          );
        });
  }
}
