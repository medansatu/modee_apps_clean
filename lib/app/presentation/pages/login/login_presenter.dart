import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/entitites/user.dart';
import '../../../../domain/usecases/cases/login_use_case.dart';

class LoginPresenter extends Presenter {
  late Function(User?) onSuccessLogin;
  late Function(dynamic error) onErrorLogin;
  late Function() onFinishLogin;

  final GetUser getUsersUseCase;

  LoginPresenter({required this.getUsersUseCase});

  void getUser(String username, String password) {
    getUsersUseCase.execute(_GetUserObserver(this), UserLoginParams(username, password));
  }

  @override
  void dispose() {
    getUsersUseCase.dispose();
  }
}

class _GetUserObserver extends Observer<User> {
  final LoginPresenter presenter;

  _GetUserObserver(this.presenter);

  @override
  void onComplete() => presenter.onFinishLogin();

  @override
  void onError(e) => presenter.onErrorLogin(e);

  @override
  void onNext(User? response) {
    final user = response;
    presenter.onSuccessLogin(user);
  }
}
