class User{
  String? nome;
  double? peso;
  double? altura;

  User({required this.nome, required this.peso, required this.altura});

  @override
  String toString() {
    return 'User{nome: $nome, peso: $peso, altura: $altura}';
  }
}