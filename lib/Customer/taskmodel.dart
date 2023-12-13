class taskModel {
  String? Id;
  String? userId;
  String? clientId;
  String? firstName;
  String? lastName;
  String? fullName;
  String? shopName;
  String? emailAddress;
  String? PhoneNumber;
  String? ghanaId;
  String? ghanaCardNumber;
  String? address;
  String? repName;
  String? repPhoneNuber;
  String? image;

  taskModel({
    this.Id,
    this.userId,
    this.clientId,
    this.firstName,
    this.lastName,
    this.fullName,
    this.shopName,
    this.emailAddress,
    this.PhoneNumber,
    this.ghanaId,
    this.ghanaCardNumber,
    this.address,
    this.repName,
    this.repPhoneNuber,
    this.image,
  });
  taskModel.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    userId = json['UserId'];
    clientId = json['ClientId'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    fullName = json['FullName'];
    shopName = json['ShopName'];
    emailAddress = json['EmailAddress'];
    PhoneNumber = json['PhoneNumber'];
    ghanaId = json['GhanaId'];
    ghanaCardNumber = json['GhanaCardNumber'];
    address = json['Address'];
    repName = json['RepFullName'];
    repPhoneNuber = json['Status'];
    image = json['Image'];
  }
}
