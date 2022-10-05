import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../repositories/profile_repo.dart';
import '../../entitites/profile.dart';

class GetProfileUseCase extends UseCase<Profile, dynamic> {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);
  
  @override
  Future<Stream<Profile?>> buildUseCaseStream(params) async {
    final streamController = StreamController<Profile>();    

    try {
      final profile = await repository.profile();
      streamController.add(profile);
      streamController.close();
    } catch (e, stackTrace) {
      logger.severe('Stacktrace: $stackTrace');
      streamController.addError(e, stackTrace);      
    }
    return streamController.stream;
  }
}