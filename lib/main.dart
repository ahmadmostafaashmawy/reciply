import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reciply/presentation/bloc/lang/lang_bloc.dart';
import 'package:reciply/presentation/bloc/lang/lang_state.dart';
import 'package:reciply/presentation/widgets/loading.dart';
import 'package:reciply/routes.dart';
import 'package:reciply/utils/app_localizations.dart';

import 'data/repository/lang_reposirory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static String lang = LanguageCubit.english;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late LanguageCubit _langCubit;
  LanguageRepository languageRepository = LanguageRepository();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.landscapeRight,
      // DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _langCubit = LanguageCubit(languageRepository);
    _langCubit.getLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext blocContext) => _langCubit,
      child:
          BlocBuilder<LanguageCubit, LanguageState>(builder: (context, state) {
        if (state is LanguageChanged) {
          return ScreenUtilInit(
              designSize: const Size(360, 690),
              builder: () {
                AppRouter appRouter = AppRouter();
                return MaterialApp(
                  theme: ThemeData(primarySwatch: Colors.orange),
                  debugShowCheckedModeBanner: false,
                  onGenerateRoute: appRouter.generateRoute,
                  supportedLocales: const [
                    Locale('ar', 'EG'),
                    Locale('en', 'US'),
                  ],
                  locale: Locale(MyApp.lang),
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    DefaultCupertinoLocalizations.delegate
                  ],
                );
              });
        } else {
          return LoadingWidget();
        }
      }),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}
