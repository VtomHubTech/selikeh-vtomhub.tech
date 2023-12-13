
class shopModel{
  String? clientId;
  String? fullName;
  String? shopName;
  String? emailAddress;
  String? cPhoneNumber;
  String? ghanaCardNumber;
  String? address;
  String? status;
  String? image;



  shopModel({
    this.clientId,
    this.fullName,
    this.shopName,
    this.emailAddress,
    this.cPhoneNumber,
    this.ghanaCardNumber,
    this.address,
    this.status,
    this.image,

  });
  shopModel.fromJson(Map<String, dynamic> json) {

    clientId = json['ClientId'];
    fullName = json['FullName'];
    shopName = json['ShopName'];
    emailAddress = json['EmailAddress'];
    cPhoneNumber = json['PhoneNumber'];
    ghanaCardNumber = json['GhanaCardNumber'];
    address = json['Address'];
    status = json['Status'];
    image = json['Image'];



  }

}