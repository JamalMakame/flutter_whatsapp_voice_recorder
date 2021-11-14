import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../data/home/models/audio_model.dart';
import '../repository/home_repository.dart';

class HomeService {
  late HomeRepository _homeRepository;

  HomeService({required HomeRepository homeRepository}) {
    _homeRepository = homeRepository;
  }

  Future<Either<Failure, List<Audio>>> getAudioList() {
    return _homeRepository.getAudioList();
  }

  Future<Either<Failure, bool>> saveAudio({required Audio audio}) {
    return _homeRepository.saveAudio(audio: audio);
  }
}
