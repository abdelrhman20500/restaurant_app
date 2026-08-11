import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/user_model.dart';

class ProfileRepo {
  final supabase = Supabase.instance.client;

  Future<Either<String, UserModel>> getUserData() async {
    try {
      final currentUser = supabase.auth.currentUser;
      if (currentUser == null) {
        return left("User not logged in");
      }

      final response = await supabase
          .from("users")
          .select()
          .eq("id", currentUser.id)
          .single();

      return right(UserModel.fromJson(response));
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, void>> signOut() async {
    try {
      await supabase.auth.signOut();
      return right(null);
    } catch (e) {
      return left(e.toString());
    }
  }
}
