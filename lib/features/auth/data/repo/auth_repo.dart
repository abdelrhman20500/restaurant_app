import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepo{
  SupabaseClient supabase = Supabase.instance.client;
  Future<Either<String, void>> signIn({required String email, required String password})async{
    try {
      final response = await supabase.auth.signInWithPassword(email: email ,password: password);
      return right(null);
    }on AuthException catch(e){
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }
  Future<Either<String, void>> signUp({required String name,
    required String email, required String password})async{
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
      await saveUserData(name: name, email: email);
      return right(null);
    }on AuthException catch(e){
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, void>> saveUserData({required String name, required email})async{
    try {
      final response = await supabase.from("users").insert({
        "id": supabase.auth.currentUser!.id,
        "name": name,
        "email":email,
      });
      return right(null);
    } on AuthException catch(e){
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }
}