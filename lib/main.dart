import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stepper/bloc/home/bloc.dart';
import 'package:stepper/bloc/step/bloc.dart';
import 'package:stepper/screen/auth_screen/signup.dart';
import 'bloc/signup/bloc.dart';

import 'bloc/app/bloc.dart';
import 'firebase_options.dart';
import 'screen/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (Platform.isAndroid) {
    await Permission.activityRecognition.request().isGranted;
  } else if (Platform.isIOS) {
    await Permission.sensors.request().isGranted;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(create: (context) => AppBloc()),
        BlocProvider<SignUpBloc>(create: (context) => SignUpBloc()),
        BlocProvider<StepCountBloc>(create: (context) => StepCountBloc()),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state.status == "authenticated") {
            return MaterialApp(
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const HomePage(),
            );
          } else {
            return MaterialApp(
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const SignUpForm(),
            );
          }
        },
      ),
    );
  }
}
