import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/auth_repo.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit(this.authRepo): super(AuthInitial());
  final AuthRepo authRepo;
  Future<void> signIn({required String email, required String password})async{
    emit(LoginLoading());
    final response = await authRepo.signIn(email: email, password: password);
    response.fold((e){
      emit(LoginFailure(error: e.toString()));
    },(success){
      emit(LoginSuccess());
    });
  }

  Future<void> signUp({required String name, required String email, required String password})async{
    emit(SignUpLoading());
    final response = await authRepo.signUp(name: name, email: email, password: password);
    response.fold((e){
      emit(SignUpFailure(error: e.toString()));
    },(success){
      emit(SignUpSuccess());
    });
  }

}