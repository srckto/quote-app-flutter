import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote/config/locale/app_localizations_setup.dart';
import 'package:quote/config/themes/app_theme.dart';
import 'package:quote/core/utils/app_strings.dart';
import 'package:quote/features/quotes/presentation/cubit/quotes_cubit.dart';
import 'package:quote/features/quotes/presentation/screens/quotes_screen.dart';
import 'package:quote/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:quote/features/random_quote/presentation/screens/random_quote_screen.dart';
import 'package:quote/features/splash/presentation/cubit/local_cubit.dart';
import 'package:quote/features/splash/presentation/screens/splash_screen.dart';
import 'injection_container.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RandomQuoteCubit>(
          create: (BuildContext context) => di.sl<RandomQuoteCubit>(),
          child: RandomQuoteScreen(),
        ),
        BlocProvider<LocalCubit>(
          create: (BuildContext context) => di.sl<LocalCubit>(),
          // child: SplashScreen(),
        ),
        BlocProvider<QuotesCubit>(
          create: (BuildContext context) => di.sl<QuotesCubit>(),
          child: QuotesScreen(),
        ),
      ],
      child: BlocBuilder<LocalCubit, LocalState>(
        buildWhen: (previousState, currentStat) {
          return previousState != currentStat;
        },
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: appTheme(),
          home: const SplashScreen(),
          locale: state.locale,
          supportedLocales: AppLocalizationsSetup.supportedLocales,
          localeResolutionCallback: AppLocalizationsSetup.localeResolutionCallback,
          localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
        ),
      ),
    );
  }
}
