class ErrorModel implements Exception {

  int? errorStatus;
  String? message;
  int? onAuth;

  ErrorModel({this.errorStatus, this.message="", this.onAuth});

 @override
  String toString() {
    return "Code: "+errorStatus.toString()+" "+ message!;
  }

}