import '../../domain/entiites/card_info.dart';
class CardModel extends CardInfo {
  CardModel({
    required super.holderName,
    required super.number,
    required super.expiry,
    required super.cvc,
    required super.brand,
  });

  factory CardModel.fromEntity(CardInfo entity) => CardModel(
        holderName: entity.holderName,
        number: entity.number,
        expiry: entity.expiry,
        cvc: entity.cvc,
        brand: entity.brand,
      );

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        holderName: json['holderName'] as String,
        number: json['number'] as String,
        expiry: json['expiry'] as String,
        cvc: json['cvc'] as String,
        brand: json['brand'] as String,
      );

  Map<String, dynamic> toJson() => {
        'holderName': holderName,
        'number': number,
        'expiry': expiry,
        'cvc': cvc,
        'brand': brand,
      };
}
