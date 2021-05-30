class Product{
  String name;
  String sn;
  int unitPrice;
  String stockLevel;
  String sId;

  Product({this.name, this.sn, this. unitPrice, this.stockLevel, this.sId});

  Product.fromJson(Map<String, dynamic> json){
    name=json['name'];
    sn=json['sn'];
    unitPrice=json['unit_price'];
    stockLevel=json['stock_level'].toString();
    sId=json['_id'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data=new Map<String, dynamic>();

    data['name']=this.name;
    data['sn']=this.sn;
    data['unit_price']=this.unitPrice;
    data['stock_level']=this.stockLevel;
    data['_id']=this.sId;
    return data;
  }
}