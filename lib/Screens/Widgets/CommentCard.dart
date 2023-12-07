import 'package:flutter/material.dart';
import 'package:techjartask/Models/Comments.dart';


class CommentCard extends StatelessWidget {
  final Comments comment;
  const CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 20,
        decoration:  BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
           borderRadius: const BorderRadius.all(
             Radius.circular(20),
           ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(child: FlutterLogo(),),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.Name,
                          style: const TextStyle(fontSize:15,fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                        ),
                        Text(
                          comment.Email,
                          style: TextStyle(color: Colors.black.withOpacity(0.5)),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                child: Text(comment.Body,textAlign: TextAlign.start,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
