import 'package:flutter/cupertino.dart';
import 'package:korobori/models/account.dart';

class AccountProvider extends ChangeNotifier {
  Account? account;

  void setAccount({required Account? newAccount}) async {
    account = newAccount;
    print(account == null);
    notifyListeners();
  }

  Account? getAccount() {
    return account;
  }

  void removeAccount() {
    account = null;
  }
}
