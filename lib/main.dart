import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/core.dart';
import 'presentation/presentation.dart';
import 'presentation/screens/home_screen_v2/cubit/download_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Downloader',
      debugShowCheckedModeBanner: false,
      theme: DxLightScheme().theme,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DownloadCubit(),
          ),
        ],
        child: const DxHomeScreen(),
      ),
    );
  }
}
