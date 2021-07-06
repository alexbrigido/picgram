import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:picgram/app/constants.dart';
import 'package:picgram/app/modules/onboarding/onboarding_module.dart';
import 'package:picgram/app/modules/register/register_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {

  SharedPreferences _sharedPreferences;
  FirebaseApp _firebaseApp;
  AppModule(this._sharedPreferences, this._firebaseApp);

  @override
  List<Bind> get binds => [
    Bind.singleton((i) => _sharedPreferences),
    Bind.instance(_firebaseApp),
    Bind.factory((i) => FirebaseAuth.instance),
    Bind.factory((i) => FirebaseFirestore.instance),
    Bind.factory((i) => FirebaseStorage.instance),
  ];

  @override
  List<ModularRoute> get routes => [
    ModuleRoute(Modular.initialRoute, module: _initialModule()),
    ModuleRoute(Constants.Routes.ONBOARDING, module: OnboardingModule()),
    ModuleRoute(Constants.Routes.REGISTER, module: RegisterModule()),
  ];

  Module _initialModule() {
    final onboardingDone = _sharedPreferences.getBool(Constants.SPK_ONBOARDING_DONE) ?? false;
    if(onboardingDone){
      return RegisterModule();
    } else {
      return OnboardingModule();
    }
  }
}