class GoodsEntity {
	List<GoodsModel> goods;

	GoodsEntity({this.goods});

	GoodsEntity.fromJson(Map<String, dynamic> json) {
		if (json['goods'] != null) {
			goods = new List<GoodsModel>();(json['goods'] as List).forEach((v) { goods.add(new GoodsModel.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.goods != null) {
      data['goods'] =  this.goods.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class GoodsModel {
	String price;
	String name;
	String photo;
	int id;

	GoodsModel({this.price, this.name, this.photo, this.id});

	GoodsModel.fromJson(Map<String, dynamic> json) {
		price = json['price'];
		name = json['name'];
		photo = json['photo'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['price'] = this.price;
		data['name'] = this.name;
		data['photo'] = this.photo;
		data['id'] = this.id;
		return data;
	}
}
