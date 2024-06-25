import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happy_connect/model/account.dart';
import 'package:happy_connect/network/fetch_api_login.dart';

// final fetchApiLoginProvider = Provider<FetchApiLogin>((ref) {
//   print("fetchApiLoginProvider is called");
//   return FetchApiLogin();
// });

final requestDataLoginProvider = FutureProvider.family<Account,Map<String,String>>((ref,body) async {
  print("requestDataLoginProvider is called");
  return await FetchApiLogin().getToken(body) ;
});
