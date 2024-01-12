import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:badges/badges.dart' as badges;

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../bo/cart.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Finalisation de la commande')),
        //backgroundColor: Colors.red,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Consumer<Cart>(
        builder: (BuildContext context, Cart cart, Widget? child) {
          return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Container(height: 10), //C'est un saut de ligne j'ai pas cherché plus loin,
                  CardRecap(
                    prixTotal: cart.getFinalPrice(),
                    prixTVA: cart.getTVAPrice(),
                    prixSousTotal: cart.getTotalPrice(),
                  ),
                  Container(height: 10),
                  const CardAdresse(),
                  Container(height: 10),
                  const CardPayment(),
                  const Spacer(
                    flex: 1,
                  ),
                  const Text("En cliquant sur 'Confimer l'achat', vous acceptez les Conditions que personne ne lie, en plus on va vous voler toutes vos données et les revendre en Chine même si c'est pas légal héhé"),
                  const Text("En poursuivant, vous acceptez les conditions d'utilisation du Fournisseur de paiement LucienBramardCorp AKA OSS117"),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => sending_data_to_random_api(),

                      child: const Text('Procéder au paiement'),
                    ),
                  ),
                ],
              )
          );
        },
      ),
    );
  }
}

//Pas sur de celle-ci
Future<void> sending_data_to_random_api() async {
  final response = await http.post(
    //Uri.parse('https://JaipasdideesdURL.com'),
    Uri.parse('http://ptsv3.com/t/EPSISHOPC2/'),

    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{
        'total': '15.00',
        'adresse': '8 rue des fermetures de portes',
        'paiement': 'Visa',
      },
    ),
  );

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    throw Exception('Dommage');
  }
}


class CardRecap extends StatelessWidget {
  final String prixTotal;
  final String prixTVA;
  final String prixSousTotal;

  const CardRecap({
    required this.prixTotal,
    required this.prixTVA,
    required this.prixSousTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    "Récapitulatif de la commande",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              Row(
                children: [
                  const Text(
                    "Sous-total",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(prixSousTotal,
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    "Vous économisez",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    "0.00 €",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "TVA",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(prixTVA,
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "TOTAL",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(prixTotal,
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}


class CardAdresse extends StatelessWidget {
  const CardAdresse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return
    Column(
      children: [
        const Row(
          children: [
            Text("Adresse de livraison",
                style: TextStyle(fontWeight: FontWeight.bold)
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const SizedBox(
            width: double.infinity,
            height: 75,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Michel LE PONEYY",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "8 rue des fermetures de portes",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "93204 CORBEAUX",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}


class CardPayment extends StatefulWidget {
  const CardPayment({Key? key}) : super(key: key);

  @override
  _CardPayState createState() => _CardPayState();
}

class _CardPayState extends State<CardPayment> {

  int Index = -1;
  void _onCardPressed(int index) {
    setState(() {
      if (Index == index) {
        Index = -1;
      } else {
        Index = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Text("Méthode de paiement", style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(flex: 1),
          ],
        ),
        Row(
          children: [
            _cardBuilder(FontAwesomeIcons.ccApplePay, 0),
            _cardBuilder(FontAwesomeIcons.ccVisa, 1),
            _cardBuilder(FontAwesomeIcons.ccMastercard, 2),
            _cardBuilder(FontAwesomeIcons.ccPaypal, 3),
          ],
        ),
      ],
    );
  }

  Widget _cardBuilder(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        _onCardPressed(index);
      },
      child: badges.Badge(
        badgeContent: const Icon(
          Icons.check,
          size: 15,
          color: Colors.white,
        ),
        badgeAnimation: BadgeAnimation.rotation(),
        badgeStyle: badges.BadgeStyle(
          badgeColor: Theme.of(context).colorScheme.primary,
        ),
        position: BadgePosition.topEnd(top: -12, end: -12),
        showBadge: Index == index,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Index == index
                  ? Theme.of(context).colorScheme.primary
                  : Colors.black,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: SizedBox(
            width: 75,
            height: 75,
            child: Center(
              child: FaIcon(
                icon,
                size: 50,
                color: Index == index
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

