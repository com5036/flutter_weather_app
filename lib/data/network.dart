import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Network {
  final String url;
  Network(this.url);

  // url 에서 받은 json data return
  Future<dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    }
  }
}
