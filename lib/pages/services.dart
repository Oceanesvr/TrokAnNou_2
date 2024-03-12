import 'package:flutter/material.dart';
import '/Components/button.dart';
import '/Components/colors.dart';
import '/JSON/usager.dart';
import '/pages/connect.dart';
class ServicesPage extends StatelessWidget {
  final String? prenom;

  const ServicesPage({Key? key, this.prenom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bonjour $prenom",
                  style: TextStyle(fontSize: 28, color: primaryColor),
                ),
                // Ajoutez d'autres fonctionnalités ici
              ],
            ),
          ),
        ),
      ),
    );
  }
}
