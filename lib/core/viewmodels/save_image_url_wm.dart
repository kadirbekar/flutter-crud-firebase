import 'package:flutter/cupertino.dart';
import 'package:test_example_with_cloud_storage/core/services/repository.dart';

import '../../locator.dart';

enum SaveImageState { InitialState, LoadingState, LoadedState, ErrorState }

class SaveImageViewModel with ChangeNotifier {
  Repository _repository = locator<Repository>();
  SaveImageState _state;
  String imageURL;

  SaveImageViewModel() {
    imageURL = "";
    _state = SaveImageState.InitialState;
  }

  SaveImageState get state => _state;

  set state(SaveImageState value) {
    _state = value;
    notifyListeners();
  }

  Future<String> saveImageURL(String imageURL,String userID) async {
    try {
      state = SaveImageState.LoadingState;
      imageURL = await _repository.saveImageURL(imageURL,userID);
      state = SaveImageState.LoadedState;
    } catch (e) {
      state = SaveImageState.ErrorState;
    }
    return imageURL;
  }
}
