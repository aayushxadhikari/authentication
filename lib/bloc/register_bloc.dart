import 'package:rxdart/subjects.dart';

class RegisterBloc {
  final _registerFullName = BehaviorSubject<String>();
  final _registerEmail = BehaviorSubject<String>();
  final _registerPassword = BehaviorSubject<String>();
  final _registerConfirmPassword = BehaviorSubject<String>();


  // Getters
  Stream<String> get registerFullName => _registerFullName.stream;
  Stream<String> get registerEmail => _registerEmail.stream;
  Stream<String> get registerPassword => _registerPassword.stream;
  Stream<String> get registerConfirmPassword => _registerConfirmPassword.stream;

  // Setters

  Function(String) get changeFullName => _registerFullName.sink.add;
  Function(String) get changeRegisterEmail => _registerEmail.sink.add;
  Function(String) get changeRegisterPassword => _registerPassword.sink.add;
  Function(String) get changeConfirmPassword => _registerConfirmPassword.sink.add;

  void dispose() {
    _registerFullName.close();
    _registerEmail.close();
    _registerPassword.close();
    _registerConfirmPassword.close();
  }
}
