
import 'package:equatable/equatable.dart';

class DeliveryManEntity extends Equatable {

  const DeliveryManEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.imageUrl,
  });
  final String id;
  final String name;
  final String phone;
  final String imageUrl;

  @override
  List<Object?> get props => [id, name, phone, imageUrl];
}


