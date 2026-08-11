import '../../data/model/user_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserModel userModel;
  ProfileSuccess({required this.userModel});
}

class ProfileFailure extends ProfileState {
  final String error;
  ProfileFailure({required this.error});
}

class ProfileSignOutLoading extends ProfileState {}

class ProfileSignOutSuccess extends ProfileState {}

class ProfileSignOutFailure extends ProfileState {
  final String error;
  ProfileSignOutFailure({required this.error});
}
