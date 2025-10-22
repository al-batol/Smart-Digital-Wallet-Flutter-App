class FormatHelper {
  static String formatAccountDisplay(String accountType, String accountNumber) {
    final capitalizedAccountType =
        accountType[0].toUpperCase() + accountType.substring(1);
    final lastFourDigits = accountNumber.substring(accountNumber.length - 4);
    return '$capitalizedAccountType (**** $lastFourDigits)';
  }
}
