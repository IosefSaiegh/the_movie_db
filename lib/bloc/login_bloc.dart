import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:the_movie_db/bloc/validators.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _userNameController = BehaviorSubject<String>();

  //recuperar datos de stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);
  Stream<String> get userNameStream => _userNameController.stream;

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);
  //INSERTAR VALORES A STREAM
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeUserName => _userNameController.sink.add;
  //Obtener el ulitmo valor ingresado

  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get userName => _userNameController.value;
  dipose() {
    _emailController.close();
    _passwordController.close();
    _userNameController.close();
  }
}
