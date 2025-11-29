import 'package:flutter_riverpod/legacy.dart';
import 'package:web_summarist/features/web_summary/presentation/controllers/summary_result_ui_state.dart';

class SummaryResultViewModel extends StateNotifier<SummaryResultUiState> {
  SummaryResultViewModel() : super(SummaryResultUiState.initial());

  void loadData({required String url, required String summary}) {
    state = state.copyWith(url: url, summary: summary);
  }

  Future<void> saveSummary() async {}

  Future<void> bookmarkSummary() async {}

  Future<void> exportToPdf() async {}

  Future<void> uploadSummary() async {}

  Future<void> convertToVoice() async {}
}
