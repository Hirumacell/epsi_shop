import 'package:epsi_shop/bo/article.dart';
import 'package:epsi_shop/page/about_us_page.dart';
import 'package:epsi_shop/page/article_page.dart';
import 'package:epsi_shop/page/cart_page.dart';
import 'package:epsi_shop/page/home_page.dart';
import 'package:epsi_shop/page/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      name: "home",
      builder: (_, state) => const HomePage(),
      routes: [
        GoRoute(
          path: "cart",
          name: "cart",
          builder: (context, state) => const CardPage(),
          routes: [
            GoRoute(
              path: "payment",
              name: "payment",
              builder: (context, state) => const PaymentPage(),
            ),
          ],
        ),
        GoRoute(path: "about_us", name: "about_us", builder: (context, state) => AboutUs()),
        GoRoute(path: "article", name: "article", builder: (_, state) {
          Article article = state.extra! as Article;
          return ArticlePage(article: article);
        }),
      ],
    ),
  ],
);
