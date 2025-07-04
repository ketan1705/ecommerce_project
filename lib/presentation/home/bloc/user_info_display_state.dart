import '../../../domain/auth/entity/user.dart';

abstract class UserInfoDisplayState {}

class UserInfoLoading extends UserInfoDisplayState {}

class UserInfoLoaded extends UserInfoDisplayState {
  final UserEntity user;

  UserInfoLoaded({required this.user});
}

class UserInfoFailure extends UserInfoDisplayState {}
