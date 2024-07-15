import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrmenu/models/user_model/user_model.dart';
import 'package:qrmenu/repositories/user_repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<RegisterUser>(_onRegisterUser);
    on<LoginUser>(_onLoginUser);
  }

  void _onRegisterUser(RegisterUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await userRepository.registerUser(event.user);
      emit(UserRegistered());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void _onLoginUser(LoginUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await userRepository.loginUser(event.user);
      emit(UserLoggedIn());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}