import 'package:dio/dio.dart';
import 'package:rivrpod_api/services/api.dart';

import '../models/model.dart';

class DioGetPost {
  static const String _endpoint = '/posts';
  API api = API();
  Future<List<Model>> GetPosts() async {
    try {
      Response response = await api.sendRequest.get(_endpoint);
      List<dynamic> posts = response.data;
      return posts.map((e) => Model.fromJson(e)).toList();
    } catch (e) {
      throw (e);
    }
  }
}
