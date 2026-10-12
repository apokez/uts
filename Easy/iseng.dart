import 'dart:io';

void main() {
  print('==============================================');
  print('       PROGRAM MENENTUKAN BILANGAN TERBESAR JOKOWI   ');
  print('                  (LEVEL: EASY)               ');
  print('==============================================');

  stdout.write('Masukkan bilangan pertama: ');
  String? input1 = stdin.readLineSync();

  stdout.write('Masukkan bilangan kedua  : ');
  String? input2 = stdin.readLineSync();

  if (input1 == null || input1.trim().isEmpty || input2 == null || input2.trim().isEmpty) {
    print('Error: Kedua bilangan harus diisi!');
    return;
  }

  double? bil1 = double.tryParse(input1.trim());
  double? bil2 = double.tryParse(input2.trim());

  if (bil1 == null || bil2 == null) {
    print('Error: Input harus berupa angka yang valid!');
    return;
  }

  print('----------------------------------------------');
  print('Bilangan pertama: ${formatAngka(bil1)}');
  print('Bilangan kedua  : ${formatAngka(bil2)}');
  print('----------------------------------------------');

  if (bil1 > bil2) {
    print('Hasil: Bilangan pertama (${formatAngka(bil1)}) lebih besar daripada bilangan kedua (${formatAngka(bil2)}).');
  } else if (bil2 > bil1) {
    print('Hasil: Bilangan kedua (${formatAngka(bil2)}) lebih besar daripada bilangan pertama (${formatAngka(bil1)}).');
  } else {
    print('Hasil: Kedua bilangan bernilai sama (${formatAngka(bil1)}).');
  }
  print('==============================================');
}

/// Menghilangkan desimal .0 jika angka berupa bilangan bulat
String formatAngka(double angka) {
  if (angka == angka.truncateToDouble()) {
    return angka.toInt().toString();
  }
  return angka.toString();
}
