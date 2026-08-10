
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService{
  static Future<void> init()async{
    Supabase.initialize(
        url: "https://ngfiggvpjrhkqkvlyrjq.supabase.co",
        publishableKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5nZmlnZ3ZwanJoa3Frdmx5cmpxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODYyODQ2MjMsImV4cCI6MjEwMTg2MDYyM30.yjcCLKPR3U5axyC2M8LYrCgll2iQ_kHTfKgmkymF24w"
    );
  }
}
