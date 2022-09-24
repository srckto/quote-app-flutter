import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote/core/utils/constants.dart';
import 'package:quote/core/widgets/custom_error_widget.dart';
import 'package:quote/features/quotes/presentation/cubit/quotes_cubit.dart';

class QuotesScreen extends StatefulWidget {
  QuotesScreen({Key? key}) : super(key: key);

  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<QuotesCubit>(context).getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<QuotesCubit, QuotesState>(
        builder: (context, state) {
          if (state is QuotesIsLoading) {
            return Constants.loading();
          }
          if (state is QuotesError) {
            return CustomErrorWidget(
              message: state.message,
            );
          }
          if (state is QuotesIsLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemCount: state.quotes.length,
                physics: BouncingScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.quotes[index].content,
                          style: theme.headline1!.copyWith(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          state.quotes[index].author,
                          style: theme.headline1!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return Constants.loading();
        },
      ),
    );
  }
}
