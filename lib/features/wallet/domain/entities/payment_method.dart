import 'package:equatable/equatable.dart';

enum PaymentMethodType { upi, debitCard, creditCard, netBanking }

class PaymentMethod extends Equatable {
  final PaymentMethodType type;
  final String label;
  final String? subtitle;
  final String? iconAsset;
  final bool isRecommended;
  final int convenienceFee;

  const PaymentMethod({
    required this.type,
    required this.label,
    this.subtitle,
    this.iconAsset,
    this.isRecommended = false,
    this.convenienceFee = 0,
  });

  @override
  List<Object?> get props => [type, label, subtitle, iconAsset, isRecommended, convenienceFee];
}