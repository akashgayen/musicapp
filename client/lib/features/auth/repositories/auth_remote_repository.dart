import 'package:client/index.dart';
import 'package:http/http.dart' as http;

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${ServerConstants.baseUrl}/auth/signup',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'name': name,
            'email': email,
            'password': password,
          },
        ),
      );
      final responseMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 201) {
        return Left(
          AppFailure(
            responseMap['detail'],
          ),
        );
      }
      return Right(
        UserModel.fromMap(responseMap),
      );
    } catch (e) {
      return Left(
        AppFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<Either<AppFailure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${ServerConstants.baseUrl}/auth/login',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
      );
      final responseMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        return Left(
          AppFailure(
            responseMap['detail'],
          ),
        );
      }
      return Right(
        UserModel.fromMap(
          responseMap['user'],
        ).copyWith(
          token: responseMap['token'],
        ),
      );
    } catch (e) {
      return Left(
        AppFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<Either<AppFailure, UserModel>> getCurrentUserData(String token) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ServerConstants.baseUrl}/auth/',
        ),
        headers: {
          'Content-Type': 'application/json',
          'auth-token': token,
        },
      );
      final responseMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        return Left(
          AppFailure(
            responseMap['detail'],
          ),
        );
      }
      return Right(
        UserModel.fromMap(
          responseMap,
        ).copyWith(
          token: token,
        ),
      );
    } catch (e) {
      return Left(
        AppFailure(
          e.toString(),
        ),
      );
    }
  }
}
