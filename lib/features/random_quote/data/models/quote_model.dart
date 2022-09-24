import 'package:quote/features/random_quote/domain/entities/quote.dart';

class QuoteModel extends Quote {
  const QuoteModel({
    required super.id,
    required super.author,
    required super.content,
    required super.permalink,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> map) {
    return QuoteModel(
      id: map["id"],
      author: map["author"],
      content: map["quote"],
      permalink: map["permalink"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "author": author,
      "quote": content,
      "permalink": permalink,
    };
  }
  
}
