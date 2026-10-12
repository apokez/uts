import 'dart:io';

void main(){
  print('==============================================');
  print('       PROGRAM MENENTUKAN BILANGAN TERBESAR   ');
  print('                  (LEVEL: EASY)               ');
  print('==============================================');

  stdout.write('Masukkan bilangan pertama: ');
   int a = int.parse(stdin.readLineSync()!);

   stdout.write('Masukkan bilangan kedua: ');
   int b = int.parse(stdin.readLineSync()!);

   if (a > b){
    print('Bilangan terbesar adalah $a');
   } else {
    print('Bilangan terbesar adalah $b');
   }
}
