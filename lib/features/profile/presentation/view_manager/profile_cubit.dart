import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  Future<void> getUserData() async {
    emit(ProfileLoading());
    final result = await profileRepo.getUserData();
    result.fold(
      (error) => emit(ProfileFailure(error: error)),
      (userModel) => emit(ProfileSuccess(userModel: userModel)),
    );
  }

  Future<void> signOut() async {
    emit(ProfileSignOutLoading());
    final result = await profileRepo.signOut();
    result.fold(
      (error) => emit(ProfileSignOutFailure(error: error)),
      (_) => emit(ProfileSignOutSuccess()),
    );
  }
}
