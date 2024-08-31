abstract class ShowOrderDoneListStatus {}

class ShowOrderDoneListInitializeStatus extends ShowOrderDoneListStatus{}
class ShowOrderDoneListSuccessStatus extends ShowOrderDoneListStatus{
  ShowOrdersDoneModel showOrdersDoneModel;

  ShowOrderDoneListSuccessStatus(this.showOrdersDoneModel);
}
class ShowOrderDoneListErrorStatus extends ShowOrderDoneListStatus{}
class ShowOrderDoneListLoadingStatus extends ShowOrderDoneListStatus{}

class ShowOrdersDoneModel {
  List<Data>? data;

  ShowOrdersDoneModel({this.data});

  ShowOrdersDoneModel.fromJson(Map<String, dynamic> json) {
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
  int? deliveryOrderId;
  String? status;
  String? deliveredAt;
  Order? order;
  Client? client;
  List<Products>? products;

  Data(
      {this.deliveryOrderId,
        this.status,
        this.deliveredAt,
        this.order,
        this.client,
        this.products});

  Data.fromJson(Map<String, dynamic> json) {
    deliveryOrderId = json['delivery_order_id'];
    status = json['status'];
    deliveredAt = json['delivered_at'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    client =
    json['client'] != null ? new Client.fromJson(json['client']) : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delivery_order_id'] = this.deliveryOrderId;
    data['status'] = this.status;
    data['delivered_at'] = this.deliveredAt;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int? id;
  int? totalPrice;
  String? deliveryAddress;
  String? status;

  Order({this.id, this.totalPrice, this.deliveryAddress, this.status});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalPrice = json['total_price'];
    deliveryAddress = json['delivery_address'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total_price'] = this.totalPrice;
    data['delivery_address'] = this.deliveryAddress;
    data['status'] = this.status;
    return data;
  }
}

class Client {
  int? id;
  String? name;
  String? address;
  String? phoneNumber;
  String? gender;

  Client({this.id, this.name, this.address, this.phoneNumber, this.gender});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['gender'] = this.gender;
    return data;
  }
}

class Products {
  int? id;
  String? name;
  int? price;
  String? image;
  String? description;

  Products({this.id, this.name, this.price, this.image, this.description});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}