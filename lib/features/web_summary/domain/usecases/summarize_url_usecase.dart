import '../entities/summary_entity.dart';
import '../repositories/summary_repository.dart';

class SummarizeUrlUseCase {
  final SummaryRepository repository;

  SummarizeUrlUseCase({required this.repository});

  Future<SummaryResult> execute(String url) {
    return repository.summarizeUrl(url);
  }
}
