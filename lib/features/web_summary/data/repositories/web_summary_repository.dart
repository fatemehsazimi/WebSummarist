import '../../domain/repositories/summary_repository.dart';
import '../models/summary_model.dart';
import '../../domain/entities/summary_entity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WebSummaryRepositoryImpl implements SummaryRepository {
  final String baseUrl;

  WebSummaryRepositoryImpl({this.baseUrl = 'http://10.0.2.2:8000/api'});

  @override
  Future<SummaryResult> summarizeUrl(String url) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/scrape-and-summarize'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'url': url}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final summaryModel = SummaryModel.fromJson(data);

        return SummaryResult(
          result: summaryModel.summaryText,
          resultState: true,
        );
      } else {
        return SummaryResult(
          result: 'Failed to summarize',
          resultState: false,
          errorMsg: 'Server returned ${response.statusCode}',
        );
      }
    } catch (e) {
      return SummaryResult(
        result: 'Failed to summarize',
        resultState: false,
        errorMsg: e.toString(),
      );
    }
  }
}
