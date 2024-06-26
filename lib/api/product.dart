import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/response_model.dart';

final dio = Dio(BaseOptions(baseUrl: 'https://yoo2.smart-node.net/api'));

Future<ResponseModel> getProducts(int? catId, int limit, int offset,
    [String? search]) async {
  try {
    final sh = await SharedPreferences.getInstance();
    final res = await dio.get(
      "/products?category=$catId?offset=$offset&limit=$limit${search != null ? '&search=' + search : ''}",
      options: Options(
        headers: {"token": sh.getString("token")},
      ),
    );
    if (kDebugMode) {
      print(res.data);
    }
    return ResponseModel.fromJson(res.data);
  } catch (e) {
    if (e is DioError) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      final dt = ResponseModel.fromJson({'status': false});
      dt.setStatus(500);
      return dt;
    }
  }
  final da = ResponseModel(success: false, statusCode: 500);
  da.setStatus(500);
  return da;
}

Future<ResponseModel> getProductsBySub(
    int? catId, int limit, int offset) async {
  try {
    if (kDebugMode) {
      print([limit, offset]);
    }
    final sh = await SharedPreferences.getInstance();
    final res = await dio.get(
      "/product-by-subcategory/$catId?offset=$offset&limit=$limit",
      options: Options(
        headers: {"token": sh.getString("token")},
      ),
    );
    return ResponseModel.fromJson(res.data);
  } catch (e) {
    if (e is DioError) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      final dt = ResponseModel.fromJson({'status': false});
      dt.setStatus(500);
      return dt;
    }
  }
  final da = ResponseModel(success: false, statusCode: 500);
  da.setStatus(500);
  return da;
}
