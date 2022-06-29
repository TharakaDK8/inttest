class Items {
  bool? status;
  List<Result>? result;

  Items({this.status, this.result});

  Items.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? id;
  String? name;
  String? category;
  String? brand;
  String? model;
  double? price;
  String? colour;
  String? weight;
  String? image;

  Result(
      {this.id,
        this.name,
        this.category,
        this.brand,
        this.model,
        this.price,
        this.colour,
        this.weight,
        this.image});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    brand = json['brand'];
    model = json['model'];
    price = json['price'];
    colour = json['colour'];
    weight = json['weight'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['price'] = this.price;
    data['colour'] = this.colour;
    data['weight'] = this.weight;
    data['image'] = this.image;
    return data;
  }
}