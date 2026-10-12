import 'dart:io';

void main() {
  print('==============================================');
  print('   PROGRAM PENGHITUNG TARIF LISTRIK BERSIKLUS  ');
  print('             (SISTEM TARIF BERTINGKAT)        ');
  print('==============================================');
  print('Ketentuan Tarif:');
  print('- 0 - 100 kWh       : Rp 1.500 / kWh');
  print('- 101 - 300 kWh     : Rp 2.000 / kWh (kelebihan > 100 kWh)');
  print('- Di atas 300 kWh   : Rp 2.500 / kWh (kelebihan > 300 kWh)');
  print('----------------------------------------------');

  stdout.write('Masukkan jumlah pemakaian listrik (kWh): ');
  String? input = stdin.readLineSync();

  if (input == null || input.trim().isEmpty) {
    print('Error: Input tidak boleh kosong.');
    return;
  }

  double? pemakaian = double.tryParse(input.trim());

  if (pemakaian == null || pemakaian < 0) {
    print('Error: Masukkan angka pemakaian listrik yang valid (>= 0).');
    return;
  }

  double tagihanTier1 = 0;
  double tagihanTier2 = 0;
  double tagihanTier3 = 0;

  double kwhTier1 = 0;
  double kwhTier2 = 0;
  double kwhTier3 = 0;

  if (pemakaian <= 100) {
    kwhTier1 = pemakaian;
    tagihanTier1 = kwhTier1 * 1500;
  } else if (pemakaian <= 300) {
    kwhTier1 = 100;
    tagihanTier1 = kwhTier1 * 1500;

    kwhTier2 = pemakaian - 100;
    tagihanTier2 = kwhTier2 * 2000;
  } else {
    kwhTier1 = 100;
    tagihanTier1 = kwhTier1 * 1500;

    kwhTier2 = 200;
    tagihanTier2 = kwhTier2 * 2000;

    kwhTier3 = pemakaian - 300;
    tagihanTier3 = kwhTier3 * 2500;
  }

  double totalTagihan = tagihanTier1 + tagihanTier2 + tagihanTier3;

  print('\n================ RINCIAN TAGIHAN =============');
  print('Total Pemakaian: ${pemakaian.toStringAsFixed(pemakaian.truncateToDouble() == pemakaian ? 0 : 2)} kWh');
  print('----------------------------------------------');
  print('Tier 1 (0-100 kWh)     : ${kwhTier1.toStringAsFixed(kwhTier1.truncateToDouble() == kwhTier1 ? 0 : 2)} kWh x Rp 1.500 = Rp ${formatRupiah(tagihanTier1)}');
  if (kwhTier2 > 0) {
    print('Tier 2 (101-300 kWh)   : ${kwhTier2.toStringAsFixed(kwhTier2.truncateToDouble() == kwhTier2 ? 0 : 2)} kWh x Rp 2.000 = Rp ${formatRupiah(tagihanTier2)}');
  }
  if (kwhTier3 > 0) {
    print('Tier 3 (> 300 kWh)     : ${kwhTier3.toStringAsFixed(kwhTier3.truncateToDouble() == kwhTier3 ? 0 : 2)} kWh x Rp 2.500 = Rp ${formatRupiah(tagihanTier3)}');
  }
  print('----------------------------------------------');
  print('TOTAL TAGIHAN          : Rp ${formatRupiah(totalTagihan)}');
  print('==============================================');
}

/// Fungsi untuk memformat angka desimal/bulat menjadi string dengan pemisah ribuan 
String formatRupiah(double nominal) {
  bool isInteger = nominal == nominal.roundToDouble();
  String fixedStr = isInteger ? nominal.toInt().toString() : nominal.toStringAsFixed(2);
  List<String> parts = fixedStr.split('.');
  String integerPart = parts[0];
  String decimalPart = parts.length > 1 ? ',${parts[1]}' : '';

  RegExp reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
  String formattedInteger = integerPart.replaceAllMapped(reg, (Match match) => '.');

  return '$formattedInteger$decimalPart';
}
