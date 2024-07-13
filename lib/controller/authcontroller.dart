import 'package:flutter/material.dart';
import 'package:korobori/models/account.dart';
import 'package:korobori/models/school.dart';
import 'package:korobori/models/scout.dart';
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
    return await getAccount(authResponse.user!.id);
  }

  Future<Account> getAccount(String userID) async {
    var dataRAW = await _supabase.from('accounts').select('*').eq('id', userID);
    var data = dataRAW[0];

    var scoutInfo = await _supabase
        .from('scouts')
        .select('*')
        .eq('scouty_id', data['scouty_id'])
        .single();

    var scout = Scout(
        scoutyID: data['scouty_id'],
        noKeahlian: scoutInfo['no_keahlian'],
        gender: scoutInfo['gender'],
        religion: scoutInfo['religion'],
        parentName: scoutInfo['parent_name'],
        parentPhoneNo: scoutInfo['parent_phone_no'],
        profileImageURL: 'none',
        displayName: 'none',
        age: scoutInfo['age']);

    var schoolInfo = await _supabase
        .from('schools')
        .select('*')
        .eq('school_code', data['school_code'])
        .single();

    var school = School(
        schoolCode: data['school_code'],
        schoolName: schoolInfo['school_name'],
        noKumpulan: schoolInfo['no_kumpulan'],
        schoolDaerah: schoolInfo['school_daerah']);
    print(data['user_roles']);
    return Account(
        accountID: userID,
        scoutyID: data['scouty_id'],
        schoolCode: data['school_code'],
        subcamp: data['subcamp'],
        userFullname: data['fullname'],
        icNo: data['ic_no'],
        sijilApproved: data['approve_sijil'],
        scout: scout,
        school: school,
        role: data['user_roles']);
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
          role: row['user_roles'] == 'authenticated'
              ? 'PKK'
              : row['user_roles'] == 'pemimpin'
                  ? 'URUSETIA'
                  : 'PEMIMPIN',
          sijilApproved: row['approve_sijil']));
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
        .select('fullname, scouty_id, subcamp')
        .eq('id', accountID)
        .single();
    print(data);
    account = Account(
        accountID: accountID,
        scoutyID: data['scouty_id'],
        schoolCode: '',
        subcamp: data['subcamp'],
        userFullname: data['fullname'],
        icNo: '',
        role: '',
        sijilApproved: false);

    return account;
  }
}
