import 'package:epsi_shop/bo/article.dart';
import 'package:epsi_shop/bo/cart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key, required this.article}) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(
              child: Text(
                "Détail sur l'article",
              ),
            ),
            actions: [
              IconButton(
                icon: Badge(
                    label: Text("${context.watch<Cart>().listArticles.length}"),
                    child: const Icon(Icons.shopping_cart)),
                onPressed: () {
                  context.goNamed('cart');
                },
              ),
            ],
            backgroundColor: Theme.of(context).colorScheme.primary),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                  child: Text(
                    article.nom,
                    style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Image.network(
                article.image,
                width: 200,
                height: 200,
              ),
              Center(
                  child: Text(
                    article.GetPrixEuros(),
                    style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )),
              Center(
                  child: Text('Catégorie: ${article.categorie}',
                      style: const TextStyle(fontSize: 15))),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: const Row(
                  children: [
                    Text(
                      'Description du produit',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Center(
                  child: Text(article.description,
                      style: const TextStyle(fontSize: 17))),
              const Spacer(),
              Consumer<Cart>(builder: (context, cart, child) {
                return TextButton(
                  onPressed: () => cart.add(article),
                  child: const Text("Ajouter cet article au panier"),
                );
              })
            ],
          ),
        ));
  }
}
