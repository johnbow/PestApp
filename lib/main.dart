import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/cubit/game_cubit.dart';
import 'package:pest/pages/one_dice_page.dart';
import 'package:pest/repositories/dice_repository.dart';
import 'package:pest/repositories/random_dice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: RepositoryProvider<DiceRepository>(
          create: (context) => RandomDice(sides: 6),
          child: BlocProvider(
            create: (context) =>
                GameCubit(diceRepo: context.read<DiceRepository>()),
            child: const OneDicePage(),
          ),
        ));
  }
}
