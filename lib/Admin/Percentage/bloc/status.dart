abstract class PercentageProvidersStatus{}
class PercentageProvidersInitializeStatus extends PercentageProvidersStatus{}
class PercentageProvidersSuccessStatus extends PercentageProvidersStatus{
  PercentageModel percentageModel;

  PercentageProvidersSuccessStatus(this.percentageModel);
}
class PercentageProvidersErrorStatus extends PercentageProvidersStatus{}
class PercentageProvidersLoadingStatus extends PercentageProvidersStatus{}


class PercentageModel {
  List<Data>? data;

  PercentageModel({this.data});

  PercentageModel.fromJson(Map<String, dynamic> json) {
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
  double? percentage;
  String? phoneNumber;
  List<Produncts>? produncts;

  Data(
      {this.id,
        this.name,
        this.email,
        this.address,
        this.gender,
        this.percentage,
        this.phoneNumber,
        this.produncts});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    gender = json['gender'];

    // Convert the percentage to double, regardless if it is stored as int in JSON
    percentage = (json['percentage'] as num?)?.toDouble();

    phoneNumber = json['phone_number'];
    if (json['produncts'] != null) {
      produncts = <Produncts>[];
      json['produncts'].forEach((v) {
        produncts!.add(new Produncts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['percentage'] = this.percentage;
    data['phone_number'] = this.phoneNumber;
    if (this.produncts != null) {
      data['produncts'] = this.produncts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Produncts {
  int? id;
  String? name;
  String? image;
  int? price;
  String? description;
  int? quantity;
  int? userId;
  int? providerId;
  String? createdAt;
  String? updatedAt;
  dynamic? priceAdmin;
  dynamic? preiceProvider;

  Produncts(
      {this.id,
        this.name,
        this.image,
        this.price,
        this.description,
        this.quantity,
        this.userId,
        this.providerId,
        this.createdAt,
        this.updatedAt,
        this.priceAdmin,
        this.preiceProvider});

  Produncts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    description = json['description'];
    quantity = json['quantity'];
    userId = json['user_id'];
    providerId = json['provider_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    priceAdmin = json['priceAdmin'];
    preiceProvider = json['preiceProvider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['user_id'] = this.userId;
    data['provider_id'] = this.providerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['priceAdmin'] = this.priceAdmin;
    data['preiceProvider'] = this.preiceProvider;
    return data;
  }
}