import 'package:dio/dio.dart';

class HttpClient {
  final Dio dio = Dio();

  Future<Response> get(String path) async {
    return await dio.get(path);
  }
}