import 'dart:convert';
import 'package:http/http.dart' as http;

class WebSummaryRemoteDataSource {
  final String baseUrl = "http://127.0.0.1:8000/api";

  Future<Map<String, dynamic>> summarizeUrl(String url) async {
    final response = await http.post(
      Uri.parse("$baseUrl/scrape-and-summarize"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"url": url}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("API Error: ${response.body}");
    }
  }
}
