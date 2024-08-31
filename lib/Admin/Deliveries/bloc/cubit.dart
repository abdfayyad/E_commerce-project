import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Admin/Deliveries/bloc/status.dart';
import 'package:http/http.dart' as http;
import 'package:project_zain2/utils/shared_prefirance.dart';

import '../../../utils/end_point.dart';

class ShowDeliveriesCubit extends Cubit<ShowDeliveriesStatus> {
  ShowDeliveriesCubit() : super(ShowDeliveriesInitializeStatus());
  late ShowDeliveriesModel showDeliveriesModel;

  Future<ShowDeliveriesModel?> getDeliveries() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      // Replace with your header key and value
    };
    final response = await http
        .get(Uri.parse('$BASE_URL/api/admin/deliveries'), headers: headers);
    if (response.statusCode == 200) {
      final parsedJson = jsonDecode(response.body);
      showDeliveriesModel = ShowDeliveriesModel.fromJson(parsedJson);
      emit(ShowDeliveriesSuccessStatus(showDeliveriesModel));
    } else {
      emit(ShowDeliveriesErrorStatus());
      throw Exception('Failed tgetDeliverieso load profile data');
    }
  }
}
