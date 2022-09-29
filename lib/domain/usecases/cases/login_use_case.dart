import 'dart:async';

import '../../repositories/user_repo.dart';
import '../../entitites/user.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetUser extends UseCase<User, UserLoginParams> {  
  final UserRepository repository;  

  GetUser(
    this.repository,    
  );

  @override
  Future<Stream<User?>> buildUseCaseStream(UserLoginParams? params) async {
    final streamController = StreamController<User>();

    try {
      final user = await repository.login(params!.username, params.password);
      streamController.add(user);
      streamController.close();
    } catch (e, stackTrace) {
      logger.severe('Stacktrace: $stackTrace');
      streamController.addError(e, stackTrace);
    }

    return streamController.stream;
  }
  
}

class UserLoginParams {
    String username;
    String password;
    UserLoginParams(this.username, this.password);
  }
