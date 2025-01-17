import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/bridges/dice_animation_bridge.dart';
import 'package:pest/bridges/game_animation_bridge.dart';
import 'package:pest/bridges/game_dice_bridge.dart';
import 'package:pest/constants/themes.dart';
import 'package:pest/cubit/dice_animation_cubit.dart';
import 'package:pest/cubit/dice_cubit.dart';
import 'package:pest/cubit/game_cubit.dart';
import 'package:pest/cubit/settings_cubit.dart';
import 'package:pest/pages/main_page.dart';
import 'package:pest/repositories/dice_repository.dart';
import 'package:pest/repositories/image_repository.dart';
import 'package:pest/repositories/random_dice.dart';
import 'package:pest/repositories/settings_repository.dart';
import 'package:pest/utils/bloc_bridge.dart';

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
          colorScheme: colorScheme,
          textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 18)),
          useMaterial3: true,
        ),
        home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<DiceRepository>(
              create: (context) => RandomDice(
                  sides: 6, firstInitial: [6], secondInitial: [6, 6]),
            ),
            RepositoryProvider(
              lazy: false,
              create: (context) => DiceImageRepository(sides: 6),
            ),
            RepositoryProvider(
              lazy: false,
              create: (context) => Settings(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => GameCubit(context.read<Settings>()),
              ),
              BlocProvider(
                create: (context) => DiceAnimationCubit(
                    diceRepo: context.read<DiceRepository>(),
                    settings: context.read<Settings>()),
              ),
              BlocProvider(
                create: (context) => DiceCubit(
                    diceRepo: context.read<DiceRepository>(),
                    settings: context.read<Settings>()),
              ),
              BlocProvider(
                create: (context) => SettingsCubit(context.read<Settings>()),
              ),
            ],
            child: BlocCommunicator(
              bridges: [
                DiceAnimationBridge(),
                GameDiceBridge(),
                GameAnimationBridge()
              ],
              child: const MainPage(),
            ),
          ),
        ));
  }
}
