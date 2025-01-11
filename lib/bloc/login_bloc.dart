import 'dart:async';

import 'package:authentication/bloc/validators.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc with Validators{
  final _loginEmail = BehaviorSubject<String>();
  final _loginPassword = BehaviorSubject<String>();

  // Getters
  Stream<String> get loginEmail => _loginEmail.stream.transform(emailHandler);
  Stream<String> get loginPassword => _loginPassword.stream.transform(passwordHandler);

  // Setters
  Function(String) get changeLoginEmail => _loginEmail.sink.add;
  Function(String) get changeLoginPassword => _loginPassword.sink.add;

  

  void dispose() {
    _loginEmail.close();
    _loginPassword.close();
  }
}
