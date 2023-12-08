import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techjartask/ApiConnect/Apifile.dart';
import 'package:techjartask/Models/Comments.dart';
import 'package:techjartask/Provider/LoadingProvider.dart';

class AddComment extends StatefulWidget {
  final int postID;
  const AddComment({super.key, required this.postID});

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _bodycontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          right: -30,
          top: -30,
          child: InkResponse(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.close),
            ),
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  decoration:
                  const InputDecoration(hintText: 'Name'),
                  controller: _namecontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field cant be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Email'),
                  controller: _emailcontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field cant be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  maxLines: 5,
                  decoration:
                  const InputDecoration(hintText: 'Body'),
                  controller: _bodycontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field cant be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Consumer<loadingProvider>(builder: (context, value, child){
                    return ElevatedButton(
                      child: value.load?const Center(child: CircularProgressIndicator(),):const Text('Submit'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          value.loading();
                          Comments com = Comments(
                              CommentID: 234,
                              Name: _namecontroller.text,
                              Body: _bodycontroller.text,
                              Email: _emailcontroller.text);
                          var status =await postComment(com, widget.postID);
                          value.loading();
                          Navigator.of(context).pop();
                          //print(status);
                          if (status==201){
                            //print('************');

                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sucessfully Uploaded!!')));
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error!!')));

                          }
                        }
                      },
                    );
                  },)
              )
            ],
          ),
        ),
      ],
    );
  }
}
