class ProductModel{
  String? productId;
  String? productName;
  String? price;
  String? quantity;
  String? purchaseDate;
  String? expiredDate;
  String? description;
  String? categoryName;
  String? status;
  String? image ;
  String? dateCreated;
  String? id;





  ProductModel({
    this.productId,
    this.productName,
    this.price,
    this.quantity,
    this.purchaseDate,
    this.expiredDate,
    this.description,
    this.categoryName,
    this.status,
    this.image,
    this.dateCreated,
    this.id
  });
  ProductModel.fromJson(Map<String, dynamic> json) {

    productId = json['ProductId'];
    productName = json['ProductName'];
    price = json['Price'];
    quantity = json['Quantity'];
    purchaseDate = json['PurchaseDate'];
    expiredDate = json['ExpiredDate'];
    description = json['Description'];
    categoryName = json['CategoryName'];
    status = json['Status'];
    image = json['Image'].toString();
    dateCreated = json['DateCreated'];
    id = json['Id'];


  }

}