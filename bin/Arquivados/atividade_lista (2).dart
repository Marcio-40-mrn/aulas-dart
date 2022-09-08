import 'dart:convert';

import 'dart:io';

void main(List<String> arguments) {
  print("/x1B[2J/ [0;0H");
  final myBooks = <Map<String, dynamic>>[];
  // final myBooks = List<Map>.empty();
  // final myBooks2 = <Map>[];
  // final myBooks3 = <Map<String, dynamic>>[];
  // final mapList = List<Map<String, dynamic>>.empty();
  // [] => Referência a uma lista
  // Ex: declaração :   <String>[];
  // {} => referência a um map
  // Ex: declaração : <String, dynamic>{}

  String option = "";

  do {
    print(
      '''
  1) Adicionar livro
  2) Remover livro
  3) Atualizar livro
  4) Reordenar lista
  5) Ordenar alfabeticamente a lista
  6) Mostrar lista
  0) Sair
''',
    );
    option = stdin.readLineSync(encoding: utf8)!;

    switch (option) {
      case '1':
        addTheme(myList: myBooks);
        break;
      case '2':
        if (myBooks.isNotEmpty) {
          showList(myBooks);
          print("Digite a posição do item a ser removido");
          String indexToRemove = stdin.readLineSync(encoding: utf8)!;

          int index = int.parse(indexToRemove);
          if (index > myBooks.length) {
            print("Item inexistente na lista");
          } else {
            print(myBooks[index]);
            print(
              '''Deseja realmente remover este livro?
            0) Sim
            1) Não''',
            );
            final deleteOption =
                stdin.readLineSync(encoding: utf8)! == "0" ? true : false;

            if (deleteOption) {
              myBooks.removeAt(index - 1);
              print("Item removido com sucesso!");
            }
          }
        } else {
          print("Não há itens para serem removidos!");
        }
        break;
      case '3':
        updateBook(myList: myBooks);
        break;
      case '4':
        print("Reordenando sua lista!");
        myBooks.shuffle();
        print("Sua lista foi reordenada com sucesso!");
        showList(myBooks);
        break;
      case '5':
        print("Essa é sua lista em ordem alfabética!");

        final myOrderedExercises = <Map<String, dynamic>>[];

        myOrderedExercises.sort((a, b) =>
            a['name'].toUpperCase().compareTo(b['name'].toUpperCase()));
        showList(myOrderedExercises);
        break;
      case '6':
        showList(myBooks);
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

void updateBook({required List<Map<String, dynamic>> myList}) {
  if (myList.isNotEmpty) {
    showList(myList);
    print("Qual livro deseja atualizar ? Digite o número do livro:");
    String indexToEdit = stdin.readLineSync(encoding: utf8)!;
    int index = int.parse(indexToEdit);

    if (index > myList.length || index < 1) {
      print("Livro inexistente na lista!");
      return;
    }
    print('O livro a ser editada é  :');
    showItem(myList[index - 1], index);
    print(
      'Se sim, digite qual campo quer alterar, se não quiser alterar nada, digite 0 !',
    );

// ['name']
// ['length']
// ['author']
// ['publishYear']
// ['isbn']

    String newValue = stdin.readLineSync(encoding: utf8)!;
    if (newValue.trim() == "0") {
      return;
    }

    // final keysMap = <String, String>{
    //   '1': 'name',
    //   '2': 'length',
    //   '3': 'author',
    //   '4': 'publishYear',
    //   '5': 'isbn',
    // };

    // myList[index - 1][keysMap[newValue].toString()] =
    //     getStringValueAndValidate(keysMap[newValue].toString());

    if (newValue == '1') {
      myList[index - 1]['name'] = getStringValueAndValidate('Nome');
    } else if (newValue == '2') {
      myList[index - 1]['length'] =
          getStringValueAndValidate('número de páginas');
    } else if (newValue == '3') {
      myList[index - 1]['author'] = getStringValueAndValidate('autor');
    } else if (newValue == '4') {
      myList[index - 1]['publishYear'] =
          getStringValueAndValidate('ano de publicação');
    } else if (newValue == '5') {
      myList[index - 1]['isbn'] = getStringValueAndValidate('isbn');
    }

    print("Seu livro ${myList[index - 1]['name']} foi atualizado!");
    showList(myList);
  } else {
    print("Não há itens para serem editados!");
  }
}

void addTheme({
  required List<Map> myList,
}) {
  String name = getStringValueAndValidate('nome');
  String pageQuantity = getStringValueAndValidate('número de páginas');
  String author = getStringValueAndValidate('autor');
  String publishYear = getStringValueAndValidate('ano da publicação');
  String isbn = getStringValueAndValidate('ISBN');

  final map = <String, dynamic>{
    'name': name,
    'length': int.parse(pageQuantity),
    'author': author,
    'publishYear': int.parse(publishYear),
    'isbn': isbn,
  };
  myList.add(map);
  print('livro:  $name adicionada a lista!');
}

String getStringValueAndValidate(String dataName) {
  print("Digite o $dataName do livro a ser adicionado :");
  String name = stdin.readLineSync(encoding: utf8)!;
  while (name.isEmpty) {
    print("Digite um $dataName válido:");
    name = stdin.readLineSync(encoding: utf8)!;
  }

  return name;
}

void showList(List<Map<String, dynamic>> myList) {
  if (myList.isEmpty) {
    print("Sua lista está vazia!");
    return;
  }
  print("Seus itens são:");

  for (int i = 0; i < myList.length; i++) {
    showItem(myList[i], i);
  }

  print('');
}

void showItem(Map<String, dynamic> book, int index) {
  print('Livro ${index + 1}');
  print("1)Nome: ${book['name']}");
  print("2)Tamanho: ${book['length']} páginas");
  print("3)Autor: ${book['author']}");
  print("4)Ano de publicação ${book['publishYear']}");
  print("5)Código ISBN:  ${book['isbn']}\n");
}
