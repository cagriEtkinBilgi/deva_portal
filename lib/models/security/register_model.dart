import 'dart:convert';

class RegisterModel{
  String? UserName;
  String? Password;
  String? PasswordRepeat;
  String? Name;
  String? Surname;
  String? Email;
  String? MobilePhone;
  int? ProvincialID;
  int? DistrictID;
  int? NeighborhoodID;

  RegisterModel({
      this.UserName,
      this.Password,
      this.PasswordRepeat,
      this.Name,
      this.Surname,
      this.Email,
      this.MobilePhone,
      this.ProvincialID,
      this.DistrictID,
      this.NeighborhoodID
  });

  factory RegisterModel.fromJson(str)=> RegisterModel.fromMap(json.decode(str));

  factory RegisterModel.fromMap(Map<String, dynamic> map)=>RegisterModel(
    UserName: map["UserName"],
    DistrictID: map["DistrictID"],
    Email: map["Email"],
    MobilePhone: map["MobilePhone"],
    Name: map["Name"],
    NeighborhoodID: map["NeighborhoodID"],
    Password: map["Password"],
    PasswordRepeat: map["PasswordRepeat"],
    ProvincialID: map["ProvincialID"],
    Surname: map["Surname"],
  );

  Map<String, dynamic> toMap()=>{
    "UserName":UserName,
    "DistrictID":DistrictID,
    "Email":Email,
    "MobilePhone":MobilePhone,
    "Name":Name,
    "NeighborhoodID":NeighborhoodID,
    "Password":Password,
    "PasswordRepeat":PasswordRepeat,
    "ProvincialID":ProvincialID,
    "Surname":Surname,
  };

  String toJson()=>json.encode(toMap());

}