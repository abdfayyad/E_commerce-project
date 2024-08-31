abstract class SignInScreenStates{}

class SignInInitialState extends SignInScreenStates{}
class SignInLoadingState extends SignInScreenStates{}
class SignInSuccessState extends SignInScreenStates
{
  SignInModel signInModel;
  SignInSuccessState(this.signInModel);
}
class SignInErrorState extends SignInScreenStates{

}
class SignInChangePasswordVisibilityState extends SignInScreenStates{}

class SignInModel {
  String? message;
  String? token;
  String? role;

  SignInModel({this.message, this.token, this.role});

  SignInModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    data['role'] = this.role;
    return data;
  }
}