import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:quote/core/error/exceptions.dart';
import 'package:quote/core/utils/app_strings.dart';

import 'package:quote/features/random_quote/data/models/quote_model.dart';

abstract class QuotesLocalDataSource {
  Future<List<QuoteModel>> getLastQuotes();
  Future<void> cacheQuotes(List<QuoteModel> quotes);
}

class QuotesLocalDataSourceImpl implements QuotesLocalDataSource {
  GetStorage getStorage;
  QuotesLocalDataSourceImpl({
    required this.getStorage,
  });
  @override
  Future<void> cacheQuotes(List<QuoteModel> quotes) async {
    var quotesMapping = quotes.map((e) => e.toMap()).toList();
    var quotesToJson = jsonEncode(quotesMapping);
    return await getStorage.write(AppStrings.cacheQuotes, quotesToJson);
  }

  @override
  Future<List<QuoteModel>> getLastQuotes() async {
    String? jsonString = getStorage.read(AppStrings.cacheQuotes);
    if (jsonString != null) {
      var quotesToList = jsonDecode(jsonString) as List;
      return await quotesToList.map((e) => QuoteModel.fromJson(e)).toList();
    } else {
      throw CacheException();
    }
  }
}
