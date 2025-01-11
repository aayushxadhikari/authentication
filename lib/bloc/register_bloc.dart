import 'package:authentication/bloc/validators.dart';
import 'package:rxdart/subjects.dart';

class RegisterBloc with Validators{
  final _registerFullName = BehaviorSubject<String>();
  final _registerEmail = BehaviorSubject<String>();
  final _registerPassword = BehaviorSubject<String>();
  final _registerConfirmPassword = BehaviorSubject<String>();


  // Getters
  Stream<String> get registerFullName => _registerFullName.stream.transform(nameHandler);
  Stream<String> get registerEmail => _registerEmail.stream.transform(emailHandler);
  Stream<String> get registerPassword => _registerPassword.stream.transform(passwordHandler);
  Stream<String> get registerConfirmPassword => _registerConfirmPassword.stream.transform(passwordHandler);

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
