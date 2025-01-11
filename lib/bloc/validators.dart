import 'dart:async';

mixin Validators {
  // Email Validators
  var emailHandler =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.isEmpty) {
      return sink.addError("This field can't be empty");
    }
    if (email.length > 35) {
      return sink.addError("Email can't be longer than 35 characters.");
    }
    if (email.length < 6) {
      return sink.addError("Email can't be less than 6 characters.");
    }
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(email)) {
      return sink.addError("Please enter a valid email address.");
    }else{
      sink.add(email);
    }
    
  });

  // Login Password Validators
  var passwordHandler =
      StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
    if (password.isEmpty) {
      return sink.addError("This field can't be empty");
    }
    if (password.length > 20) {
      return sink.addError("Password can't be longer than 20 characters.");
    }
    if (password.length < 8) {
      return sink.addError("Password must be at least 8 characters long.");
    }

    
    final passwordRegex = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$");
    if (!passwordRegex.hasMatch(password)) {
      return sink.addError(
        "Password must contain at least one letter, one number, and no invalid characters.");
    }

    
    sink.add(password);
  });

  // Name Validators
  var nameHandler =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.isEmpty) {
      return sink.addError("This field can't be empty");
    }
    if (name.length > 50) {
      return sink.addError("Name can't be longer than 50 characters.");
    }
    if (name.length < 2) {
      return sink.addError("Name must be at least 2 characters long.");
    }


    final nameRegex = RegExp(r"^[a-zA-Z\s]+$");
    if (!nameRegex.hasMatch(name)) {
      return sink.addError("Name can only contain letters and spaces.");
    }

    sink.add(name); 
  });
}
