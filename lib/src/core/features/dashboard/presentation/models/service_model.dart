import 'package:smart_digital_wallet/src/core/common/constants/app_constants.dart';
import 'package:smart_digital_wallet/src/core/common/routes/app_route_names.dart';

class ServiceModel {
  final String name;
  final String icon;
  final String routeName;

  const ServiceModel({
    required this.name,
    required this.icon,
    required this.routeName,
  });

  static List<ServiceModel> get services => [
    ServiceModel(name: 'Top Up', icon: topUpImg, routeName: topUpRoute),
    ServiceModel(
      name: 'Send Money',
      icon: sendMoneyImg,
      routeName: sendMoneyRoute,
    ),
    ServiceModel(name: 'Pay Bill', icon: payBillImg, routeName: payBillRoute),
  ];
}
