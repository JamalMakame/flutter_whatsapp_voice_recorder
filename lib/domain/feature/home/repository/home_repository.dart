import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../data/home/models/audio_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, bool>> saveAudio({required Audio audio});

  Future<Either<Failure, List<Audio>>> getAudioList();
}
