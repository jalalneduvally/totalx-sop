import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String name;
  String phoneNumber;
  String image;
  String id;
  int age;
  bool delete;
  Timestamp date;
  List search;

  UserModel({
    required this.name,
    required this.phoneNumber,
    required this.image,
    required this.age,
    required this.delete,
    required this.search,
    required this.date,
    required this.id,
  });
  UserModel copyWith({
    String? name,
    String? phoneNumber,
    int? age,
    String? id,
    String? image,
    bool? delete,
    Timestamp? date,
    List? search,
  })=>
      UserModel
        (name: name?? this.name,
        phoneNumber: phoneNumber?? this.phoneNumber,
        image: image?? this.image,
        age: age?? this.age,
        delete: delete?? this.delete,
        search: search?? this.search,
        date: date?? this.date,
        id: id?? this.id,
      );
  factory UserModel.fromMap(dynamic json)=>UserModel(
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    image: json["image"],
    age: json["age"]??0,
    delete: json["delete"],
    id: json["id"],
    date: json["date"],
    search: json["search"],
  );
  Map<String,dynamic> toMap()=>{
    "name":name,
    "phoneNumber":phoneNumber,
    "image":image,
    "age":age,
    "delete":delete,
    "date":date,
    "id":id,
    "search":search,
  };
}