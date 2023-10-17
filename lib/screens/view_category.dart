import 'package:e_commerce_app/models/category.dart';
import 'package:flutter/material.dart';

import 'screen.dart';

class View_Category extends StatefulWidget {
  const View_Category({super.key, required this.category});
  static const String id = "view_categories";
  final List<CategoryModel> category;
  @override
  State<View_Category> createState() => View_CategoryState();
}

class View_CategoryState extends State<View_Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: Text("View Category"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        child: GridView.builder(
          // mainAxisAlignment: MainAxisAlignment.start,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: widget.category.length,
          itemBuilder: (context, index) {
            return Category_Card(
              category: widget.category[index],
            );
          },
        ),
      ),
    );
  }
}
