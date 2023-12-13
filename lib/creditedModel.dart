class creditModel{
  String? purchaseId;
  String? userId;
  String? productId;
  String? productName;
  String? description;
  String? quantity;
  String? unitPrice;
  String? totalPrice;
  String? purchaseType;
  String? paymentMode;
  String? image;
  String? purchaseBy;
  String? datePurchase;


  creditModel({
    this.productName,
    this.totalPrice,
    this.purchaseType,
    this.unitPrice,
    this.userId,
    this.quantity,
    this.productId,
    this.image,
    this.description,
    this.datePurchase,
    this.paymentMode,
    this.purchaseBy,
    this.purchaseId
  });

  creditModel.fromJson(Map<String, dynamic> json) {

    productName = json['ProductName'];
    totalPrice = json['TotalPrice'];
    purchaseType = json['PurchaseType'];
    unitPrice = json['UnitPrice'];
    userId = json['UserId'];
    quantity = json['Quantity'];
    productId = json['ProductId'];
    image = json['Image'];
    description = json['Description'];
    datePurchase = json['DatePurchase'];
    paymentMode = json['PaymentMode'];
    purchaseBy = json['PurchaseBy'];
    purchaseId = json['PurchaseId'];

  }



}
