import 'package:flutter/material.dart';
import 'package:techjartask/ApiConnect/Apifile.dart';
import 'package:techjartask/Models/Posts.dart';
import 'package:techjartask/Screens/CommentPage.dart';
import 'package:techjartask/Screens/Widgets/PostCard.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Posts')),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Posts>>(
                  future: fetchdata(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List? data = snapshot.data;
                    //print(data);
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          Posts post = data?[index];
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CommentsPage(post: post)));
                              },
                              child:
                                  PostCard(title: post.title, body: post.body));
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
