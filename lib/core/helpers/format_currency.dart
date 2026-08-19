String formatCurrency(double? amount) {
  if (amount == null) return 'N/A';
  final parts = amount.toStringAsFixed(2).split('.');
  final reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  final formattedInt = parts[0].replaceAllMapped(reg, (m) => '${m[1]},');
  return '\$$formattedInt.${parts[1]}';
}
