import 'package:flutter/cupertino.dart';
import 'package:test_example_with_cloud_storage/core/models/user.dart';
import 'package:test_example_with_cloud_storage/core/services/repository.dart';

import '../../locator.dart';

enum SingupState { InitialState, LoadingState, LoadedState, ErrorState }

class SignupViewModel with ChangeNotifier {
  Repository _repository = locator<Repository>();
  SingupState _state;
  User _user;

  SignupViewModel() {
    _user = User();
    _state = SingupState.InitialState;
  }

  User get user => _user;

  SingupState get state => _state;

  set state(SingupState value) {
    _state = value;
    notifyListeners();
  }

  Future<User> createUser(User user) async {
    try {
      state = SingupState.LoadingState;
      _user = await _repository.createUser(user.id, user.name, user.password, user.mail);
      state = SingupState.LoadedState;
    } catch (e) {
      state = SingupState.ErrorState;
    }
    return _user;
  }
}
