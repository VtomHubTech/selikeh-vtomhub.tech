class PurchaseModel {

  String? id;
  String? purchaseType;

  PurchaseModel({
    this.id,
    this.purchaseType,

  });

  PurchaseModel.fromJson(Map<String, dynamic> json) {

    id = json['Id'];
    purchaseType = json['PurchaseType'];

  }


}