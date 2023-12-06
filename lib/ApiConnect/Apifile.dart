import 'package:http/http.dart'as http;

Future<List<Posts>> fetchdata(int val) async{
  List<dynamic> datas =[];
  List<Users> users=[];
  String url='hhttps://jsonplaceholder.typicode.com/posts';
  try{
    final response = await http.get(Uri.parse(url));
    final body= response.body;
    final jsonbody= jsonDecode(body);
    datas = jsonbody['results'];
    users=datas.map((e){
      return Posts(: e['email'], name: uname);
    }).toList();
  }
  catch(e){
    print(e.toString());
  }

  return users;
}