abstract class ShowOrderAdminStatus {}

class ShowOrderAdminInitializeStatus extends ShowOrderAdminStatus{}
class ShowOrderAdminSuccessStatus extends ShowOrderAdminStatus{
  ShowOrderAdminModel showOrderAdminModel;

  ShowOrderAdminSuccessStatus(this.showOrderAdminModel);
}
class ShowOrderAdminErrorStatus extends ShowOrderAdminStatus{}
class ShowOrderAdminLoadingStatus extends ShowOrderAdminStatus{}


class DeleteOrderAdminSuccessStatus extends ShowOrderAdminStatus{}
class DeleteOrderAdminErrorStatus extends ShowOrderAdminStatus{}
class DeleteOrderAdminLoadingStatus extends ShowOrderAdminStatus{}

class EditOrderAdminSuccessStatus extends ShowOrderAdminStatus{}
class EditOrderAdminErrorStatus extends ShowOrderAdminStatus{}
class EditOrderAdminLoadingStatus extends ShowOrderAdminStatus{}

class ShowOrderAdminModel {
  List<Data>? data;

  ShowOrderAdminModel({this.data});

  ShowOrderAdminModel.fromJson(Map<String, dynamic> json) {
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
  int? numberOfProducts;
  String? clientName;
  int? totalPrice;
  List<Products>? products;

  Data(
      {this.id,
        this.numberOfProducts,
        this.clientName,
        this.totalPrice,
        this.products});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    numberOfProducts = json['number_of_products'];
    clientName = json['client_name'];
    totalPrice = json['total_price'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number_of_products'] = this.numberOfProducts;
    data['client_name'] = this.clientName;
    data['total_price'] = this.totalPrice;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? productName;
  int? productPrice;
  String? productImage;

  Products({this.productName, this.productPrice, this.productImage});

  Products.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productPrice = json['product_price'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_image'] = this.productImage;
    return data;
  }
}