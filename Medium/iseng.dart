import 'dart:io';

void main() {
  print('==================================================');
  print('     PROGRAM SELEKSI KELAYAKAN BEASISWA JOKOWI          ');
  print('               (LEVEL: MEDIUM)');
  print('==================================================');
  print('Syarat Penerima Beasiswa:');
  print('- IPK minimal 3.50');
  print('- Penghasilan orang tua maksimal Rp 4.000.000/bulan');
  print('--------------------------------------------------');

  // Input IPK
  stdout.write('Masukkan IPK mahasiswa (0.00 - 4.00)           : ');
  String? ipkInput = stdin.readLineSync();

  // Input Penghasilan Orang Tua
  stdout.write('Masukkan penghasilan orang tua per bulan (Rp) : ');
  String? penghasilanInput = stdin.readLineSync();

  if (ipkInput == null || ipkInput.trim().isEmpty ||
      penghasilanInput == null || penghasilanInput.trim().isEmpty) {
    print('Error: IPK dan penghasilan orang tua tidak boleh kosong.');
    return;
  }

  // Mengganti koma dengan titik jika pengguna memasukkan format koma (contoh: 3,75)
  double? ipk = double.tryParse(ipkInput.trim().replaceAll(',', '.'));
  // Menghilangkan titik/koma/spasi pada penghasilan jika ada pemisah ribuan (contoh: 3.500.000 atau Rp3500000)
  String sanitizedPenghasilan = penghasilanInput
      .replaceAll('Rp', '')
      .replaceAll('rp', '')
      .replaceAll('.', '')
      .replaceAll(',', '')
      .trim();
  double? penghasilan = double.tryParse(sanitizedPenghasilan);

  if (ipk == null || ipk < 0 || ipk > 4.0) {
    print('Error: Nilai IPK tidak valid! Harus berada di antara 0.00 dan 4.00.');
    return;
  }

  if (penghasilan == null || penghasilan < 0) {
    print('Error: Penghasilan orang tua tidak valid!');
    return;
  }

  print('\n================== HASIL SELEKSI =================');
  print('IPK Mahasiswa             : ${ipk.toStringAsFixed(2)}');
  print('Penghasilan Orang Tua     : Rp ${formatRupiah(penghasilan)}');
  print('--------------------------------------------------');

  bool lolosIpk = ipk >= 3.50;
  bool lolosPenghasilan = penghasilan <= 4000000;

  if (lolosIpk && lolosPenghasilan) {
    print('Status: "Berhak Menerima Beasiswa"');
  } else {
    print('Status: "Tidak Berhak"');
    print('\nCatatan:');
    if (!lolosIpk) {
      print('- IPK kurang dari 3.50 (IPK Anda: ${ipk.toStringAsFixed(2)})');
    }
    if (!lolosPenghasilan) {
      print('- Penghasilan orang tua melebihi Rp 4.000.000 (Penghasilan: Rp ${formatRupiah(penghasilan)})');
    }
  }
  print('==================================================');
}

/// Fungsi pembantu untuk memformat angka nominal ke pemisah ribuan
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
