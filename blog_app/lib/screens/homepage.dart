import 'package:blog_app/screens/blog/details.dart';
import 'package:blog_app/screens/blog/gallery.dart';
import 'package:blog_app/screens/blog/popular.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myPages = [Details(), Popular(), GalleryPage()];
  int indexPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPages[indexPage],
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(Icons.list, size: 30),
          Icon(Icons.favorite_border, size: 30),
          Icon(Icons.photo_album, size: 30),
        ],
        onTap: (index) {
          setState(() {
            indexPage = index;
          });
        },
      ),
    );
  }
}
