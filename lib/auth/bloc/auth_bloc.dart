import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:language_partner/auth/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepo repo;

  AuthBloc(this.repo) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
