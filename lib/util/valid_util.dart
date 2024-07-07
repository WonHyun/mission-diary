class FormValidator {
  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) return "Enter your name.";
    return null;
  }

  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) return "Enter your email.";
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(email)) {
      return "Not valid email.";
    }
    return null;
  }

  static String? birthDateValidator(String? date) {
    if (date == null || date.isEmpty) return "Enter your birthday.";
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) return "Enter your password";
    if (password.length < 8) return "Password is at least over 8";
    return null;
  }
}
