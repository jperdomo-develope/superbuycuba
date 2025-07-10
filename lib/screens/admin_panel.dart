import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Panel de Administración")),
      body: const Center(
        child: Text("Aquí se mostrarán los pedidos y usuarios."),
      ),
    );
  }
}