import 'package:project_zain2/Admin/Deliveries/bloc/cubit.dart';

abstract class ShowDeliveriesStatus {}


class ShowDeliveriesInitializeStatus extends ShowDeliveriesStatus{}
class ShowDeliveriesSuccessStatus extends ShowDeliveriesStatus{
  ShowDeliveriesModel showDeliveriesModel;

  ShowDeliveriesSuccessStatus(this.showDeliveriesModel);
}
class ShowDeliveriesErrorStatus extends ShowDeliveriesStatus{}
class ShowDeliveriesLoadingStatus extends ShowDeliveriesStatus{}

class AddDeliveriesSuccessStatus extends ShowDeliveriesStatus{}
class AddDeliveriesErrorStatus extends ShowDeliveriesStatus{}
class AddDeliveriesLoadingStatus extends ShowDeliveriesStatus{}

class DeleteDeliveriesSuccessStatus extends ShowDeliveriesStatus{}
class DeleteDeliveriesErrorStatus extends ShowDeliveriesStatus{}
class DeleteDeliveriesLoadingStatus extends ShowDeliveriesStatus{}


class ShowDeliveriesModel {
  List<Data>? data;

  ShowDeliveriesModel({this.data});

  ShowDeliveriesModel.fromJson(Map<String, dynamic> json) {
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

  Data({this.id, this.name, this.email, this.address, this.gender});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['gender'] = this.gender;
    return data;
  }
}