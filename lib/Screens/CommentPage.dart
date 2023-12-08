import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:techjartask/ApiConnect/Apifile.dart';
import 'package:techjartask/Models/Comments.dart';
import 'package:techjartask/Models/Posts.dart';
import 'package:techjartask/Provider/LoadingProvider.dart';
import 'package:techjartask/Screens/Widgets/CommentCard.dart';

class CommentsPage extends StatefulWidget {
  final Posts post;

  const CommentsPage({super.key, required this.post});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _bodycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        leading: const BackButton(),
        centerTitle: true,
        title: const Text(
          "Comments",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                widget.post.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            //const Divider(color: Colors.black,),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Center(
                child: Text(
              widget.post.body,
              textAlign: TextAlign.center,
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(
                color: Colors.black,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Comments:',
              ),
            ),
            Expanded(
                child: FutureBuilder<List<Comments>>(
                    future: fetchComments(widget.post.postID),
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
                            Comments comment = data?[index];
                            return GestureDetector(
                                onTap: () {},
                                child: CommentCard(comment: comment));
                          });
                    }))
          ],
        ),
      ),
      floatingActionButton: CircleAvatar(
        radius: 40,
        child: IconButton(
          onPressed: () async {
            await showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                      content: Stack(
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
                                          var status =await postComment(com, widget.post.postID);
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
                      ),
                    ));
          },
          icon: const Icon(Icons.message_outlined),
        ),
      ),
    );
  }
}
