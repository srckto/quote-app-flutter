
import 'package:quote/core/api/api_consumer.dart';
import 'package:quote/core/api/end_points.dart';
import 'package:quote/features/random_quote/data/models/quote_model.dart';

abstract class QuotesRemoteDataSource {
  Future<List<QuoteModel>> getQuotes();
}

class QuotesRemoteDataSourceImpl implements QuotesRemoteDataSource {
  ApiConsumer apiConsumer;
  QuotesRemoteDataSourceImpl({
    required this.apiConsumer,
  });

  @override
  Future<List<QuoteModel>> getQuotes() async {
    List<QuoteModel> quotes = [];
    var response = await apiConsumer.get(EndPoints.quotes) as List;
    response.forEach((element) {
      quotes.add(QuoteModel.fromJson(element));
    });
    return quotes;
  }
}
