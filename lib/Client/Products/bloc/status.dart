abstract class ShowProductsClientStatus {}

class ShowProductsClientInitializeStatus extends ShowProductsClientStatus{}
class ShowProductsClientSuccessStatus extends ShowProductsClientStatus{
  ShowProductsModel showProductsModel;

  ShowProductsClientSuccessStatus(this.showProductsModel);
}
class ShowProductsClientErrorStatus extends ShowProductsClientStatus{}
class ShowProductsClientLoadingStatus extends ShowProductsClientStatus{}

class EditProductsClientSuccessStatus extends ShowProductsClientStatus{}
class EditProductsClientErrorStatus extends ShowProductsClientStatus{}
class EditProductsClientLoadingStatus extends ShowProductsClientStatus{}

class ShowProductsModel {
  List<Products>? products;

  ShowProductsModel({this.products});

  ShowProductsModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? name;
  int? price;
  String? description;
  String? image;
  List<Colorss>? colors;
  String? createdAt;

  Products(
      {this.id,
        this.name,
        this.price,
        this.description,
        this.image,
        this.colors,
        this.createdAt});

  Products.fromJson(Map<String, dynamic> json) {
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