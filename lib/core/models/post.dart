class Post {
  String userId;
  String title;
  String content;
  String dateTime;
  String postId;

  Post({this.userId, this.title, this.content, this.dateTime,this.postId});
  
  
  Post.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        title = map['title'],
        content = map['content'],
        dateTime = map['dateTime'],
        postId = map['postId'];

  toJson() {
    return {
      'userId': userId,
      'title': title,
      'content': content,
      'dateTime': dateTime,
      'postId' : postId,
    };
  }
}
