import 'package:hive/hive.dart';
import 'imc.dart';


class ImcAdapter extends TypeAdapter<Imc> {

  @override
  int get typeId => 0;

  @override
  Imc read(BinaryReader reader) {
    return Imc(
        nome: reader.readString(),
        peso: reader.readDouble(),
        altura: reader.readDouble()
    );
  }


  @override
  void write(BinaryWriter writer, Imc obj) {
    writer.writeString(obj.nome!);
    writer.writeDouble(obj.peso!);
    writer.writeDouble(obj.altura!);
  }
}