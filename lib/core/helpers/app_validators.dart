class AppValidators {
  AppValidators._();

  static String? required(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    return null;
  }

  static String? name(String? value) {
    final requiredError = required(value, 'Name');

    if (requiredError != null) {
      return requiredError;
    }

    final valueWithoutSpaces = value!.trim();

    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(valueWithoutSpaces)) {
      return 'Name can only contain letters';
    }

    return null;
  }
}
