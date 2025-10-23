enum AccountType {
  wallet('wallet'),
  savings('savings'),
  loyaltyPoints('loyaltyPoints_points');

  final String type;
  const AccountType(this.type);

  factory AccountType.fromName(String name) {
    switch (name) {
      case 'wallet':
        return AccountType.wallet;
      case 'savings':
        return AccountType.savings;
      case 'loyaltyPoints_points':
        return AccountType.loyaltyPoints;
      default:
        throw ArgumentError('Unexpected Account Type');
    }
  }
}

enum AccountCurrency {
  yer('YER', 'ر.ي'),
  sar('SAR', 'ر.س'),
  usd('USD', '\$');

  final String currency;
  final String symbol;
  const AccountCurrency(this.currency, this.symbol);

  factory AccountCurrency.fromName(String name) {
    switch (name) {
      case 'YER':
        return AccountCurrency.yer;
      case 'SAR':
        return AccountCurrency.sar;
      case 'USD':
        return AccountCurrency.usd;
      default:
        throw ArgumentError('Unexpected Account Currency');
    }
  }
}
