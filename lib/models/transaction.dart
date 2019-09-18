class Transaction {
  String id;
  String title;
  double amount;
  DateTime datetime = DateTime.now();
  Transaction({this.id,this.title,this.amount,this.datetime});
}