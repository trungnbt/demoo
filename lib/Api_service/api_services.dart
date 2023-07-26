import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart';
import 'dart:async';

import '../DTO/user.dart';

class ApiServices {
//   static Future fetchUser() async {
//     var url = Uri.parse('https://spsapiservice.azurewebsites.net/api/TbUsers');
//     return await http.get(url);
//   }
//   Future<bool> logins(String inputemail, inputpassword) async {
//     bool check = false;
//     final response = await get(
//       Uri.parse('https://apiserverplan.azurewebsites.net/api/TbUsers'),
//     );
//     if (response.statusCode == 200) {
//       var data = json.decode(response.body);
//       List<loginUser> listAccount = [];
//       for (var list in data) {
//         loginUser Luser = loginUser(email: list['email'], pass: list['pass']);
//         listAccount.add(Luser);
//       }
//       for (int i = 0; i < listAccount.length; i++) {
//         loginUser list1 = listAccount[i];
//         if (inputemail == listAccount[i].email &&
//             inputpassword == listAccount[i].pass) {
//           check = true;
//           break;
//         } else {
//           check = false;
//         }
//       }
//     return check;
//     } else {
//       throw Exception('fail');
//     }
//   }
// }
}
