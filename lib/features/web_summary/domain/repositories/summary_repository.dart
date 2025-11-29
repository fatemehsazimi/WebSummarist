import '../entities/summary_entity.dart';

abstract class SummaryRepository {
  Future<SummaryResult> summarizeUrl(String url);
}
