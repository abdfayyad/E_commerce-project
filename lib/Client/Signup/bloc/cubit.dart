

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Client/Signup/bloc/status.dart';
import 'package:http/http.dart'as http;
import 'package:project_zain2/utils/end_point.dart';
class SignInCubit extends Cubit<SignInScreenStates>
{
  SignInCubit():super(SignInInitialState()) ;
  static SignInCubit get(context)=>BlocProvider.of(context);
late SignInModel signInModel;
  Future<void> loginUser(String name, String email, String password,  String phoneNumber , String gender ,String address) async {
    // Set loading state
    emit(SignInLoadingState());

    try {
      // Make HTTP request to your login API
      final response = await http.post(
        Uri.parse('$BASE_URL/api/register'),
        body: {'name':name,'email': email, 'password': password,'phone_number':phoneNumber,'gender':gender,'address': address},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        print("success");
        signInModel=SignInModel.fromJson(responseData);
        emit(SignInSuccessState(signInModel));
        print("------------------------------------");
      } else {

        print(response.body);
        // Unsuccessful login
        print("faild");
        final Map<String, dynamic> responseData = json.decode(response.body);
        final errorMessage = responseData['message'] as String;
        emit(SignInErrorState());
      }
    } catch (e) {
      // Error occurred
      emit(SignInErrorState());
    }
  }

  IconData suffix=Icons.visibility;
  bool isPasswordShow=true;
  void changePasswordVisibility(){
    isPasswordShow=!isPasswordShow;

    suffix= isPasswordShow?
    Icons.visibility:Icons.visibility_off;
    emit(SignInChangePasswordVisibilityState());
  }
}