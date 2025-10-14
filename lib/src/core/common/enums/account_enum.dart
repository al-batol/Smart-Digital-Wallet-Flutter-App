enum AccountType {
  wallet('wallet'),
  savings('savings'),
  loyalty('loyalty_points');

  final String type;
  const AccountType(this.type);

  factory AccountType.fromName(String name) {
    switch (name) {
      case 'wallet':
        return AccountType.wallet;
      case 'savings':
        return AccountType.savings;
      case 'loyalty_points':
        return AccountType.loyalty;
      default:
        throw ArgumentError('Unexpected Account Type');
    }
  }
}

enum AccountCurrency {
  yer('YER'),
  sar('SAR'),
  usd('USD');

  final String currency;
  const AccountCurrency(this.currency);

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
