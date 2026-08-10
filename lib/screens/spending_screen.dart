import 'package:flutter/material.dart';
import '../models/spending.dart';

class SpendingScreen extends StatefulWidget {
  const SpendingScreen({super.key});

  @override
  State<SpendingScreen> createState() => _SpendingScreenState();
}

class _SpendingScreenState extends State<SpendingScreen> {
    final List<Spending> spendings = [
        Spending(name: "Restaurant", amount: 25),
        Spending(name: "Supermarkt", amount: 50),
        Spending(name: "Kino", amount: 30),
];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Monthly Spendings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Your Spendings",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: spendings.length,
                    itemBuilder: (context, index){
                        final spending = spendings[index];

                        return ListTile(
                           title: Text(
                            spending.name,
                            style:const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                            ), ),
                            trailing: Text("€ ${spending.amount}",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                            ), 
                        ),);
                    },
                ),
            ),
          ],
        ),
      ),
    );
  }
}
