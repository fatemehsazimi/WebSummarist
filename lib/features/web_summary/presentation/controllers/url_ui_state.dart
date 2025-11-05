import 'package:web_summarist/features/web_summary/presentation/controllers/web_summary_state.dart';
import '../../domain/enums/url_validation_state.dart';

class UrlUiState {
  final UrlValidationState validationState;
  final String? errorMessage;
  final bool showDialog;
  final WebSummaryUiState webSummaryUiState;

  UrlUiState({
    required this.validationState,
    this.errorMessage,
    this.showDialog = false,
    required this.webSummaryUiState,
  });

  UrlUiState copyWith({
    UrlValidationState? validationState,
    String? errorMessage,
    bool? showDialog,
    WebSummaryUiState? webSummaryUiState,
  }) {
    return UrlUiState(
      validationState: validationState ?? this.validationState,
      errorMessage: errorMessage ?? this.errorMessage,
      showDialog: showDialog ?? this.showDialog,
      webSummaryUiState: webSummaryUiState ?? this.webSummaryUiState,
    );
  }

  factory UrlUiState.initial() {
    return UrlUiState(
      validationState: UrlValidationState.empty,
      webSummaryUiState: WebSummaryUiState.initial(),
    );
  }
}
