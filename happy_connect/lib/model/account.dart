
import 'data.dart';

class Account {
  String? code;
  dynamic message;
  Data? data;

  Account({this.code, this.message, this.data});
  Account.none();

  Account.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["code"] = code;
    _data["message"] = message;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }

  @override
  String toString() {
    return 'Account{code: $code, message: $message, data: $data}';
  }


}

