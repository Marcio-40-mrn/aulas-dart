import 'dart:convert';
import 'dart:io';

void main(List<String> arguments) {
  print("\x1B[2J\x1B[0;0H");

  final myCars = <Map<String, dynamic>>[];

  String option = "";

  do {
    print("Digite a opção desejada:");
    print(
      '''
1) Adicionar Veiculo
2) Excluir Veiculo
3) Atualizar Veiculo
4) Mostrar Veiculos
0) Sair
''',
    );
    option = stdin.readLineSync(encoding: utf8)!;

    switch (option) {
      case '1':
        addCar(myList: myCars);
        break;
      case '2':
        removeCar(myList: myCars);
        break;
      case '3':
        updateCar(myList: myCars);
        break;
      case '4':
        mostrarLista(myCars);
        break;
      default:
        print("Opção digitada é inválida, tente novamente!\n\n");
        break;
    }
  } while (option != "0");
}

void addCar({
  required List<Map> myList,
}) {
  String car = validValue('carro');
  String model = validValue('modelo');
  String brand = validValue('montadora');
  String year = validValue('ano');

  final map = <String, dynamic>{
    'car': car,
    'model': model,
    'brand': brand,
    'year': year,
  };
  myList.add(map);
  print('Veiculo $car adicionado na lista\n\n');
}

void removeCar({
  required List<Map<String, dynamic>> myList,
}) {
  if (myList.isNotEmpty) {
    mostrarLista(myList);
    print("Digite a posição do item a ser removido\n\n");
    String indexToRemove = stdin.readLineSync(encoding: utf8)!;

    int index = int.parse(indexToRemove);
    if (index > myList.length) {
      print("Item inexistente na lista\n\n");
    } else {
      print(myList[index - 1]);
      print(
        '''Deseja realmente remover este Carro?\n\n
            0) Sim
            1) Não''',
      );
      final deleteOption =
          stdin.readLineSync(encoding: utf8)! == "0" ? true : false;
      if (deleteOption) {
        myList.removeAt(index - 1);
        print("Carro removido com sucesso!\n\n");
      }
    }
  } else {
    print("Não há itens para serem removidos!\n\n");
  }
}

String validValue(String dataName) {
  print("Digite o $dataName do Veiculo a ser adicionado :");
  String name = stdin.readLineSync(encoding: utf8)!;
  while (name.isEmpty) {
    print("Digite um $dataName válido:");
    name = stdin.readLineSync(encoding: utf8)!;
  }
  return name;
}

void updateCar({required List<Map<String, dynamic>> myList}) {
  if (myList.isNotEmpty) {
    mostrarLista(myList);
    print("Qual Carro deseja atualizar ? Digite o numero do carro:");
    String indexToEdit = stdin.readLineSync(encoding: utf8)!;
    int index = int.parse(indexToEdit);

    if (index > myList.length || index < 1) {
      print("Carro inexistente na lista!\n\n");
      return;
    }
    print("O Carro a ser editado é:");
    mostrarItem(myList[index - 1], index - 1);
    print(
      'Se sim, digite qual campo quer alterar. se não quiser alterar nada, digite 0 !',
    );
    String newValue = stdin.readLineSync(encoding: utf8)!;
    if (newValue.trim() == '0') {
      return;
    }
    if (newValue == '1') {
      myList[index - 1]['car'] = validValue('carro');
    } else if (newValue == '2') {
      myList[index - 1]['model'] = validValue('modelo');
    } else if (newValue == '3') {
      myList[index - 1]['brand'] = validValue('montadora');
    } else if (newValue == '3') {
      myList[index - 1]['year'] = validValue('ano');
    }
    print("Seu carro ${myList[index - 1]['car']} foi atualizado!");
    mostrarLista(myList);
  } else {
    print("Não há itens para serem editados!");
  }
}

void mostrarLista(List<Map<String, dynamic>> myList) {
  if (myList.isEmpty) {
    print("Sua lista não contem Carros Lançados!");
    return;
  }
  print("Seus itens são:");

  for (int i = 0; i < myList.length; i++) {
    mostrarItem(myList[i], i);
  }
}

void mostrarItem(Map<String, dynamic> car, int index) {
  print('Veiculo ${index + 1}');
  print("1)Carro: ${car['car']}");
  print("2)Modelo: ${car['model']}");
  print("3)Marca: ${car['brand']}");
  print("4)Ano>: ${car['year']}\n");
}
