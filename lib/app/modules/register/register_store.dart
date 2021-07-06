import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStoreBase with _$RegisterStore;
abstract class _RegisterStoreBase with Store {

  FirebaseAuth _firebaseAuth;
  _RegisterStoreBase(this._firebaseAuth);

  @observable
  User? user;

  @observable
  bool loading = false;

  @action
  Future<void> registerUser({required String name, required String email, required String password}) async {
    loading = true;
    final credential = await _firebaseAuth.createUserWwithEmailAndPassword(email: email, password: password);
    _firebaseAuth.signInWith
  }
}