import 'dart:convert';
import 'package:http/http.dart' as http;

class URLS {
  static const String BASE_URL =
      'https://adnan-rest-api.herokuapp.com/states';
}

class ApiService {
  static Future<List<Map<String, dynamic>>?> getStates() async {
    try {
      http.Response response = await http.get(Uri.parse( '${URLS.BASE_URL}'),
        headers: <String,String> {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': "*",
      },);
      if (response.statusCode == 200) {
        var mapData = json.decode(response.body);
        List<Map<String, dynamic>> map =
        List<Map<String, dynamic>>.from(mapData.map((x) => x));
        return map;
      } else {
        return null;
      }
    } catch (err) {
      print(err);
    }
    return null;
  }

  static Future<bool> addState(body) async {
    print('api data ' + body.toString());
    http.Response response = await http.post(Uri.parse('${URLS.BASE_URL}'),headers: <String,String> {
      'Content-Type': 'application/json',
      'Accept': 'appliction/json',
      // 'Access-Control-Allow-Origin': "*",
    },  body: jsonEncode(body));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

   static  Future<bool>  deleteState(String id) async {
    final http.Response response = await http.delete(
      Uri.parse
        ('https://adnan-rest-api.herokuapp.com/states/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }

  }


}