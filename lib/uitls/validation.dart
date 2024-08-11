String? validateEmail(String email) {
  if (email.isEmpty) {
    return 'Email is required';
  }
  if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
    return 'Please enter a valid email';
  }
  return null;
}

validatePassword(password) {
  if (password.isEmpty) {
    return 'Password is required';
  }
  if (password.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}

validateRepeatPassword(password, repeatPassword) {
  if (repeatPassword.isEmpty) {
    return 'Repeat password is required';
  }
  if (password != repeatPassword) {
    return 'Passwords do not match';
  }
  return null;
}

String? validateTitle(title) {
  if (title.isEmpty) {
    return 'Title is required';
  }

  return null;
}

String? validateDescription(description) {
  return null;
}
