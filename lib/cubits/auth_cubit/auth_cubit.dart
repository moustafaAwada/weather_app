import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth_service.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthService _authService = AuthService();

  // Login Logic
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      UserModel user = await _authService.login(email: email, password: password);
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // Register Logic
  Future<void> register(String name, String email, String password, {String? phone}) async {
    emit(AuthLoading());
    try {
      UserModel user = await _authService.register(
        name: name, 
        email: email, 
        password: password,
        phone: phone
      );
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // Logout
  void logout() {
    emit(AuthInitial());
  }
  
  // Update User (If you have an endpoint for this)
  Future<void> updateUser(String name, String phone) async {
      // For now, we just update the local state. 
      // You should add an 'updateProfile' method to AuthService later.
      if (state is AuthAuthenticated) {
        final currentUser = (state as AuthAuthenticated).user;
        final updatedUser = UserModel(
            name: name,
            email: currentUser.email,
            password: currentUser.password, // Keep existing
            phone: phone
        );
        emit(AuthAuthenticated(user: updatedUser));
      }
  }
}