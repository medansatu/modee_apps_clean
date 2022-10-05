import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/entitites/profile.dart';
import '../../../../domain/usecases/cases/get_profile_use_case.dart';
import '../../../../domain/entitites/profile.dart';

class ProfilePresenter extends Presenter {
  late Function(Profile?) onSuccessGetProfile;
  late Function(dynamic error) onErrorGetProfile;
  late Function() onFinishGetProfile;

  final GetProfileUseCase getProfileUseCase;

  ProfilePresenter({
    required this.getProfileUseCase,
  });

  void getProfile() {
    getProfileUseCase.execute(_GetProfileObserver(this));
  }

  @override
  void dispose() {
    getProfileUseCase.dispose();
  }}

  class _GetProfileObserver extends Observer<Profile> {
    final ProfilePresenter presenter;
    
    _GetProfileObserver(this.presenter);
    
      @override
      void onComplete() {
        presenter.onFinishGetProfile();
      }
    
      @override
      void onError(e) {
        presenter.onErrorGetProfile(e);
      }
    
      @override
      void onNext(Profile? response) {
        final profile = response;
        presenter.onSuccessGetProfile(profile);
      }
  }