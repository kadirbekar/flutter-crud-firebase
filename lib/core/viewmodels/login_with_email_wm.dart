import 'package:flutter/cupertino.dart';
import 'package:test_example_with_cloud_storage/core/models/user.dart';
import 'package:test_example_with_cloud_storage/core/services/local_storage_service.dart';
import 'package:test_example_with_cloud_storage/core/services/repository.dart';

import '../../locator.dart';

enum LoginState { InitialState, LoadingState, LoadedState, ErrorState }

class LoginControlViewModel with ChangeNotifier {
  Repository _repository = locator<Repository>();
  LoginState _state;
  User _user;

  //Set up Loading state situation,user instance and user data when this class instance created
  LoginControlViewModel() {
    _user = User();
    _state = LoginState.InitialState;
    initUser();
  }

  /*Assing user information into user instance from shared preferences*/
  Future initUser() async{
    _user.id = LocalStorageService.getUserId;
    _user.mail = LocalStorageService.getUserMail;
    _user.name = LocalStorageService.getUserName;
    _user.password = LocalStorageService.getUserPassword;
    _user.image = LocalStorageService.getImage;
    _state = LoginState.LoadedState;
    notifyListeners();
  }

  User get user => _user;

  LoginState get state => _state;

  set state(LoginState value) {
    _state = value;
    notifyListeners();
  }

  
  //check in documents if there is any users with this e-mail and password
  Future<User> loginControl(String email, String password) async {
    try {
      state = LoginState.LoadingState;
      _user = await _repository.loginControl(email, password);
      state = LoginState.LoadedState;
    } catch (e) {
      state = LoginState.ErrorState;
    }
    return _user;
  }
}
