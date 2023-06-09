import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final httClient = Dio(BaseOptions(
  baseUrl: 'https://g.shirazcip.com/api/',
))
  ..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers['Accept'] = 'application/json';
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        final String accessToken =
            sharedPreferences.getString('access_token') ?? '';
        if (accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }

        handler.next(options);
      },
    ),
  );
