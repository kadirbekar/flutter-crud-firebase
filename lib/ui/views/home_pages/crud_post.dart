import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_example_with_cloud_storage/core/models/post.dart';
import 'package:test_example_with_cloud_storage/core/services/theme_data_service.dart';
import 'package:test_example_with_cloud_storage/core/viewmodels/add_post_wm.dart';
import 'package:test_example_with_cloud_storage/core/viewmodels/delete_post_wm.dart';
import 'package:test_example_with_cloud_storage/core/viewmodels/fetch_post_stream_wm.dart';
import 'package:test_example_with_cloud_storage/core/viewmodels/login_with_email_wm.dart';
import 'package:test_example_with_cloud_storage/core/viewmodels/update_post.wm.dart';
import 'package:test_example_with_cloud_storage/ui/shared/global_methods.dart';
import 'package:test_example_with_cloud_storage/ui/shared/responsive.dart';
import 'package:test_example_with_cloud_storage/ui/widgets/appbar_title.dart';
import 'package:test_example_with_cloud_storage/ui/widgets/label_card.dart';
import 'package:test_example_with_cloud_storage/core/services/global_pages_service.dart'
    as globalPages;

class CrudPost extends StatefulWidget {
  const CrudPost({Key key}) : super(key: key);

  @override
  _CrudPostState createState() => _CrudPostState();
}

class _CrudPostState extends State<CrudPost> {
  
  List<Post> allPosts = [];
  var _postTitleController = TextEditingController();
  var _postContentController = TextEditingController();
  LoginControlViewModel _loginControlViewModel;
  final Firestore _firestore = Firestore.instance;
  String currentPostId = "";
  String currentUserId = "";

  @override
  Widget build(BuildContext context) {
    _loginControlViewModel = Provider.of<LoginControlViewModel>(context, listen: false);
    final themeData = Provider.of<ThemeService>(context, listen: true);

    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: AppbarTitle(label: 'All Posts'),
        ),
        body: Column(
          children: <Widget>[
            Consumer<FetchPostViewModel>(
              builder: (BuildContext context, FetchPostViewModel data,
                      Widget child) =>
                  StreamBuilder(
                stream: data.fetchPostsAsStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    allPosts = snapshot.data;
                    print("AllPost lenght : " + allPosts.length.toString());
                    if (allPosts.length > 0) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: allPosts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                                height: SizeConfig.safeBlockVertical * 20,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                      top: SizeConfig.safeBlockVertical * 1.5,
                                      bottom:
                                          SizeConfig.safeBlockVertical * 1.5,
                                      right: SizeConfig.safeBlockHorizontal * 4,
                                      left: SizeConfig.safeBlockHorizontal * 4,
                                    ),
                                    child: Card(
                                        elevation: 4,
                                        color: index % 2 == 0
                                            ? Colors.grey
                                            : Colors.red,
                                        child: listTile(
                                            allPosts[index].title,
                                            allPosts[index].content,
                                            Icon(Icons.delete_forever),
                                            allPosts[index].postId,
                                            allPosts[index].userId,
                                            index))));
                          },
                        ),
                      );
                    } else {
                      return globalPages.noSavedData();
                    }
                  } else {
                    return globalPages.noSavedData();
                  }
                },
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.withOpacity(0.4),
                  ),
                  padding: EdgeInsets.all(14),
                  margin: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _postTitleController,
                        decoration: InputDecoration(
                            hintText: 'Post Title',
                            hintStyle: TextStyle(
                                color: themeData.getTheme
                                    ? Colors.white
                                    : Colors.black)),
                      ),
                      TextFormField(
                        controller: _postContentController,
                        decoration: InputDecoration(
                            hintText: 'Post content',
                            hintStyle: TextStyle(
                                color: themeData.getTheme
                                    ? Colors.white
                                    : Colors.black)),
                      ),
                      GlobalMethods()
                          .sizedBox(height: SizeConfig.safeBlockVertical * 1),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          addNewPost(),
                          deleteAllPosts(),
                          updatePost(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Add post button
  Widget addNewPost() {
    return SizedBox(
      height: SizeConfig.safeBlockVertical * 8,
      width: SizeConfig.safeBlockHorizontal * 26,
      child: OutlineButton(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () {
          String currentDocumentId =
              _firestore.collection("posts").document().documentID;
          Provider.of<AddPostViewModel>(context, listen: false)
              .addPost(
                  _loginControlViewModel.user.id,
                  _postTitleController.text,
                  _postContentController.text,
                  DateTime.now().toString(),
                  currentDocumentId)
              .then((result) {
            print("Post added successfully");
            _postContentController.clear();
            _postTitleController.clear();
            allPosts.clear();
          }).catchError((error) {
            print(error.toString());
          });
        },
        child: LabelCard(
          label: 'Add',
          fontSize: SizeConfig.safeBlockHorizontal * 5.2,
        ),
        borderSide: BorderSide(color: Colors.black),
      ),
    );
  }

  //Delete button
  Widget deleteAllPosts() {
    return SizedBox(
      height: SizeConfig.safeBlockVertical * 8,
      width: SizeConfig.safeBlockHorizontal * 26,
      child: OutlineButton(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () {
          Provider.of<DeletePostViewModel>(context, listen: false)
              .deleteAllPosts()
              .then((response) {
            print("All posts deleted");
            allPosts.clear();
            setState(() {});
          }).catchError((error) {
            print(error.toString());
          });
        },
        child: LabelCard(
          label: 'Delete',
          fontSize: SizeConfig.safeBlockHorizontal * 5.2,
        ),
        borderSide: BorderSide(color: Colors.black),
      ),
    );
  }

  //update post with id
  Widget updatePost() {
    return SizedBox(
      height: SizeConfig.safeBlockVertical * 8,
      width: SizeConfig.safeBlockHorizontal * 26,
      child: OutlineButton(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () {
          Provider.of<UpdatePostViewModel>(context, listen: false)
              .updatePost(
            currentUserId,
            _postTitleController.text,
            _postContentController.text,
            DateTime.now().toString(),
            currentPostId,
          )
              .then((result) {
            print("Post updated successfully");
            _postContentController.clear();
            _postTitleController.clear();
          }).catchError((error) => print("We had an error"));
        },
        child: LabelCard(
          label: 'Update',
          fontSize: SizeConfig.safeBlockHorizontal * 5.2,
        ),
        borderSide: BorderSide(color: Colors.black),
      ),
    );
  }

  //Common ListTile widget
  Widget listTile(String title, String content, Icon icon, String postId,
      String userId, itemIndex) {
    return Center(
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 4.5,
              color: Colors.white),
        ),
        subtitle: Text(content,
            style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                color: Colors.white)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            //update post icon
            IconButton(
              icon: Icon(Icons.edit,
                  size: SizeConfig.safeBlockHorizontal * 9, color: Colors.teal),
              onPressed: () {
                _postTitleController.text = title;
                _postContentController.text = content;
                currentUserId = userId;
                currentPostId = postId;
              },
            ),
            //delete post icon
            IconButton(
              icon: Icon(Icons.delete_forever,
                  size: SizeConfig.safeBlockHorizontal * 9, color: Colors.teal),
              onPressed: () {
                Provider.of<DeletePostViewModel>(context, listen: false)
                    .deletePost(postId)
                    .then((result) {
                  print("Post deleted successfully");
                  allPosts.removeAt(itemIndex);
                  setState(() {});
                }).catchError((error) {
                  print("We had an error");
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
