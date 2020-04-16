import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_example_with_cloud_storage/core/models/post.dart';
import 'package:test_example_with_cloud_storage/core/models/user.dart';

class FirestoreService {
  final CollectionReference _userCollectionReference = Firestore.instance.collection("users");
  final CollectionReference _postCollectionReference = Firestore.instance.collection("posts");
  final StreamController<List<Post>> _postController = StreamController<List<Post>>.broadcast();

  //sign up user
  Future createUser(User user) async {
    try {
      await _userCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  //it checks if the user exists or not
  Future<User> loginControl(String email, String password) async {
    User currentUser;
    try {
      await _userCollectionReference.getDocuments().then((users) {
        for (DocumentSnapshot user in users.documents) {
          if (user.data["mail"] == email && user.data["password"] == password) {
            currentUser = User.fromMap(user.data);
          }
        }
      });
    } catch (e) {
      print(e.toString());
    }
    return currentUser;
  }

  //save profile picture into user account
  Future<String> saveProfilePicture(String imageURL, String userID) async {
    var response;
    try {
      await _userCollectionReference
          .document(userID)
          .updateData({'image': imageURL}).then((u) {
        response = "true";
      });
    } catch (e) {
      print(e.toString());
    }
    return response;
  }

  //add post with user id
  Future addPost(Post post) async {
    try {
      await _postCollectionReference.document(post.postId).setData(post.toJson()).then((currentResult) {
        print("Post added successfully");
      });
    } catch (e) {
      print(e.toString());
    }
  }

  //fetch all posts
  Stream fetchPostsAsStream() {
    try {
      _postCollectionReference.snapshots().listen((postSnapshot) {
        if (postSnapshot.documents.isNotEmpty) {
          List<Post> allPosts = postSnapshot.documents
              .map((currentMap) => Post.fromMap(currentMap.data))
              .where((mappedPost) =>
                  mappedPost.userId.isNotEmpty && mappedPost.title.isNotEmpty).toList();
          _postController.add(allPosts);
        }
      });
    } catch (e) {
      print(e.toString());
    }
    return _postController.stream;
  }

  //delete post with it
  Future<void> deletePost(String postId) async {
    try {
      await _postCollectionReference.document(postId).delete().then((result){
        print("Post deleted successfully");
      });
    } catch (e) {
      print(e.toString());
    }
  }

  //Delete all posts
  Future<void> deleteAllPosts() async {
    try {
      await _postCollectionReference.getDocuments().then((allPosts) async {
        for (var onePost in allPosts.documents) {
          await _postCollectionReference.document(onePost.documentID).delete();
          print("${onePost.documentID} deleted successfully");
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  //update post with id
  Future updatePost(Post post) async {
    try {
          await  _postCollectionReference.document(post.postId).updateData(post.toJson()).then((result){
          print("${post.title} updated successfully");
        });
    } catch (e) {
      print(e.toString());
    }
  }
}
