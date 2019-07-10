import 'home_entity.dart';

class StoreEntity {
	List<StoreModel> stores;

	StoreEntity({this.stores});

	StoreEntity.fromJson(Map<String, dynamic> json) {
		if (json['store'] != null) {
			stores = new List<StoreModel>();(json['store'] as List).forEach((v) { stores.add(new StoreModel.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.stores != null) {
      data['store'] =  this.stores.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class StoreModel with HomeListItem{
	String name;
	String photo;
	int id;
	List<StoreProduct> products;

	StoreModel({this.name, this.photo, this.id, this.products});

	StoreModel.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		photo = json['photo'];
		id = json['id'];
		if (json['products'] != null) {
			products = new List<StoreProduct>();(json['products'] as List).forEach((v) { products.add(new StoreProduct.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['photo'] = this.photo;
		data['id'] = this.id;
		if (this.products != null) {
      data['products'] =  this.products.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class StoreProduct {
	int storeId;
	String img;
	String price;
	String name;
	int id;

	StoreProduct({this.storeId, this.img, this.price, this.name, this.id});

	StoreProduct.fromJson(Map<String, dynamic> json) {
		storeId = json['store_id'];
		img = json['img'];
		price = json['price'];
		name = json['name'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['store_id'] = this.storeId;
		data['img'] = this.img;
		data['price'] = this.price;
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}
}
