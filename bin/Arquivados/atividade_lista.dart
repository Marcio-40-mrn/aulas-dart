import 'dart:convert';

import 'dart:io';

void main(List<String> arguments) {
  print("/x1B[2J/ [0;0H");
  final myExercises = <String>[];
  String option = "";

  do {
    print(
      '''
  1) Adicionar tema
  2) Remover tema
  3) Atualizar tema
  4) Reordenar lista
  5) Ordenar alfabeticamente a lista
  6) Mostrar lista
  0) Sair
''',
    );
    option = stdin.readLineSync(encoding: utf8)!;

    switch (option) {
      case '1':
        print("Digite o tema a ser adicionado :");
        String theme = stdin.readLineSync(encoding: utf8)!;
        myExercises.add(theme);
        print('Tarefa:  $theme adicionada a lista!');
        break;
      case '2':
        if (myExercises.isNotEmpty) {
          showList(myExercises);
          print("Digite a posição do item a ser removido");
          String indexToRemove = stdin.readLineSync(encoding: utf8)!;

          int index = int.parse(indexToRemove);
          if (index > myExercises.length) {
            print("Item inexistente na lista");
          } else {
            print(myExercises[index]);
            print(
              '''Deseja realmente remover este tema?
            0) Sim
            1) Não''',
            );
            final deleteOption =
                stdin.readLineSync(encoding: utf8)! == "0" ? true : false;

            if (deleteOption) {
              myExercises.removeAt(index - 1);
              print("Item removido com sucesso!");
            }
          }
        } else {
          print("Não há itens para serem removidos!");
        }
        break;
      case '3':
        if (myExercises.isNotEmpty) {
          showList(myExercises);
          print("Qual tema deseja atualizar ? Digite o index da opção:");
          String indexToEdit = stdin.readLineSync(encoding: utf8)!;
          int index = int.parse(indexToEdit);

          if (index > myExercises.length) {
            print("Item inexistente na lista!");
            break;
          }
          print(''''
A nota a ser editada é a nota :

${myExercises[index - 1]}

Se sim, digite a nova tarefa, se não, digite 0 !
''');

          String newValue = stdin.readLineSync(encoding: utf8)!;
          if (newValue.trim() == "0") {
            break;
          }

          myExercises[index - 1] = newValue;

          print("Seu item $index foi atualizado!");
          showList(myExercises);
        } else {
          print("Não há itens para serem editados!");
        }

        break;
      case '4':
        print("Reordenando sua lista!");
        myExercises.shuffle();
        print("Sua lista foi reordenada com sucesso!");
        showList(myExercises);
        break;
      case '5':
        print("Essa é sua lista em ordem alfabética!");

        final myOrderedExercises = List<String>.from(myExercises);

        myOrderedExercises
            .sort((a, b) => a.toUpperCase().compareTo(b.toUpperCase()));
        showList(myOrderedExercises);
        break;
      case '6':
        showList(myExercises);
        break;

      case '0':
        print("Obrigado por usar nosso app, volte sempre!");
        break;
      default:
        print("Opção digitada é inválida, tente novamente!\n\n");
        break;
    }
  } while (option != "0");
}

void showList(List<String> myList) {
  if (myList.isEmpty) {
    print("Sua lista está vazia!");
    return;
  }
  print("Seus itens são:");
  for (int i = 0; i < myList.length; i++) {
    print("${i + 1}) ${myList[i]}");
  }
}
