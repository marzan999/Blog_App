// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Popular extends StatefulWidget {
  const Popular({super.key});

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  Stream<QuerySnapshot> _popularStream =
      FirebaseFirestore.instance.collection('blog').snapshots();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Popular Place',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _popularStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 243, 241, 241),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                                child: Text(
                              data["title"][0],
                            )),
                            Container(
                              child: Text(
                                data["title"],
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 35),
                              ),
                            ),
                            Icon(
                              Icons.more_horiz,
                              size: 40,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  child: ClipRRect(
                                    child: Image.network(data["img"],
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 30.0),
                                        child: Center(
                                          child: Text(
                                            data["des"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList());
        },
      ),
    ));
  }
}



// Container(
//                     height: 350,
//                     child: Card(
//                       elevation: 7,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15)),
//                       child: Row(
//                         children: [
//                           Expanded(
//                               flex: 1,
//                               child: Container(
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(15),
//                                       bottomLeft: Radius.circular(15)),
//                                   child: Image.network(
//                                     data["img"],
//                                     height: MediaQuery.of(context).size.height,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               )),
//                           Expanded(
//                               flex: 1,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     padding: EdgeInsets.only(
//                                         top: 10, left: 20, right: 10),
//                                     child: Text(
//                                       data["title"],
//                                       style: TextStyle(
//                                           fontSize: 30,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10.0,
//                                   ),
//                                   Container(
//                                     padding: EdgeInsets.only(
//                                         top: 10, left: 20, right: 10),
//                                     child: Text(
//                                       data["des"],
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                   Center(
//                                     child: MaterialButton(
//                                       color: Color.fromARGB(255, 124, 161, 125),
//                                       height: 45,
//                                       minWidth: 100,
//                                       onPressed: () {
//                                         customDialog(data['img'], data['title'],
//                                             data['des']);
//                                       },
//                                       child: Text(
//                                         "Veiw Details",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.white),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ))
//                         ],
//                       ),
//                     ),
//                   ),