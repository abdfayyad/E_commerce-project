import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Admin/Percentage/bloc/status.dart';
import 'package:project_zain2/utils/end_point.dart';
import 'package:project_zain2/utils/shared_prefirance.dart';
import 'package:http/http.dart'as http;
class PercentageProvidersCubit extends Cubit<PercentageProvidersStatus>{
  PercentageProvidersCubit():super(PercentageProvidersInitializeStatus());
 late PercentageModel percentageModel;
  Future<PercentageModel?> getPercentageProvider() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http
        .get(Uri.parse('$BASE_URL/api/admin/all_products_with_providers'), headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      percentageModel = PercentageModel.fromJson(parsedJson);

      emit(PercentageProvidersSuccessStatus(percentageModel));
    } else {
      print("certificate field");
      // print(response.body);

      emit(PercentageProvidersErrorStatus());
      throw Exception('Failed to load profile data');
    }
  }
}