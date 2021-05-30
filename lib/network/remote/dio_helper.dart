import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true, // if error when data back
      ),
    );
  }

  static Future<Response> getData({
    @required String url,
    @required Map<String, dynamic> query, // because of queryParmeters need Map<String, dynamic>
  }) async {
    return await dio.get(url, queryParameters: query,);
  }
}