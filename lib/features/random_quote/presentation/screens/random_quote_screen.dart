import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote/config/locale/app_localizations.dart';
import 'package:quote/core/utils/app_strings.dart';
import 'package:quote/core/utils/constants.dart';
import 'package:quote/core/utils/media_query_values.dart';
import 'package:quote/core/widgets/custom_error_widget.dart';
import 'package:quote/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:quote/features/splash/presentation/cubit/local_cubit.dart';

class RandomQuoteScreen extends StatefulWidget {
  const RandomQuoteScreen({Key? key}) : super(key: key);

  @override
  State<RandomQuoteScreen> createState() => _RandomQuoteScreenState();
}

class _RandomQuoteScreenState extends State<RandomQuoteScreen> {
  @override
  void initState() {
    super.initState();
    _getRandomQuote();
  }

  _getRandomQuote() {
    BlocProvider.of<RandomQuoteCubit>(context).getRandomQuote();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.translate(AppStrings.appName) ?? "",
          style: theme.headline1?.copyWith(
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (AppLocalizations.of(context)?.isEnLocale ?? true) {
              BlocProvider.of<LocalCubit>(context).toArabic();
            } else {
              BlocProvider.of<LocalCubit>(context).toEnglish();
            }
          },
          icon: Icon(Icons.translate_outlined),
        ),
      ),
      body: Container(
        width: context.width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<RandomQuoteCubit, RandomQuoteState>(
          builder: (context, state) {
            if (state is RandomQuoteIsLoading) {
              return Center(child: Constants.loading());
            }

            if (state is RandomQuoteError) {
              return CustomErrorWidget(
                message: state.message,
                onPressed: () {
                  _getRandomQuote();
                },
              );
            }

            if (state is RandomQuoteIsLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.quote.content,
                          style: theme.headline1!.copyWith(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          state.quote.author,
                          style: theme.headline1!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: IconButton(
                      onPressed: () {
                        _getRandomQuote();
                      },
                      icon: const Icon(Icons.restart_alt_outlined),
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
