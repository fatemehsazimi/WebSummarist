import '../entities/summary_entity.dart';
import '../repositories/summary_repository.dart';

class SummarizeUrlUseCase {
  final WebSummaryRepository repository;

  SummarizeUrlUseCase({required this.repository});

  Future<SummaryResult> execute(String url) async {
    final result = await repository.summarizeUrl(url);
    return result;
  }
}
