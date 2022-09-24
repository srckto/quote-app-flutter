import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:quote/core/error/exceptions.dart';
import 'package:quote/core/utils/app_strings.dart';

import 'package:quote/features/random_quote/data/models/quote_model.dart';

abstract class RandomQuoteLocalDataSource {
  Future<QuoteModel> getLastRandomQuote();
  Future<void> cacheRandomQuote(QuoteModel quote);
}

class RandomQuoteLocalDataSourceImpl implements RandomQuoteLocalDataSource {
  GetStorage getStorage;
  RandomQuoteLocalDataSourceImpl({
    required this.getStorage,
  });
  @override
  Future<void> cacheRandomQuote(QuoteModel quote) async {
    return await getStorage.write(AppStrings.cacheRandomQuote, jsonEncode(quote.toMap()));
  }

  @override
  Future<QuoteModel> getLastRandomQuote() async {
    String? jsonString = getStorage.read(AppStrings.cacheRandomQuote);
    if (jsonString != null) {
      return QuoteModel.fromJson(jsonDecode(jsonString));
    } else {
      throw CacheException();
    }
  }
}
