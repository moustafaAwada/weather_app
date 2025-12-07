import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_model.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // Mock database for demo purposes
  UserModel? _currentUser;

  void login(String email, String password) async {
    emit(AuthLoading());
    await Future.delayed(Duration(seconds: 1)); // Simulate API call
    
    // Simple mock validation
    if (email.isNotEmpty && password.length >= 6) {
      _currentUser = UserModel(name: "User", email: email, password: password);
      emit(AuthAuthenticated(_currentUser!));
    } else {
      emit(AuthError("Invalid email or password"));
    }
  }

  void register(String name, String email, String password) async {
    emit(AuthLoading());
    await Future.delayed(Duration(seconds: 1));
    _currentUser = UserModel(name: name, email: email, password: password);
    emit(AuthAuthenticated(_currentUser!));
  }

  void logout() {
    _currentUser = null;
    emit(AuthUnauthenticated());
  }

  void updateUser(String name, String phone) {
    if (_currentUser != null) {
      _currentUser!.name = name;
      _currentUser!.phone = phone;
      emit(AuthAuthenticated(_currentUser!)); // Emit new state to update UI
    }
  }
}