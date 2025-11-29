import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/enums/url_validation_state.dart';
import '../../domain/enums/web_summary_state.dart';
import '../controllers/providers.dart';
import 'url_ui_state.dart';

class HomeViewModel extends StateNotifier<UrlUiState> {
  final Ref ref;

  HomeViewModel(this.ref) : super(UrlUiState.initial());

  void setUrl(String url) {
    if (url.isEmpty) {
      state = state.copyWith(
        showDialog: true,
        validationState: UrlValidationState.invalidFormat,
        errorMessage: 'error_empty_url',
      );
      return;
    }

    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      state = state.copyWith(
        showDialog: true,
        validationState: UrlValidationState.invalidFormat,
        errorMessage: 'error_invalid_url',
      );
      return;
    }

    _summarize(url);
  }

  Future<void> _summarize(String url) async {
    state = state.copyWith(
      webSummaryUiState: state.webSummaryUiState.copyWith(
        status: WebSummaryState.loading,
      ),
    );

    final useCase = ref.read(summarizeUrlUseCaseProvider);

    final summaryResult = await useCase.execute(url);

    if (summaryResult.resultState == true &&
        summaryResult.result.trim().isNotEmpty) {
      state = state.copyWith(
        webSummaryUiState: state.webSummaryUiState.copyWith(
          status: WebSummaryState.success,
          summaryText: summaryResult.result,
          errorMessage: null,
        ),
        errorMessage: null,
      );
    } else {
      state = state.copyWith(
        webSummaryUiState: state.webSummaryUiState.copyWith(
          status: WebSummaryState.failed,
          summaryText: null,
          errorMessage: summaryResult.errorMsg ?? 'Failed to summarize',
        ),
        errorMessage: summaryResult.errorMsg ?? "Failed",
      );
    }
  }

  void resetSummaryState() {
    state = state.copyWith(
      webSummaryUiState: state.webSummaryUiState.copyWith(
        status: WebSummaryState.idle,
        summaryText: null,
      ),
    );
  }
}
