import 'package:authentication/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with Validators {
  // StreamControllers for each input field
  final _registerFullName = BehaviorSubject<String>();
  final _registerEmail = BehaviorSubject<String>();
  final _registerPassword = BehaviorSubject<String>();
  final _registerConfirmPassword = BehaviorSubject<String>();

  // Getters for streams
  Stream<String> get registerFullName =>
      _registerFullName.stream.transform(nameHandler);

  Stream<String> get registerEmail =>
      _registerEmail.stream.transform(emailHandler);

  Stream<String> get registerPassword =>
      _registerPassword.stream.transform(passwordHandler);

  Stream<String> get registerConfirmPassword =>
      _registerConfirmPassword.stream.transform(passwordHandler);

  // Stream to check if the form is valid
  Stream<bool> get isFormValid => Rx.combineLatest4(
        registerFullName,
        registerEmail,
        registerPassword,
        registerConfirmPassword,
        (fullName, email, password, confirmPassword) {
          return fullName.isNotEmpty &&
              email.isNotEmpty &&
              email.contains('@') &&
              password.isNotEmpty &&
              password.length >= 8 &&
              password == confirmPassword; // Ensure passwords match
        },
      );

  // Stream to check if passwords match
  Stream<bool> get isPasswordMatched => Rx.combineLatest2(
        registerPassword,
        registerConfirmPassword,
        (password, confirmPassword) => password == confirmPassword,
      );

  // Getters for current values
  String get fullName => _registerFullName.valueOrNull ?? '';
  String get email => _registerEmail.valueOrNull ?? '';
  String get password => _registerPassword.valueOrNull ?? '';
  String get confirmPassword => _registerConfirmPassword.valueOrNull ?? '';

  // Setters for updating values
  Function(String) get changeFullName => _registerFullName.sink.add;
  Function(String) get changeRegisterEmail => _registerEmail.sink.add;
  Function(String) get changeRegisterPassword => _registerPassword.sink.add;
  Function(String) get changeConfirmPassword => _registerConfirmPassword.sink.add;

  // Register method
  void register(String email, String password) {
    // Perform registration logic here
    // For example, call an API to register the user
    print('Registering user with email: $email and password: $password');
    // You can add your API call or other logic here
  }

  // Dispose method to close all streams
  void dispose() {
    _registerFullName.close();
    _registerEmail.close();
    _registerPassword.close();
    _registerConfirmPassword.close();
  }
}