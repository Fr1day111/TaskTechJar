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
        elevation: 10,
        title: const Center(child: Text('Posts')),
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
                    if(snapshot.connectionState==ConnectionState.none){
                      return const Center(
                        child: Text('Something went wrong.....'),
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
                                  PostCard(post:post));
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
