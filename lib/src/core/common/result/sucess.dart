import 'package:equatable/equatable.dart';

abstract class Success extends Equatable {
  final String message;

  const Success({required this.message});

  @override
  List<Object?> get props => [message];
}

class DashboardSuccess extends Success {
  const DashboardSuccess({required super.message});
}

class TopUpSuccess extends Success {
  const TopUpSuccess({required super.message});
}

class SendMoneySuccess extends Success {
  const SendMoneySuccess({required super.message});
}
