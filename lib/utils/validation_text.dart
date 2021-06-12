const EMAIL_PATTERN = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@" +
    "[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})\$";

enum ValidateError {
  NULL,
  TEXT_FILED_BLANK,
  EMAIL_FORMAT_ERROR,
  PASSWORD_LENGTH_ERROR,
  PASSWORD_DO_NOT_MATCH
}

ValidateError validateEmail(String text) {
  final regex = RegExp(EMAIL_PATTERN);
  if (text.isEmpty) return ValidateError.TEXT_FILED_BLANK;
  if (!regex.hasMatch(text)) return ValidateError.EMAIL_FORMAT_ERROR;
  return ValidateError.NULL;
}

ValidateError validatePassword(String text) {
  if (text.isEmpty) return ValidateError.TEXT_FILED_BLANK;
  if (text.length < 6) return ValidateError.PASSWORD_LENGTH_ERROR;
  return ValidateError.NULL;
}

ValidateError validateConfirmPassword(String password, String confirmPassword) {
  if (password != confirmPassword) return ValidateError.PASSWORD_DO_NOT_MATCH;
  return ValidateError.NULL;
}
