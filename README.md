# Smart Digital Wallet

Smart Digital Wallet is a comprehensive financial application built using the Flutter framework with BLoC state management pattern and clean architecture principles. It provides users with a complete digital wallet solution for managing multiple currencies, making transactions, paying bills, and accessing various top-up services for telecom providers. **This is a simulation app using mocked data for demonstration purposes.**

![App Screenshots](https://github.com/user-attachments/assets/fdf35bcb-48db-4c7f-816d-5acc695ac359)

## Key Features:

### Authentication and Security

- Users can securely sign in using their email and password credentials.
- The app supports biometric authentication (fingerprint/face recognition) for quick and secure access.
- All sensitive data is encrypted and stored securely on the device using Flutter Secure Storage.
- Users must be authenticated to access wallet features and perform transactions.

### Dashboard and Multi-Currency Accounts

- The dashboard displays all user accounts with their current balances across different currencies (SAR, USD, YER, and a general Wallet account).
- Users can view account details by swiping through account cards in a carousel view.
- A personalized greeting shows the user's name on the dashboard.
- Quick access to three main services: Top Up, Send Money, and Pay Bill.
- The dashboard shows the last transactions history for easy tracking of recent activities.
- Real-time balance updates after each transaction.

### Send Money

- Users can send money to other wallet users by selecting from their beneficiaries list or entering a recipient's 16-digit card ID.
- The send money process includes:
  - Selecting which account to send from (SAR, USD, YER, or Wallet)
  - Choosing the currency to send
  - Entering the amount to send
  - Selecting or entering the recipient's information
  - Confirming the transaction details before completion
- The app validates that the user has sufficient balance before allowing the transfer.
- A beneficiaries list is maintained for quick access to frequently used recipients.

### Pay Bill

- Users can pay various types of bills directly from their wallet.
- Supported bill types include:
  - Water bills
  - Electricity bills
- The payment process includes:
  - Selecting which account to pay from
  - Choosing the bill type
  - Entering the bill number
  - Entering the payment amount
  - Confirming the payment details before processing
- Transaction records are automatically saved in the transaction history.

### Top Up Services

- Users can recharge mobile phone balances for telecom providers.
- Supported providers include:
  - Yemen Mobile
  - Sabafon
- The top-up process includes:
  - Selecting which account to use for payment
  - Choosing the mobile provider
  - Entering the phone number to recharge
  - Entering the recharge amount
  - Confirming the top-up details before processing
- Phone number validation ensures users enter valid phone numbers.

### Currency Exchange

- Users can exchange money between different currency accounts.
- The exchange feature includes:
  - Selecting the source account to exchange from
  - Selecting the destination account to exchange to
  - Choosing the currency to exchange from and to
  - Entering the amount to exchange
  - Viewing the current exchange rate
  - Seeing the converted amount before confirming
  - Confirming the exchange transaction
- The app validates that currency exchanges are allowed between the selected currencies and that users have sufficient balance.

### Transaction History

- All transactions (send money, pay bill, top up, and currency exchange) are automatically recorded.
- Users can view their transaction history from the dashboard.
- Each transaction record includes:
  - Transaction type
  - Amount
  - Account ID used
  - Recipient ID (for send money transactions)
  - Bill type and number (for bill payments)
  - Unique transaction ID
  - Transaction status

### Multi-Language Support

- The app fully supports both Arabic and English languages.
- All screens, buttons, and messages are available in both languages.
- Right-to-left (RTL) layout support for Arabic language ensures proper text alignment and UI flow.
- Currency and number formatting adapts to the selected language.
