import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Admin/Providers/bloc/status.dart';

import '../../../utils/end_point.dart';
import '../../../utils/shared_prefirance.dart';
import 'package:http/http.dart' as http;

class ShowProvidersCubit extends Cubit<ShowProviderStatus> {
  ShowProvidersCubit() : super(ShowProviderInitializeStatus());
  late ShowProvidersModel showProvidersModel;

  Future<ShowProvidersModel?> getProviders() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      // Replace with your header key and value
    };

    final response = await http
        .get(Uri.parse('$BASE_URL/api/admin/providers'), headers: headers);

    if (response.statusCode == 200) {
print(response.body);
      final parsedJson = jsonDecode(response.body);

      showProvidersModel = ShowProvidersModel.fromJson(parsedJson);

      emit(ShowProviderSuccessStatus(showProvidersModel));
    } else {
      print(response.body);
      emit(ShowProviderErrorStatus());
      throw Exception('Failed to load profile data');
    }
  }
}
