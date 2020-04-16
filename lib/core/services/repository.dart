import 'package:test_example_with_cloud_storage/core/models/post.dart';
import 'package:test_example_with_cloud_storage/core/models/user.dart';
import 'package:test_example_with_cloud_storage/core/services/firebase_service.dart';

import '../../locator.dart';

//it's repository layer to communicate with our methdos between viewmodel and api client
//you can check how repository pattern work and why we need to use it
class Repository {
  
  //Get instance of Firestore to reach our methods.
  FirestoreService _firestoreService = locator<FirestoreService>();

  //create user
  Future createUser(String id, String name, String password, String mail) async {
    return await _firestoreService
        .createUser(User(id: id, name: name, password: password, mail: mail));
  }

  //check if the user exist or not
  Future loginControl(String email, String password) async {
    return await _firestoreService.loginControl(email, password);
  }

  //save profile picture of user
  Future saveImageURL(String imageUL, String userID) async {
    return await _firestoreService.saveProfilePicture(imageUL, userID);
  }

  //add post
  Future addPost(String userId, String title, String content, String dateTime,String postId) async {
    return await _firestoreService.addPost(Post(userId: userId,title: title,content: content,dateTime: dateTime,postId: postId));
  }

  //get all posts as stream
  Stream getPostsAsStream() {
    return _firestoreService.fetchPostsAsStream(); 
  }

  //delete post with id
  Future<void> deletePost(String postId) async {
    return await _firestoreService.deletePost(postId);
  }

  //delete all posts
  Future<void> deleteAllPosts() async {
    return await _firestoreService.deleteAllPosts();
  }

  //update post with id
  Future<Post> updatePost(String userId,String title,String content,String dateTime,String postId) async {
    return await _firestoreService.updatePost(Post(userId: userId,title: title,content: content,dateTime: dateTime,postId: postId));
  }
}
