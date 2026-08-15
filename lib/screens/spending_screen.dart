import 'package:flutter/material.dart';
import '../models/spending.dart';
import '../models/spending_data.dart';

class SpendingScreen extends StatefulWidget {
  const SpendingScreen({super.key});

  @override
  State<SpendingScreen> createState() => _SpendingScreenState();
}

class _SpendingScreenState extends State<SpendingScreen> {


  List<Spending> get spendings => SpendingData.spendings;
    double get monthlyBudget => SpendingData.monthlyBudget;
    double get totalSpent => SpendingData.totalSpent;
    double get remainingBudget => SpendingData.remainingBudget;


  // Fortschritt in Prozent (0.0 bis 1.0)
  double get progress => (totalSpent / monthlyBudget).clamp(0.0, 1.0);

  // Hilfsfunktion zur Datumsformatierung
  String formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return "$day.$month.${date.year}";
  }

  void openAddSpendingSheet() {        
        bool isRecurring = false;                  
        final nameController = TextEditingController();                      
        final amountController = TextEditingController();  

        // Standardmäßig ausgewählte Kategorie:                                                            
        SpendingCategory selectedCategory = SpendingCategory.food;         
                                                                             
        showModalBottomSheet(                                                
          context: context,                                                  
          isScrollControlled: true,                                          
          shape: const RoundedRectangleBorder(                               
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),   
          ),                                                                 
          builder: (context) {  
            return StatefulBuilder(                                                                              
            builder: (context, setModalState) {                                              
            return Padding(                                                  
              padding: EdgeInsets.only(                                      
                top: 20,                                                     
                left: 20,                                                    
                right: 20,                                                   
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,       
              ),                                                             
              child: Column(                                                 
                mainAxisSize: MainAxisSize.min,                              
                crossAxisAlignment: CrossAxisAlignment.stretch,              
                children: [                                                  
                  const Text(                                                
                    "Add new spending",                                
                    textAlign: TextAlign.center,                             
                    style: TextStyle(                                        
                      fontSize: 18,                                          
                      fontWeight: FontWeight.bold,                           
                    ),                                                       
                  ),                                                         
                  const SizedBox(height: 16),                                
                  TextField(                                                 
                    controller: nameController,                              
                    decoration: const InputDecoration(                       
                      labelText: "Description (e.g. Restaurant)",                
                      border: OutlineInputBorder(),                          
                    ),                                                       
                  ),                                                         
                  const SizedBox(height: 12),                                
                  TextField(                                                 
                    controller: amountController,                            
                    keyboardType: const TextInputType.                       
  numberWithOptions(decimal: true),                                          
                    decoration: const InputDecoration(                       
                      labelText: "amount in €",                              
                      border: OutlineInputBorder(),                          
                    ),                                                       
                  ),                                                         
                  const SizedBox(height: 16), 

                  DropdownButtonFormField<SpendingCategory>(                                           
                        value: selectedCategory,                                                           
                        decoration: const InputDecoration(                                                 
                          labelText: "Kategorie",                                                          
                          border: OutlineInputBorder(),                                                    
                        ),                                                                                 
                        items: SpendingCategory.values.map((cat) {                                         
                          return DropdownMenuItem(                                                         
                            value: cat,                                                                    
                            child: Text(cat.displayName),                                                  
                          );                                                                               
                        }).toList(),                                                                       
                        onChanged: (newValue) {                                                            
                          if (newValue != null) {                                                          
                            setModalState(() {                                                             
                              selectedCategory = newValue;                                                 
                            });                                                                            
                          }                                                                                
                        },                                                                                 
                      ),                                                                                   
                      const SizedBox(height: 16),

                  SwitchListTile(                                                                                        
                    contentPadding: EdgeInsets.zero,                                                                     
                    title: const Text("Fixed monthly expense"),                                                      
                    subtitle: const Text("E.g subscription, contract or rent"),                                               
                    value: isRecurring,                                                                                  
                    activeColor: Colors.deepPurple,                                                                      
                    onChanged: (val) {                                                                                   
                      setModalState(() {                                                                                 
                        isRecurring = val;                                                                               
                      });                                                                                                
                    },   
                  ),
                   const SizedBox(height: 16),

                  ElevatedButton(                                            
                    style: ElevatedButton.styleFrom(                         
                      backgroundColor: Colors.deepPurple,                    
                      foregroundColor: Colors.white,                         
                      padding: const EdgeInsets.symmetric(vertical: 14),     
                    ),                                                       
                    onPressed: () {                                          
                      final name = nameController.text.trim();               
                      final amount = double.tryParse(amountController.text.  
  replaceAll(',', '.')) ?? 0.0;                                              
                                                                             
                      if (name.isNotEmpty && amount > 0) {                   
                        setState(() {                                        
                          SpendingData.spendings.add(                        
                            Spending(                                        
                              name: name,                                    
                              amount: amount,                                
                              date: DateTime.now(), 
                              category: selectedCategory, 
                              isRecurring: isRecurring,                      
                            ),                                               
                          );                                                 
                        });                                                  
                        Navigator.pop(context);                              
                      }                                                      
                    },                                                       
                    child: const Text("Add", style:                   
  TextStyle(fontSize: 16)),                                                  
                  ),                                                         
                ], 
                ),                                                          
              );                                                            
            },                                                              
            );
          },                                                                
        );                                                                   
      }                                                                      
          

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Monthly Spendings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── 1. Budget-Übersichtskarte ganz oben ───
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Monthly Budget Left",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "€ ${remainingBudget.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Fortschrittsbalken
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Ausgegeben vs. Gesamtbudget
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Spent: € ${totalSpent.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        "Total: € ${monthlyBudget.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ─── 2. Überschrift ───
            const Text(
              "Your Spendings",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // ─── 3. Liste der Ausgaben ───
            Expanded(
              child: ListView.builder(
                itemCount: spendings.length,
                itemBuilder: (context, index) {
                  final spending = spendings[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Titel & Datum
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              spending.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${formatDate(spending.date)} • ${spending.category.displayName}",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),

                        // Roter abgezogener Betrag
                        Text(
                          "- € ${spending.amount.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    floatingActionButton: FloatingActionButton(                    
                backgroundColor: Colors.deepPurple,                          
                onPressed: openAddSpendingSheet,
                child: const Icon(Icons.add, color: Colors.white),           
              ), 
    );
  }
}
