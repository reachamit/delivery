class WalletDetails {
  final String balance;
  final double deliveryAmount;
  final double tipAmount;
  final double liabilityAmount;

  WalletDetails({
    this.balance = "0.00",
    this.deliveryAmount = 0,
    this.tipAmount = 0,
    this.liabilityAmount = 0,
  });

  factory WalletDetails.fromJson(Map<String, dynamic> json) {
    final data = json['Data'];
    return WalletDetails(
      deliveryAmount: data['delivery_amount'],
      tipAmount: data['tip_amount'],
      liabilityAmount: data['liability_amount'],
    );
  }
}
