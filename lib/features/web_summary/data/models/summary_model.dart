class SummaryModel {
  final String summaryText;

  SummaryModel({ required this.summaryText});

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    return SummaryModel(
      summaryText: json['summary_text'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'summary_text': summaryText,
    };
  }
}
