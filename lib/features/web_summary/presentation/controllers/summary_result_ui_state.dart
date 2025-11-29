class SummaryResultUiState {
  final String url;
  final String summary;

  SummaryResultUiState({
    required this.url,
    required this.summary,
  });

  factory SummaryResultUiState.initial() {
    return SummaryResultUiState(
      url: '',
      summary: '',
    );
  }

  SummaryResultUiState copyWith({
    String? url,
    String? summary,
  }) {
    return SummaryResultUiState(
      url: url ?? this.url,
      summary: summary ?? this.summary,
    );
  }
}
