import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class LoginOperation {
  Future<String> login(
      {@required String username, @required String password}) async {
    await Future.delayed(Duration(seconds: 1));
    return 'success';
  }
//  Future<Response> login(
//      {@required String username, @required String password}) async {
////    Response response = await post('http://10.0.2.2:8989/login',
////        body: JsonEncoder().convert({
////          'email': username,
////          'password': password,
////        }),
////        headers: {
////          'Content-Type': 'application/json',
////        });
//    return response;
//  }
}

/// Login Bloc need Login State && Login Event
abstract class LoginState {
  String toString();
}

class LoginInitial extends LoginState {
  @override
  String toString() => 'LoginInitial';
}

class LoginSuccess extends LoginState {
  @override
  String toString() => 'LoginSuccess';
}

class LoginLoading extends LoginState {
  @override
  String toString() => 'LoginLoading';
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({@required this.error});

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class LoginButtonPressEvent {
  final String username;
  final String password;
  LoginButtonPressEvent({@required this.username, @required this.password});
}

class VerifyEvent {
  final String token;
  VerifyEvent(this.token);
}

class TokenVerifyBloc extends Bloc<VerifyEvent, LoginState> {
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(VerifyEvent event) async* {
    if (event.token != null) {
      yield LoginSuccess();
    } else {
      yield LoginFailure(error: "Token 错误");
    }
  }
}

class LoginBloc extends Bloc<LoginButtonPressEvent, LoginState> {
  final LoginOperation loginOperation;
  final TokenVerifyBloc tokenVerifyBloc;
  LoginBloc({@required this.loginOperation, @required this.tokenVerifyBloc});

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginButtonPressEvent event) async* {
    yield LoginLoading();
    try {
      String response = await loginOperation.login(
          username: event.username, password: event.password);
      if (response != null) {
        tokenVerifyBloc.dispatch(VerifyEvent(null));
      } else {
        yield LoginFailure(error: "网络错误");
      }
    } catch (error) {
      yield LoginFailure(error: "网络错误");
    }
  }

  Stream<LoginState> generatorLoginState() async* {
    yield LoginSuccess();
  }
}
//
/////
/////
//class VerifyEvent {
//  Map<String, dynamic> responseData;
//}
//abstract class VerifyState {
//  String toString();
//}
//class VerifySuccess extends VerifyState {
//  @override
//  String toString() => "Success";
//}
//class VerifyFailure extends VerifyState {
//  final String error;
//
//  VerifyFailure({@required this.error});
//
//  @override
//  String toString() => 'LoginFailure { error: $error }';
//}
//
//class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
//  @override
//  // TODO: implement initialState
//  VerifyState get initialState => null;
//
//  @override
//  Stream<VerifyState> mapEventToState(VerifyState currentState, VerifyEvent event) {
//
//  }
//
//}
