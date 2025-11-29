import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:web_summarist/features/web_summary/presentation/controllers/summary_result_ui_state.dart';
import 'package:web_summarist/features/web_summary/presentation/controllers/summary_result_view_model.dart';
import 'package:web_summarist/features/web_summary/presentation/controllers/url_list_viewmodel.dart';
import 'package:web_summarist/features/web_summary/presentation/controllers/url_ui_state.dart';
import '../../data/models/urls_model.dart';
import '../../data/repositories/web_summary_repository.dart';
import '../../domain/repositories/summary_repository.dart';
import '../../domain/usecases/summarize_url_usecase.dart';
import 'home_view_model.dart';

final webSummaryRepositoryProvider = Provider<SummaryRepository>((ref) {
  return WebSummaryRepositoryImpl(baseUrl: 'http://10.0.2.2:8000/api');
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

final urlsViewModelProvider =
    StateNotifierProvider<UrlsViewModel, List<UrlsModel>>((ref) {
      return UrlsViewModel();
    });

final summaryResultViewModelProvider =
    StateNotifierProvider<SummaryResultViewModel, SummaryResultUiState>((ref) {
      return SummaryResultViewModel();
    });
