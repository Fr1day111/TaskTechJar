import 'package:flutter/material.dart';
import 'package:techjartask/ApiConnect/Apifile.dart';
import 'package:techjartask/Models/Posts.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: FutureBuilder<List<Posts>>(
                future: fetchdata(),
                builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting)
                  {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  List? data = snapshot.data;
                  //print(data);
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        final user=data?[index];
                        return ListTile(
                          subtitle: Text(user.title),
                          title: Text(user.body),
                        );
                      });
                }),),
          ],
        ),
      ),
    );
  }
}
