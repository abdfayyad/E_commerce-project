import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Delivery/ShowOrders(done)/bloc/status.dart';
import 'package:project_zain2/utils/end_point.dart';
import 'package:project_zain2/utils/shared_prefirance.dart';
import 'package:http/http.dart'as http;
class ShowOrderDoneListCubit extends Cubit<ShowOrderDoneListStatus>{
  ShowOrderDoneListCubit():super(ShowOrderDoneListInitializeStatus());
 late ShowOrdersDoneModel showOrdersDoneModel;
  Future<ShowOrdersDoneModel?> getOrders() async {
    print("object");
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
    };
    final response = await http
        .get(Uri.parse('$BASE_URL/api/delivery/orders/done'), headers: headers);
    if (response.statusCode == 200) {
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      showOrdersDoneModel = ShowOrdersDoneModel.fromJson(parsedJson);
      emit(ShowOrderDoneListSuccessStatus(showOrdersDoneModel));
    } else {
      print(response.body);
      emit(ShowOrderDoneListErrorStatus());
      throw Exception('Failed to load profile data');
    }
  }
}