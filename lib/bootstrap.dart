import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/app.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/firebase_options.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<Object?> bloc, Change<Object?> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<Object?> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> prepareApp({Environment mode = prod}) async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  //if (mode == prod) {
  await Firebase.initializeApp(name: 'lalala', options: DefaultFirebaseOptions.currentPlatform);
  //}

  //Bloc.observer = const AppBlocObserver();

  await configureDependencies(mode);

  await getIt<AuthenticationService>().init();
}

Future<void> bootstrap({Environment mode = prod}) async {
  WidgetsFlutterBinding.ensureInitialized();

  await prepareApp(mode: mode);

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runApp(App());
}
