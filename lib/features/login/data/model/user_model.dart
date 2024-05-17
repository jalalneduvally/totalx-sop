import 'package:cloud_firestore/cloud_firestore.dart';

class AuthModel{
  String id;
  String phone;
  bool delete;
  DateTime createDate;
  DateTime updateDate;
  DocumentReference reference;

  AuthModel({
    required this.id,
    required this.delete,
    required this.reference,
    required this.phone,
    required this.createDate,
    required this.updateDate,

  });
  AuthModel copyWith({
    String? id,
    bool? delete,
    String? phone,
    DateTime? createDate,
    DateTime? updateDate,
    DocumentReference? reference,
  })=>
      AuthModel(
        id: id?? this.id,
        delete: delete?? this.delete,
        reference: reference?? this.reference,
        phone: phone ?? this.phone,
        createDate: createDate ?? this.createDate,
        updateDate: updateDate ?? this.updateDate,
      );
  factory AuthModel.fromjson(dynamic json)=>AuthModel(
      id: json["id"],
      delete: json["delete"],
      reference: json["reference"],
      phone: json['phone'],
      createDate: json["createDate"].toDate(),
      updateDate: json["updateDate"].toDate(),
  );
  Map<String,dynamic> toJson()=>{
    "id":id,
    "delete":delete,
    "reference":reference,
    'phone':phone,
    'createDate':createDate,
    'updateDate':updateDate,
  };
}