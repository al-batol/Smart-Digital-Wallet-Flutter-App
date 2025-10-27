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
    ServiceModel(name: 'top_up', icon: topUpImg, routeName: topUpRoute),
    ServiceModel(
      name: 'send_money',
      icon: sendMoneyImg,
      routeName: sendMoneyRoute,
    ),
    ServiceModel(name: 'pay_bill', icon: payBillImg, routeName: payBillRoute),
    ServiceModel(
      name: 'currency_exchange',
      icon: currencyExchangeImg,
      routeName: currencyExchangeRoute,
    ),
  ];
}
