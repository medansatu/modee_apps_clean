import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/entitites/register.dart';
import '../../../../domain/usecases/cases/register_use_case.dart';

class RegisterPresenter extends Presenter {
  late Function(Register?) onSuccessRegister;
  late Function(dynamic error) onErrorRegister;
  late Function() onFinishRegister;

  final RegisterCase registerUseCase;

  RegisterPresenter({required this.registerUseCase});

  void registerUser(String name, String username, String email, String phoneNumber, String address, String password) {
    registerUseCase.execute(_GetUserObserver(this), RegisterParams(name: name, address: address, email: email, password: password, phoneNumber: phoneNumber, username: username));
  }

  @override
  void dispose() {
    registerUseCase.dispose();
  }
}

class _GetUserObserver extends Observer<Register> {
  final RegisterPresenter presenter;

  _GetUserObserver(this.presenter);

  @override
  void onComplete() => presenter.onFinishRegister();

  @override
  void onError(e) => presenter.onErrorRegister(e);

  @override
  void onNext(Register? response) {
    final user = response;
    presenter.onSuccessRegister(user);
  }
}
