class Post{
  final int _id;
  final String _phoneNumber;
  final String _dateTime;


  int get id=>_id;
  String get phoneNumber=>_phoneNumber;
  String get dateTime=>_dateTime;


  Post.fromJson(Map<String, dynamic> json):
        this._id=json["id"],
        this._phoneNumber=json["phoneNumber"],
        this._dateTime=json["dateTime"];
}

class PostList{
  final List<Post> posts =[];
  PostList.fromJson(List<dynamic> jsonItems){
    for(var jsonItem in jsonItems){
      posts.add(Post.fromJson(jsonItem));
    }
  }
}

abstract class PostResult{}

class PostResultSuccess extends PostResult{
  final PostList postList;
  PostResultSuccess(this.postList);
}

class PostResultFailure extends PostResult{
  final String error;
  PostResultFailure(this.error);
}

class PostResultLoading extends PostResult{
  PostResultLoading();
}