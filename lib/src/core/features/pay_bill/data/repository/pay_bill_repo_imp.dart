import 'package:dartz/dartz.dart';
import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart';
import 'package:smart_digital_wallet/src/core/common/result/failure.dart';
import 'package:smart_digital_wallet/src/core/common/result/sucess.dart';
import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/data/data_sources/pay_bill_local_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/data/data_sources/pay_bill_remote_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/data/models/payment_model.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/domain/entities/payment_entity.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/domain/repository/pay_bill_repository.dart';

class PayBillRepoImp extends PayBillRepository {
  final PayBillRemoteDataSource payBillRemoteDataSource;
  final PayBillLocalDataSource payBillLocalDataSource;

  PayBillRepoImp({
    required this.payBillRemoteDataSource,
    required this.payBillLocalDataSource,
  });

  @override
  Future<Result<Success>> payBill(PaymentEntity payment) async {
    try {
      final paymentModel = PaymentModel(
        billType: payment.billType!,
        amount: payment.amount!,
        currency: payment.currency!,
        accountId: payment.accountId!,
      );
      await payBillRemoteDataSource.payBill(paymentModel);
      await payBillLocalDataSource.cachePayment(paymentModel);
      return Right(
        PayBillSuccess(
          message:
              'Successfully paid ${payment.amount} ${payment.currency} for ${payment.billType}',
        ),
      );
    } on PayBillException catch (e) {
      return Left(PayBillFailure(message: e.message));
    }
  }
}
