import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../bo/article.dart';
import '../bo/cart.dart';
import 'package:http/http.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('E-commerce')),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: Badge(
                label: Text("${context.watch<Cart>().listArticles.length}"),
                child: const Icon(Icons.shopping_cart)),
            onPressed: () {
              context.goNamed('cart');
            },
          ),
          IconButton(
              onPressed: () => context.goNamed('about_us'),
              icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed('cart'),
        child: const Icon(Icons.shopping_cart),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: FutureBuilder(
          future: getArticles(),
          builder: (context, snapshot) =>
          switch (snapshot.connectionState) {
            ConnectionState.done when snapshot.data != null =>
              ListArticle(ListObjets: snapshot.data as List<Article>),
            ConnectionState.waiting =>
                const Center( child: CircularProgressIndicator()),
            _ => Icon(Icons.error),
              },
      ),
    );
  }

  Future<List<Article>> getArticles() async {
      Response ListArticle = await get(Uri.parse('https://fakestoreapi.com/products'));
    if (ListArticle.statusCode == 200 && ListArticle.body.isNotEmpty) {
      final resListMap = jsonDecode(ListArticle.body) as List<dynamic>;
      return Future.value(resListMap.map<Article>((map)=>
          Article.fromMap(map as Map<String,dynamic>)).toList());
    } else {
      throw Exception('Failed to load');
    }
  }
}

class ListArticle extends StatelessWidget {
  const ListArticle({
    super.key,
    required this.ListObjets,
  });

  final List<Article> ListObjets;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ListObjets.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
              leading: Image.network(ListObjets[index].image),
              title: Text(ListObjets[index].nom),
              subtitle: Text(ListObjets[index].GetPrixEuros()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () =>
                        context.read<Cart>().add(ListObjets[index]),
                    child: Text('Ajouter'),
                  ),
                  TextButton(
                    onPressed: () => context.goNamed('article',
                        extra: ListObjets[index]),
                    child: Text('Détail'),
                  ),
                ],
              )),
        );
      },
    );
  }
}
