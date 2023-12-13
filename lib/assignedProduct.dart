class assignedProductModel{
  String? productId;
  String? productName;
  String? price;
  String? creditedPrice;
  String? quantity;
  String? userId;
  String? lastName;
  String? description;
  String? firstName;
  String? status;
  String? image ;
  String? dateAssigned;
  String? id;





  assignedProductModel({
    this.productId,
    this.productName,
    this.price,
    this.creditedPrice,
    this.quantity,
    this.userId,
    this.lastName,
    this.description,
    this.firstName,
    this.status,
    this.image,
    this.dateAssigned,
    this.id
  });
  assignedProductModel.fromJson(Map<String, dynamic> json) {

    productId = json['ProductId'];
    productName = json['ProductName'];
    price = json['CashPrice'];
    creditedPrice = json['CreditedPrice'];
    quantity = json['Quantity'];
    userId = json['UserId'];
    lastName = json['LastName'];
    description = json['Description'];
    firstName = json['FirstName'];
    status = json['Status'];
    image = json['Image'];
    dateAssigned = json['DateAssigned"'];
    id = json['Id'];
    creditedPrice = json['CreditedPrice'];


  }
}