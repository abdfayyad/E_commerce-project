import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Admin/Products/bloc/status.dart';
import 'package:project_zain2/Client/Invoices/bloc/status.dart';
import 'package:project_zain2/utils/end_point.dart';
import 'package:project_zain2/utils/shared_prefirance.dart';
import 'package:http/http.dart' as http;

class ShowInvoicesCubit extends Cubit<ShowInvoicesStatus> {
  ShowInvoicesCubit() : super(ShowInvoicesInitializeStatus());
  late ShowInvoicesModel showInvoicesModel;

  Future<ShowInvoicesModel?> getInvoices() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http
        .get(Uri.parse('${BASE_URL}/api/client/purchases'), headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      showInvoicesModel = ShowInvoicesModel.fromJson(parsedJson);

      emit(ShowInvoicesSuccessStatus(showInvoicesModel));
    } else {
      print("certificate field");
      emit(ShowInvoicesErrorStatus());
      throw Exception('Failed to load profile data');
    }
  }
}
