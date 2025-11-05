import '../../features/web_summary/domain/enums/url_validation_state.dart';

class ErrorMessageMapper {
  static String? mapKey(UrlValidationState state) {
    switch (state) {
      case UrlValidationState.empty:
        return 'error_empty_url';
      case UrlValidationState.invalidFormat:
        return 'error_invalid_url';
      default:
        return null;
    }
  }
}
