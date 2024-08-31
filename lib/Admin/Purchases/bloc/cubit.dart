import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Admin/Purchases/bloc/status.dart';
import 'package:project_zain2/utils/end_point.dart';
import 'package:project_zain2/utils/shared_prefirance.dart';
import 'package:http/http.dart' as http;

class ShowPurchasesAdminCubit extends Cubit<ShowPurchasesAdminStatus> {
  ShowPurchasesAdminCubit() : super(ShowPurchasesAdminInitializeStatus());
  late ShowPurchasesModel showPurchasesModel;

  Future<ShowPurchasesModel?> getPurchases() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http
        .get(Uri.parse('${BASE_URL}/api/admin/purchases'), headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      showPurchasesModel = ShowPurchasesModel.fromJson(parsedJson);

      emit(ShowPurchasesAdminSuccessStatus(showPurchasesModel));
    } else {
      print("certificate field");
      emit(ShowPurchasesAdminErrorStatus());
      throw Exception('Failed to load profile data');
    }
  }
}
