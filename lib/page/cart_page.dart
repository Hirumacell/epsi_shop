import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../bo/article.dart';
import '../bo/cart.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Panier EPSI Shop')),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Consumer<Cart>(
        builder: (BuildContext context, Cart cart, Widget? child) {
          return cart.listArticles.isEmpty ?
          EmptyCart() : ListCart(listArticles: cart.listArticles, prixEuros: cart.getTotalPrice());
        },
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed('home'),
        child: const Icon(Icons.home),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Text("Votre panier est de :"),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text("0.00 €",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ]),
          Spacer(
            flex: 1,
          ),
          Text("Le panier est vide"),
          Icon(Icons.image),
          Spacer(
            flex: 1,
          ),
        ]));
  }
}

class ListCart extends StatelessWidget {
  final List<Article> listArticles;
  final String prixEuros;
  const ListCart({
    required this.listArticles,
    required this.prixEuros,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Text("Votre panier est de :"),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(prixEuros,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ]),
        Expanded(
          child: ListView.builder(
            itemCount: listArticles.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                    leading: Image.network(listArticles[index].image),
                    title: Text(listArticles[index].nom),
                    subtitle: Text(listArticles[index].GetPrixEuros()),
                    trailing: TextButton(
                      onPressed: () => context.read<Cart>().remove(listArticles[index]),
                      child: Text('Supprimer'),
                    )),
              );
            },
          ),
        ),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => context.goNamed('payment'),
            
            child: Text('Procéder au paiement'),
          ),
        ),
      ],
    ),
  );
}
