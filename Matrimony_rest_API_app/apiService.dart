import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl = 'https://67c5c06d351c081993fb4b23.mockapi.io/users';

  //region Fetch all user GETALL api method

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    var response = await http.get(Uri.parse(baseUrl));
    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  }
  //endregion

  //region Add user api method
  Future<void> addUser(Map<String, dynamic> map) async {
    var res= await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(map),
    );
    if (res.statusCode == 201) {
      print('Post successful');
      getAllUsers(); // for refreshing list we will call getALl
    } else {
      print('Failed to post');
    }
  }
  //endregion

  //region update data api method
  Future<void> updateData(String id, Map<String, dynamic> map) async {
    var response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        print('Update successful');
        getAllUsers(); // Refresh the user list after updating
      } else {
        print('Failed to update: ${response.reasonPhrase}');
      }
  }
  //endregion


  //region delete data api method
  Future<void> deleteData(String id) async {
    var res = await http.delete(Uri.parse('$baseUrl/$id'));
    if (res.statusCode == 200) {
      print('Deleted TODO: ${res.body}');
    } else {
      throw Exception('Failed to delete TODO');
    }
  }
  //endregion
}

