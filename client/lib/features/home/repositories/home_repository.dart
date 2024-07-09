import 'package:client/index.dart';
import 'package:http/http.dart' as http;
part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<AppFailure, String>> uploadSong({
    required File selectedAudio,
    required File selectedThumbnail,
    required String artist,
    required String songName,
    required String hexcode,
    required String token,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '${ServerConstants.baseUrl}/song/upload',
        ),
      );
      request
        ..files.addAll(
          [
            await http.MultipartFile.fromPath(
              'song',
              selectedAudio.path,
            ),
            await http.MultipartFile.fromPath(
              'thumbnail',
              selectedThumbnail.path,
            ),
          ],
        )
        ..fields.addAll(
          {
            'song_name': songName,
            'artist': artist,
            'hexcode': hexcode,
          },
        )
        ..headers.addAll(
          {
            'x-auth-token': token,
          },
        );
      final response = await request.send();
      if (response.statusCode != 201) {
        return Left(AppFailure(await response.stream.bytesToString()));
      }
      return Right(await response.stream.bytesToString());
    } catch (e) {
      return Left(
        AppFailure(
          e.toString(),
        ),
      );
    }
  }
}
