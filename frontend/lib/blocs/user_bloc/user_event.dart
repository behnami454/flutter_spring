part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends UserEvent {
  final AppUser user;

  const RegisterUser(this.user);

  @override
  List<Object> get props => [user];
}

class LoginUser extends UserEvent {
  final AppUser user;

  const LoginUser(this.user);

  @override
  List<Object> get props => [user];
}