bool isEmail(String? em) {
  String? p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em!);
}

String? validateInput(String? value) {
  if (value!.isEmpty) return 'Enter Valid input';
}

String? validatePhone(String? value) {
  if (value!.isEmpty) {
    return 'Enter Valid input';
  } else if (value.length < 8) {
    return 'Please enter valid phone number';
  } else
    return null;
}

String? IdNum(String? value) {
  if (value!.isEmpty) {
    return 'Enter Valid input';
  } else if (value.length < 11) {
    return 'Please enter valid Identity number';
  } else
    return null;
}

String? validatePassword(String? value) {
  if (value!.isEmpty) {
    return 'Password is required.';
  } else if (value.length < 6) {
    return 'Password should not be less than 6 digits.';
  }
  return null;
}

String? validateDate(String? value) {
  if (value!.isEmpty) return null;
  return null;
}
