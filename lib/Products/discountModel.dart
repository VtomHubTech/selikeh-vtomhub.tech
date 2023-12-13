class disModel {
  String? Id;
  String? discount;

  disModel({
    this.discount,
    this.Id,
  });

  disModel.fromJson(Map<String, dynamic> json) {
    Id = json['ID'];
    discount = json['Discount'];
  }
}
