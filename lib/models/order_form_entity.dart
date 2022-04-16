class OrderFormEntity {
  List<OrderFormListItem> items;

  OrderFormEntity(this.items);

}

enum OrderForm{
  payment,
  pending,
  comment,
  afterSale
}

abstract class OrderFormListItem {
  int? id;
  late String storeName;
  late String imgUrl;
  late String status;
  late String title;
  double? price;
  int? amount;
  late String weight;
  double? total;
  late OrderForm type;

  emptyInstance();
}

// 全部
class AllItem extends OrderFormListItem {
  static final _instance = AllItem()
    ..id = -1
    ..storeName=''
    ..imgUrl=''
    ..status=''
    ..title=''
    ..price=0.0
    ..amount=0
    ..weight=''
    ..total=0.0
    ..type=OrderForm.payment;


  @override
  emptyInstance() {
    return _instance;
  }
}

//// 待付款
//class PaymentItem extends OrderFormListItem {}
//
//// 待完成
//class PendingItem extends OrderFormListItem {}
//
//// 待评价
//class CommentItem extends OrderFormListItem {}
//
//// 售后
//class AfterSaleItem extends OrderFormListItem {}










