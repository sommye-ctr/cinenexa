extension FormFieldExt on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    if (this.length > 3) {
      return true;
    }
    return false;
  }

  bool get isValidPassword {
    return this.length >= 8;
  }
}
