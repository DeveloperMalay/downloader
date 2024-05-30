import 'package:bot_toast/bot_toast.dart';
import 'package:downloader/presentation/screens/home_screen/cubit/download_cubit.dart';
import 'package:downloader/presentation/screens/home_screen_v2/dx_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final botToastBuilder = BotToastInit();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Downloader',
      debugShowCheckedModeBanner: false,
      theme: DxLightScheme().theme,
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
