import 'package:uuid/uuid.dart';

String generateToken() {
  Uuid uuid = Uuid();
  return uuid.v4();
}
