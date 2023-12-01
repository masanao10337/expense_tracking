import 'package:uuid/uuid.dart';

const  uuid = Uuid();

class Expense {
  Expense({
    required this.title,
    required this.ammount,
    required this.date,
  }) : id = uuid.v4();
  //NOTE: idもmodelingできるかもね。
  final String id;
  final String title;
  final double ammount;
  final DateTime date;
}
