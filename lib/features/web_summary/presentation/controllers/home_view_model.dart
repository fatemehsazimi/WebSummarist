import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/enums/url_validation_state.dart';
import '../../domain/enums/web_summary_state.dart';
import '../../presentation/controllers/url_ui_state.dart';
import '../../presentation/controllers/providers.dart';
import '../../../../core/errors/error_message_mapper.dart';

class HomeViewModel extends StateNotifier<UrlUiState> {
  final Ref ref;

  HomeViewModel(this.ref) : super(UrlUiState.initial());

  void setUrl(String newUrl) async {
    final validationState = _validateUrl(newUrl);

    if (validationState != UrlValidationState.valid) {
      state = state.copyWith(
        validationState: validationState,
        errorMessage: ErrorMessageMapper.mapKey(validationState),
        showDialog: true,
      );
      return;
    }
    state = state.copyWith(
      validationState: UrlValidationState.valid,
      webSummaryUiState: state.webSummaryUiState.copyWith(
        status: WebSummaryState.loading,
        url: newUrl,
      ),
      showDialog: false,
    );

    final useCase = ref.read(summarizeUrlUseCaseProvider);
    final result = await useCase.execute(newUrl);
    if (result.resultState) {
      updateSummarySuccess(msg: result.result);
    } else {
      updateSummaryFailed(error: result.result);
    }
  }

  UrlValidationState _validateUrl(String url) {
    if (url.isEmpty) return UrlValidationState.empty;
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.isAbsolute) return UrlValidationState.invalidFormat;
    return UrlValidationState.valid;
  }

  void updateSummarySuccess({required String msg}) {
    final currentUrl = state.webSummaryUiState.url;
    if (currentUrl != null && currentUrl.isNotEmpty) {
      ref.read(urlListProvider.notifier).addUrl(currentUrl);
    }
    state = state.copyWith(
      webSummaryUiState: state.webSummaryUiState.copyWith(
        status: WebSummaryState.success,
        summaryText: msg,
      ),
    );
  }

  void updateSummaryFailed({required String error}) {
    state = state.copyWith(
      webSummaryUiState: state.webSummaryUiState.copyWith(
        status: WebSummaryState.failed,
        errorMessage: error,
      ),
    );
  }

  void resetSummaryState() {
    state = state.copyWith(
      showDialog: false,
      webSummaryUiState: state.webSummaryUiState.copyWith(
        status: WebSummaryState.idle,
      ),
    );
  }
}
