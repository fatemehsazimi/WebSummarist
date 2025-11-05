import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:web_summarist/features/web_summary/presentation/controllers/url_list_viewmodel.dart';
import 'package:web_summarist/features/web_summary/presentation/controllers/url_ui_state.dart';
import '../../domain/repositories/summary_repository.dart';
import '../../domain/usecases/summarize_url_usecase.dart';
import 'home_view_model.dart';

final webSummaryRepositoryProvider = Provider<WebSummaryRepository>((ref) {
  return WebSummaryRepository();
});

final summarizeUrlUseCaseProvider = Provider<SummarizeUrlUseCase>((ref) {
  final repository = ref.read(webSummaryRepositoryProvider);
  return SummarizeUrlUseCase(repository: repository);
});

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, UrlUiState>((
  ref,
) {
  return HomeViewModel(ref);
});

final urlListProvider = StateNotifierProvider<UrlListViewModel, List<String>>((
  ref,
) {
  return UrlListViewModel();
});
