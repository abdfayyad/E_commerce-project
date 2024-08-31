import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Delivery/ShowOrder/bloc/status.dart';
import 'package:project_zain2/utils/end_point.dart';
import 'package:project_zain2/utils/shared_prefirance.dart';
import 'package:http/http.dart'as http;
class ShowOrderListCubit extends Cubit<ShowOrderListStatus>{
  ShowOrderListCubit():super(ShowOrderListInitializeStatus());

  late ShowOrderListModel showOrderListModel;

  Future<ShowOrderListModel?> getDeliveries() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
    };
    final response = await http
        .get(Uri.parse('$BASE_URL/api/delivery/orders'), headers: headers);
    if (response.statusCode == 200) {
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      showOrderListModel = ShowOrderListModel.fromJson(parsedJson);
      emit(ShowOrderListSuccessStatus(showOrderListModel));
    } else {
      print(response.body);

      emit(ShowOrderListErrorStatus());
      throw Exception('Failed to load profile data');
    }
  }
}