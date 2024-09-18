import 'package:dartz/dartz.dart';
import 'package:flutter_whatsapp_voice_recorder/core/errors/exceptions.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/feature/home/repository/home_repository.dart';
import '../datasources/home_datastore.dart';
import '../datasources/home_datastore_factory.dart';
import '../models/audio_model.dart';

class HomeRepositoryImpl extends HomeRepository {
  HomeRepositoryImpl({required HomeDataStoreFactory homeDataStoreFactory}) {
    _homeDataStoreFactory = homeDataStoreFactory;
  }

  late HomeDataStore _homeDataStore;
  late HomeDataStoreFactory _homeDataStoreFactory;

  @override
  Future<Either<Failure, List<Audio>>> getAudioList() async {
    try {
      _homeDataStore = _homeDataStoreFactory.getAudioList();
      List<Audio> audios = await _homeDataStore.getAudioList();
      return Right(audios);
    } on LocalDbException {
      return Left(LocalDbFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveAudio({required Audio audio}) async {
    try {
      _homeDataStore = _homeDataStoreFactory.saveAudio();
      _homeDataStore.saveAudio(audio: audio);
      return const Right(true);
    } on LocalDbException {
      return Left(LocalDbFailure());
    }
  }
}
