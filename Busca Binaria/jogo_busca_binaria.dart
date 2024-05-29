// Desenvolvido por David Dias.

// O jogo consiste em o usuário tentar acertar o número secreto, e o jogo retornara se o "chute" é maior ou menor que o numero secreto.
// O usuário tera uma quantidade finita de tentativas (vidas) que vai depender do intervalo de números.

import 'dart:io';
import 'dart:math';

void main() {
  welcomeGame();
  verificaChute();
}

welcomeGame() {
  print("\n--- Bem vindo ao 'O JOGO'---");
  print(
      "\nVocê precisa acertar o número secreto e dependendo do intervalo de números, você tera mais ou menos vidas");
  print("\nRecomendo que saiba o conceito de busca binaria para jogar");
}

gerarNumeroSecreto(intervaloMaximo) {
  int numeroSecreto = Random().nextInt(intervaloMaximo);
  if (numeroSecreto != 0) {
    return numeroSecreto;
  } else {
    numeroSecreto++;
    return numeroSecreto;
  }
}

verificaNum(i) {
  RegExp regex = RegExp(r'^\d+$');
  return regex.hasMatch(i);
}

verificaYOrN(i) {
  RegExp regex = RegExp(r'^[yYnN]$');
  return regex.hasMatch(i);
}

obterNumero(texto) {
  print(texto);
  String? input = stdin.readLineSync();
  if (verificaNum(input)) {
    int? chute = int.parse(input!);
    return chute;
  } else {
    print("\nValor invalido, Por favor digite apenas números.");
    return obterNumero(texto);
  }
}

obterYOrN() {
  String? resposta = stdin.readLineSync();
  if (verificaYOrN(resposta)) {
    return resposta;
  } else {
    print("\nPor favor digite 'Y' para sim ou 'N' para não");
    return obterYOrN();
  }
}

desejaJogarNovamente() {
  print("\nDeseja Jogar Novamente?");
  print("\nDigite 'Y' para sim ou 'N' para não");
  String YOrN = obterYOrN();

  if (YOrN == "y" || YOrN == "Y") {
    verificaChute();
  } else {
    print("\nObrigado por jogar, até a proxima");
    print("\nFeito por David Dias.");
    print("GitHub: https://github.com/DavidDias1999");
  }
}

verificaChute() {
  int intervaloMax = obterNumero("\nDigite o numero máximo do intervalo");

  int numeroSecreto = gerarNumeroSecreto(intervaloMax);

  double? logBase(x) {
    return log(x) / log(2);
  }

  int vida = (logBase(intervaloMax)!.round()) + 1;

  while (vida > 0) {
    // A fim de debug, se quiser saber o valor gerado randomicamente, é só "descomentar" o print abaixo
    // print("o numero secreto é $numeroSecreto");
    print("Voce tem ${vida} ${vida > 1 ? "vidas" : "vida"}");
    int chute = obterNumero("\nDigite seu chute\n");

    if (chute == numeroSecreto) {
      print("\nParabéns !! seu chute esta correto");
      desejaJogarNovamente();
      break;
    }
    if (chute < numeroSecreto) {
      print("\nSeu chute foi menor que o numero secreto\n");
      vida--;
    } else {
      print("\nSeu chute foi maior que o numero secreto\n");
      vida--;
    }
  }
  if (vida.round() == 0) {
    print("\n--- Suas Vidas Acabaram ---");
    print("\n--- Game Over --- \n");
    desejaJogarNovamente();
  }
}
