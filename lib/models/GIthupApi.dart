import 'dart:async';
import 'dart:convert';
import 'package:advance/models/model.dart';
import 'package:http/http.dart' show Client, Response;

class GithubApi {

  final Client _client = Client();

  static const String _url = 
  'https://api.github.com/repos/tensor-programming/utopian-rocks-mobile/releases';

  Future<GithubModel> getReleases() async {
    String resBody = 
    await _client.get(Uri.parse(_url))
    .then((Response res) => res.body);

    List ghJson = json.decode(resBody);
    var x = ghJson.map((el) => GithubModel.fromJson(el)).toList();
  return x.first;
  }
}
