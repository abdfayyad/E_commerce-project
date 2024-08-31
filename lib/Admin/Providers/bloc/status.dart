import 'dart:ffi';

abstract class ShowProviderStatus {}

class ShowProviderInitializeStatus extends ShowProviderStatus{}
class ShowProviderSuccessStatus extends ShowProviderStatus{
  ShowProvidersModel showProvidersModel;

  ShowProviderSuccessStatus(this.showProvidersModel);
}
class ShowProviderErrorStatus extends ShowProviderStatus{}
class ShowProviderLoadingStatus extends ShowProviderStatus{}

class AddProviderSuccessStatus extends ShowProviderStatus{}
class AddProviderErrorStatus extends ShowProviderStatus{}
class AddProviderLoadingStatus extends ShowProviderStatus{}

class DeleteProviderSuccessStatus extends ShowProviderStatus{}
class DeleteProviderErrorStatus extends ShowProviderStatus{}
class DeleteProviderLoadingStatus extends ShowProviderStatus{}


class ShowProvidersModel {
  List<Data>? data;

  ShowProvidersModel({this.data});

  ShowProvidersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? address;
  String? gender;
  dynamic? percentage;

  Data(
      {this.id,
        this.name,
        this.email,
        this.address,
        this.gender,
        this.percentage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    gender = json['gender'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['percentage'] = this.percentage;
    return data;
  }
}