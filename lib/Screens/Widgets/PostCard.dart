import 'package:flutter/material.dart';
import 'package:techjartask/Models/Posts.dart';

class PostCard extends StatelessWidget {
  final Posts post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 20,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.all(
          //   Radius.circular(20),
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 3, // Spread radius
              blurRadius: 9, // Blur radius
              offset: const Offset(0, 3), // Offset in the x and y direction
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                post.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(color: Colors.black,),
              Text(post.body,textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
    );
  }
}
