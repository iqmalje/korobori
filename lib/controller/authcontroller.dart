import 'package:flutter/material.dart';
import 'package:korobori/controller/localDBcontroller.dart';
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
    Account account = await getAccount(authResponse.user!.id);
    LocalDBController localDBController = await LocalDBController.initialize();
    print("--INSERTING ACCOUNT INTO LOCAL PHONE--");
    await localDBController.insertAccount(account);
    return account;
  }

  Future<Map<String, dynamic>> fetchUserRoleAndApprove(String userID) async {
    return (await _supabase
        .from('accounts')
        .select('user_roles, approve_sijil')
        .eq('id', userID)
        .limit(1))[0];
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
        noKeahlian: scoutInfo['no_keahlian'] ?? '-',
        gender: scoutInfo['gender'],
        religion: scoutInfo['religion'] ?? '-',
        parentName: scoutInfo['parent_name'] ?? '-',
        parentPhoneNo: scoutInfo['parent_phone_no'] ?? '-',
        profileImageURL: 'none',
        displayName: 'none',
        age: scoutInfo['age'] ?? 0);

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
    print("role = ${data['user_roles']}");
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

  Future<List<Account>> searchAccount(String search, {String? subcamp}) async {
    List<Account> searchResult = [];
    search = search.toLowerCase();
    List<Map<String, dynamic>> data;
    if (subcamp == null) {
      data = await _supabase
          .from('accounts')
          .select('id, fullname, scouty_id, user_roles, approve_sijil')
          .or('or(scouty_id.ilike.%$search%),or(fullname.ilike.%$search%)');
    } else {
      data = await _supabase
          .from('accounts')
          .select('id, fullname, scouty_id, user_roles, approve_sijil')
          .eq('subcamp', subcamp)
          .or('or(scouty_id.ilike.%$search%),or(fullname.ilike.%$search%)');
    }

    for (var row in data) {
      searchResult.add(Account(
          accountID: row['id'],
          scoutyID: row['scouty_id'],
          schoolCode: row['school_code'] ?? 'none',
          subcamp: row['subcamp'] ?? 'none',
          userFullname: row['fullname'],
          icNo: row['ic_no'] ?? 'none',
          role: row['user_roles'] == 'authenticated'
              ? 'PKK'
              : row['user_roles'] == 'pemimpin'
                  ? 'PEMIMPIN'
                  : row['user_roles'] == 'VIP'
                      ? 'VIP'
                      : 'URUSETIA',
          sijilApproved: row['approve_sijil']));
    }

    return searchResult;
  }

  Future<void> accountDeletion() async {
    var response = await _supabase.functions.invoke('delete-account',
        body: {'accountid': _supabase.auth.currentUser!.id});

    print(response.data);
  }

  Future<List<Account>> getAllAccounts(
      {String? subcamp, int start = 0, int end = 100}) async {
    List<Account> accounts = [];

    List<Map<String, dynamic>> data;
    if (subcamp == null) {
      data = await _supabase
          .from('accounts')
          .select('id, fullname, scouty_id, user_roles, approve_sijil')
          .range(start, end)
          .order('scouty_id', ascending: true);
      print(data.length);
    } else {
      print(subcamp);
      data = await _supabase
          .from('accounts')
          .select('id, fullname, scouty_id, user_roles, approve_sijil')
          .eq('subcamp', subcamp)
          .range(start, end)
          .order('scouty_id', ascending: true);
    }

    for (var row in data) {
      accounts.add(Account(
          accountID: row['id'],
          scoutyID: row['scouty_id'],
          schoolCode: row['school_code'] ?? 'none',
          subcamp: row['subcamp'] ?? 'none',
          userFullname: row['fullname'],
          icNo: row['ic_no'] ?? 'none',
          role: row['user_roles'] == 'authenticated'
              ? 'PKK'
              : row['user_roles'] == 'pemimpin'
                  ? 'PEMIMPIN'
                  : row['user_roles'] == 'VIP'
                      ? 'VIP'
                      : 'URUSETIA',
          sijilApproved: row['approve_sijil']));
    }
    return accounts;
  }

  Future<void> logout(BuildContext context) async {
    // set to null
    LocalDBController localDBController = await LocalDBController.initialize();
    print("--DELETING LOCAL DATA--");
    await localDBController.deleteAccount();
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
