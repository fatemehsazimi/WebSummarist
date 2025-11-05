import '../../domain/enums/web_summary_state.dart';

class WebSummaryUiState {
  final WebSummaryState status;
  final String? errorMessage;
  final bool showDialog;
  final String? url;
  final String? summaryText;

  WebSummaryUiState({
    required this.status,
    this.errorMessage,
    this.showDialog = false,
    this.url,
    this.summaryText,
  });

  WebSummaryUiState copyWith({
    WebSummaryState? status,
    String? errorMessage,
    bool? showDialog,
    String? url,
    String? summaryText,
  }) {
    return WebSummaryUiState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      showDialog: showDialog ?? this.showDialog,
      url: url ?? this.url,
      summaryText: summaryText ?? this.summaryText,
    );
  }

  factory WebSummaryUiState.initial() {
    return WebSummaryUiState(
      status: WebSummaryState.idle,
      errorMessage: null,
      showDialog: false,
      summaryText: null,
    );
  }
}
