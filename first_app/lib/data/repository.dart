import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:first_app/models/post.dart';

const String SERVER = "https://localhost:7115";

class Repository{
  Future<PostList> fetchPosts() async {
    final url = Uri.parse("$SERVER/TestDB");

    final response = await http.get(url);
    if (response.statusCode==200) {
      return PostList.fromJson(json.decode(response.body));
    }
    else{
      throw Exception("failed request");
    }
    }
  }
