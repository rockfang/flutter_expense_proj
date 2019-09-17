class Transaction {
  String id;
  String title;
  double amount;
  DateTime datetime = DateTime.now();
  Transaction({this.title,this.amount,this.datetime});
}