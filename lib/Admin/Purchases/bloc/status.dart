abstract class ShowPurchasesAdminStatus {}

class ShowPurchasesAdminInitializeStatus extends ShowPurchasesAdminStatus{}
class ShowPurchasesAdminSuccessStatus extends ShowPurchasesAdminStatus{

  ShowPurchasesModel showPurchasesModel;

  ShowPurchasesAdminSuccessStatus(this.showPurchasesModel);
}
class ShowPurchasesAdminErrorStatus extends ShowPurchasesAdminStatus{}
class ShowPurchasesAdminLoadingStatus extends ShowPurchasesAdminStatus{}
class ShowPurchasesModel {
  List<Data>? data;

  ShowPurchasesModel({this.data});

  ShowPurchasesModel.fromJson(Map<String, dynamic> json) {
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
  String? personName;
  int? numberOfProducts;
  String? purchaseDate;
  int? moneyAmount;
  List<Products>? products;

  Data(
      {this.id,
        this.personName,
        this.numberOfProducts,
        this.purchaseDate,
        this.moneyAmount,
        this.products});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    personName = json['person_name'];
    numberOfProducts = json['number_of_products'];
    purchaseDate = json['purchase_date'];
    moneyAmount = json['money_amount'];
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
    data['person_name'] = this.personName;
    data['number_of_products'] = this.numberOfProducts;
    data['purchase_date'] = this.purchaseDate;
    data['money_amount'] = this.moneyAmount;
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
  int? productQuantity;
  String? productDescription;
  List<Colorss>? colors;

  Products(
      {this.productName,
        this.productPrice,
        this.productImage,
        this.productQuantity,
        this.productDescription,
        this.colors});

  Products.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productPrice = json['product_price'];
    productImage = json['product_image'];
    productQuantity = json['product_quantity'];
    productDescription = json['product_description'];
    if (json['colors'] != null) {
      colors = <Colorss>[];
      json['colors'].forEach((v) {
        colors!.add(new Colorss.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_image'] = this.productImage;
    data['product_quantity'] = this.productQuantity;
    data['product_description'] = this.productDescription;
    if (this.colors != null) {
      data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Colorss {
  int? colorId;
  String? colorName;

  Colorss({this.colorId, this.colorName});

  Colorss.fromJson(Map<String, dynamic> json) {
    colorId = json['color_id'];
    colorName = json['color_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color_id'] = this.colorId;
    data['color_name'] = this.colorName;
    return data;
  }
}