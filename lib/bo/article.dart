class Article{
  String nom;
  final String image;
  String description;
  int prix;
  String categorie;

  Article({
    required this.nom,
    required this.image,
    required this.description,
    required this.prix,
    required this.categorie,
  });

  GetPrixEuros() =>"${prix/100} €";

  Map<String, dynamic> toMap() {
    return {
      'nom': this.nom,
      'image': this.image,
      'description': this.description,
      'prix': this.prix,
      'categorie': this.categorie,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      nom: map['title'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      prix: ((map['price'] as num) * 100).floor(),
      categorie: map['category'] as String,
    );
  }
}

void main(){

}