import 'package:flutter/material.dart';

class PaymentSelector extends StatefulWidget {
  final Function(String) onSelected;

  const PaymentSelector({required this.onSelected, super.key});

  @override
  State<PaymentSelector> createState() => _PaymentSelectorState();
}

class _PaymentSelectorState extends State<PaymentSelector> {
  String selected = 'Efectivo al recibir';

  final List<String> options = [
    'Efectivo al recibir',
    'Transferencia bancaria',
    'Tarjeta de crédito',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Selecciona el método de pago:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ...options.map((option) => RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: selected,
              onChanged: (value) {
                if (value != null) {
                  setState(() => selected = value);
                  widget.onSelected(value);
                }
              },
            )),
      ],
    );
  }
}