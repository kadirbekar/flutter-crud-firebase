import 'package:flutter/cupertino.dart';
import 'package:test_example_with_cloud_storage/core/models/post.dart';
import 'package:test_example_with_cloud_storage/core/services/repository.dart';

import '../../locator.dart';

enum AddPostState { InitialState, LoadingState, LoadedState, ErrorState }

class AddPostViewModel with ChangeNotifier {
  Repository _repository = locator<Repository>();
  AddPostState _state;
  Post _post;

  //when creating instance of view model assing state necessary values
  AddPostViewModel() {
    _state = AddPostState.InitialState;
    _post = Post();
  }

  Post get post => _post;
  
  AddPostState get state => _state;

  set state(AddPostState value) {
    _state = value;
    notifyListeners();
  }

  Future<Post> addPost(String userId,String title,String content,String dateTime,String postId) async {
    try {
      state = AddPostState.LoadingState;
      _post = await _repository.addPost(userId,title,content,dateTime,postId);
      state = AddPostState.LoadedState;
    } catch (e) {
      state = AddPostState.ErrorState;
    }
    return _post;
  }
}
