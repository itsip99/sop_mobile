class Validator {
  // Function to validate email
  static String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null; // No error
  }

  // Function to validate password
  static String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    } else if (value.length < 6) {
      return 'Username must be at least 6 characters long';
    } else if (!RegExp(r'^[A-Za-z]{2}\d{5}$').hasMatch(value)) {
      return 'Invalid username format.';
    }
    return null; // No error
  }

  // Function to validate password
  static String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null; // No error
  }
}
