abstract class ShowProductsProviderStatus {}

class ShowProductsProviderInitializeStatus extends ShowProductsProviderStatus{}
class ShowProductsProviderSuccessStatus extends ShowProductsProviderStatus{
  ProductsProviderModel productsProviderModel;

  ShowProductsProviderSuccessStatus(this.productsProviderModel);
}
class ShowProductsProviderErrorStatus extends ShowProductsProviderStatus{}
class ShowProductsProviderLoadingStatus extends ShowProductsProviderStatus{}


class ProductsProviderModel {
  List<Data>? data;

  ProductsProviderModel({this.data});

  ProductsProviderModel.fromJson(Map<String, dynamic> json) {
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
  int? price;
  String? description;
  String? image;
  List<Colorss>? colors;
  String? productOwnerName;
  String? createdAt;

  Data(
      {this.id,
        this.name,
        this.price,
        this.description,
        this.image,
        this.colors,
        this.productOwnerName,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    if (json['colors'] != null) {
      colors = <Colorss>[];
      json['colors'].forEach((v) {
        colors!.add(new Colorss.fromJson(v));
      });
    }
    productOwnerName = json['product_owner_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['image'] = this.image;
    if (this.colors != null) {
      data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    }
    data['product_owner_name'] = this.productOwnerName;
    data['created_at'] = this.createdAt;
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
