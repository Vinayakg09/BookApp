import 'package:book_app/View/loginPage/page/loginPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<OnLogin>((event, emit) async {
      emit(AuthLoading());
      try {
        final email = event.email;
        if (email.isEmpty) {
          return emit(AuthFailure(error: "Please enter email"));
        }
        if (email.isNotEmpty) {
          await supabase.auth.signInWithOtp(
            email: email,
          );
          return emit(AuthGetOtp(email: email));
        }
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });
    on<OnLogout>((event, emit) async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove("userEmail");
        emit(AuthLogout());
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });
  }
}
