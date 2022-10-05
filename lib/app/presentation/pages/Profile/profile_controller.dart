import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import './profile_presenter.dart';
import '../../../../domain/entitites/profile.dart';

class ProfileController extends Controller {
  final ProfilePresenter _presenter;

  ProfileController(this._presenter);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Profile? _profile;
  Profile? get profile => _profile;
  
  @override
  void initListeners() {
    _initObserver();
    _getProfile();
  }

  void _getProfile() {
    _showLoading();
    _presenter.getProfile();
  }

  void _initObserver() {
    _presenter.onErrorGetProfile = (e) {};
    _presenter.onFinishGetProfile = () {
      _hideLoading();
    };
    _presenter.onSuccessGetProfile = (Profile? data) {
      _profile = data;
    };
  }

  void _showLoading() {
    _isLoading = true;
    refreshUI();
  }

  void _hideLoading() {
    _isLoading = false;
    refreshUI();
  }

  @override
  void dispose() {
    super.dispose();
    _presenter.dispose();
  }


}