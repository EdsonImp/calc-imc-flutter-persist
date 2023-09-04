import 'package:hive/hive.dart';

import '../model/imc.dart';
import '../model/imc_adapter.dart';


class ImcRepository {
  static late  Box<Imc> imcBox;

  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ImcAdapter());
    }

    imcBox = await Hive.openBox<Imc>('imcs');
  }

  //metodo para add um novo user
  static Future<void> addImc(Imc newImc) async {
    await ImcRepository.imcBox.add(newImc);
  }
  //Método que retorna todas as listas
  List<Imc> getAllImc() {
    return ImcRepository.imcBox.values.toList();
  }
}