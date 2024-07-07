import 'package:flutter/material.dart';
import 'package:korobori/models/account.dart';
import 'package:korobori/providers/accountprovider.dart';
import 'package:korobori/urusetia/views/authentication/login.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController {
  final _supabase = Supabase.instance.client;

  Future<Account?> logIn(String icNo, String password) async {
    AuthResponse authResponse = await _supabase.auth.signInWithPassword(
        password: "KOROBORI$password", email: "$icNo@nonexistent.com");
    if (authResponse.user == null) {
      return null;
    }
    // fetch account details

    var data = await _supabase.from('accounts').select('*').single();

    return Account(
        accountID: authResponse.user!.id,
        scoutyID: data['scouty_id'],
        schoolCode: data['school_code'],
        subcamp: data['subcamp'],
        userFullname: data['fullname'],
        icNo: icNo,
        role: authResponse.user!.role!);
  }

  Future<void> logout(BuildContext context) async {
    // set to null
    context.read<AccountProvider>().removeAccount();
    await _supabase.auth.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (_) => false);
  }

  Future<Account> findAccount(String accountID) async {
    Account account;
    var data = await _supabase
        .from('accounts')
        .select('fullname, scouty_id')
        .eq('id', accountID)
        .single();

    account = Account(
        accountID: accountID,
        scoutyID: data['scouty_id'],
        schoolCode: '',
        subcamp: '',
        userFullname: data['fullname'],
        icNo: '',
        role: '');

    return account;
  }
}
