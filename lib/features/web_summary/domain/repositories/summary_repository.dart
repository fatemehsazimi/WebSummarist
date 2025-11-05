import 'dart:math';
import '../entities/summary_entity.dart';

class WebSummaryRepository {
  Future<SummaryResult> summarizeUrl(String url) async {
    await Future.delayed(const Duration(seconds: 3));
    Random random = Random();
    int randomNumber = random.nextInt(100);

    if (randomNumber < 50) {
      return SummaryResult(result: "this is your response", resultState: true);
    } else {
      return SummaryResult(
        result: "response has failed",
        resultState: false,
        errorMsg: "please try again",
      );
    }
  }
}
