import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Provider/Products/bloc/status.dart';
import 'package:project_zain2/utils/end_point.dart';
import 'package:project_zain2/utils/shared_prefirance.dart';
import 'package:http/http.dart'as http;
class ShowProductsProviderCubit extends Cubit<ShowProductsProviderStatus>{
ShowProductsProviderCubit():super(ShowProductsProviderInitializeStatus());

late ProductsProviderModel productsProviderModel;
Future<ProductsProviderModel?> getProducts() async {
  print("heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
  final headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
  };
  final response = await http
      .get(Uri.parse('$BASE_URL/api/provider/products'), headers: headers);
  if (response.statusCode == 200) {
    final parsedJson = jsonDecode(response.body);
    print(response.body);
    productsProviderModel = ProductsProviderModel.fromJson(parsedJson);
    print(response.body);

    emit(ShowProductsProviderSuccessStatus(productsProviderModel));
  } else {
    print(response.body);
    emit(ShowProductsProviderErrorStatus());
    throw Exception('Failed to load profile data');
  }
}
}