import 'package:calc_imc_flutter_persist/model/imc.dart';
import 'package:calc_imc_flutter_persist/repositories/imc_repository.dart';
import 'package:calc_imc_flutter_persist/repositories/user_repository.dart';
import 'package:calc_imc_flutter_persist/widgets/custon_text_form_field_number.dart';
import 'package:calc_imc_flutter_persist/widgets/custon_text_form_fildsText.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shared_preferences/shared_preferences.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var documentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentDirectory.path);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de Imc',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  const HiveTest(),
    );
  }

}

class HiveTest extends StatefulWidget {
  const HiveTest({super.key});

  @override
  State<HiveTest> createState() => _HiveTestState();
}

  class _HiveTestState extends State<HiveTest> {
  ImcRepository repository = ImcRepository();
  var listaImc = [];

     var nome = "Anonimo";
     var altura = 0.0;

     @override
  void initState() {
    ImcRepository.init();
    listaImc = repository.getAllImc();
    initShared();
    super.initState();
  }

    void novoNome(String nome, double altura) async{
    SharedPreferences shared = await SharedPreferences.getInstance();
    await shared.setString('nome', nome);
    await shared.setDouble('altura', altura);

  }
  TextEditingController nomeController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();

  void initShared() async{
    SharedPreferences shared = await SharedPreferences.getInstance();
        nome = await shared.getString('nome')?? "anonimo";
        altura = await shared.getDouble('altura')?? 0.0;
  }
  @override
  Widget build(BuildContext context) {
    ImcRepository.init();
    initShared();
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog(context: context, builder: (BuildContext bc){
          return AlertDialog(
            title: Text("Imc do dia"),
            content: Container(
              child: Column(
                children: [
                  CustonTextFormFieldNumber(controller: pesoController, hintText: 'Peso atual'),
                  IconButton(onPressed: (){

                    setState(() {
                      var imc = Imc(nome: nome, peso: double.parse(pesoController.text), altura: altura);
                      ImcRepository.addImc(imc);
                      listaImc = ImcRepository().getAllImc().toList();
                    });
                  }, icon: const Icon(Icons.add_circle)),
          IconButton(onPressed: (){
            var valor = ImcRepository().getAllImc();
            print (valor);
          }, icon:const Icon(Icons.list_alt) ),
                ],
              ),
            ),
          );
        });
      },
      child: const Icon(Icons.add_circle),),
      appBar: AppBar(
        title: Text("Imc de : $nome"),
        centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              showDialog(context: context, builder: (BuildContext bc){
                return AlertDialog(
                  title: const Text("Novo usuário"),
                  content: Container(
                    child: Column(
                      children: [
                        CustonTextFormFieldText(controller: nomeController, hintText: "nome"),
                        CustonTextFormFieldNumber(controller: alturaController, hintText: 'altura'),
                          IconButton(onPressed: (){
                            setState(() {
                              novoNome(nomeController.text, double.parse(alturaController.text));
                            });
                            novoNome(nomeController.text, double.parse(alturaController.text));

                          }, icon: const Icon(Icons.add_circle)),
                      ],
                    ),
                  ),
                );
              });
            }, icon: const Icon(Icons.settings_outlined)),
        ],
          ),
      body:listaImc.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
          itemCount: listaImc.length,
          itemBuilder: (BuildContext bc, int index){
            final nome = listaImc[index].nome.toString();
            final peso = double.parse(listaImc[index].peso.toString());
            final altura = double.parse(listaImc[index].altura.toString());
            final imc = (peso /(altura * altura)).round();
            final situacao = Imc.resultado(imc);
        return Card(
          child: ListTile(
            title: Text("Nome: $nome -- Peso: $peso -- Altura: $altura "),
            subtitle: Text("IMC: $imc -- Situação: $situacao"),

          ),
        );
      }
      )
    );
  }
}


