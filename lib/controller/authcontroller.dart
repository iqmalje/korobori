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
    var dataRAW = await _supabase
        .from('accounts')
        .select('*')
        .eq('id', authResponse.user!.id);

    var data = dataRAW[0];

    return Account(
        accountID: authResponse.user!.id,
        scoutyID: data['scouty_id'],
        schoolCode: data['school_code'],
        subcamp: data['subcamp'],
        userFullname: data['fullname'],
        icNo: icNo,
        role: authResponse.user!.role!);
  }

  Future<List<Account>> getAllAccounts({String? subcamp}) async {
    List<Account> accounts = [];

    List<Map<String, dynamic>> data;
    if (subcamp == null) {
      data = await _supabase.from('accounts').select('*');
    } else {
      print(subcamp);
      data =
          await _supabase.from('accounts').select('*').eq('subcamp', subcamp);
    }

    for (var row in data) {
      accounts.add(Account(
          accountID: row['id'],
          scoutyID: row['scouty_id'],
          schoolCode: row['school_code'],
          subcamp: row['subcamp'],
          userFullname: row['fullname'],
          icNo: row['ic_no'],
          role: row['user_roles']));
    }
    return accounts;
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
