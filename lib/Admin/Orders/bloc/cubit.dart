import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Admin/Orders/bloc/status.dart';
import 'package:project_zain2/utils/end_point.dart';
import 'package:project_zain2/utils/shared_prefirance.dart';
import 'package:http/http.dart' as http;

class ShowOrderAdminCubit extends Cubit<ShowOrderAdminStatus> {
  ShowOrderAdminCubit() : super(ShowOrderAdminInitializeStatus());
  late ShowOrderAdminModel showOrderAdminModel;

  Future<ShowOrderAdminModel?> getOrders() async {

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http
        .get(Uri.parse('$BASE_URL/api/admin/orders'), headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      showOrderAdminModel = ShowOrderAdminModel.fromJson(parsedJson);

      emit(ShowOrderAdminSuccessStatus(showOrderAdminModel));
    } else {
      print("certificate field");
      emit(ShowOrderAdminErrorStatus());
      throw Exception('Failed to load profile data');
    }
  }
}
