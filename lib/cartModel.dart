class cartModel{
  String? cartId;
  String? cProductId;
  String? cProductName;
  String? cQuantity;
  String? unitPrice;
  String? totalPrice;
  String? dateCreated;




  cartModel({
    this.cartId,
    this.cProductId,
    this.cProductName,
    this.cQuantity,
    this.unitPrice,
    this.totalPrice,
    this.dateCreated,


  });
  cartModel.fromJson(Map<String, dynamic> json) {

    cartId = json['CartId'];
    cProductId = json['ProductId'];
    cProductName = json['ProductName'];
    cQuantity = json['Quantity'];
    unitPrice = json['UnitPrice'];
    totalPrice = json['TotalCashPrice'];
    dateCreated = json['DateCreated'];



  }

}