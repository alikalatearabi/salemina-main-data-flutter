String toFarsiNumber(String number) {
  return number.replaceAllMapped(RegExp(r'\d'), (match) => '۰۱۲۳۴۵۶۷۸۹'[int.parse(match[0]!)]);
}