import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Admin/Products/bloc/status.dart';
import 'package:project_zain2/utils/end_point.dart';
import 'package:project_zain2/utils/shared_prefirance.dart';
import 'package:http/http.dart' as http;

class ShowProductsAdminCubit extends Cubit<ShowProductsAdminStatus> {
  ShowProductsAdminCubit() : super(ShowProductsAdminInitializeStatus());
  late ShowProductsAdminModel showProductsAdminModel;

  Future<ShowProductsAdminModel?> getProducts() async {
    emit(ShowProductsAdminLoadingStatus());
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http
        .get(Uri.parse('${BASE_URL}/api/admin/products'), headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      showProductsAdminModel = ShowProductsAdminModel.fromJson(parsedJson);

      emit(ShowProductsAdminSuccessStatus(showProductsAdminModel));
    } else {
      print(response.body);
      print("certificate field");
      emit(ShowProductsAdminErrorStatus());
      throw Exception('Failed to load profile data');
    }
  }
}
