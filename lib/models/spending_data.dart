import 'package:flutter/material.dart';                                  
import 'spending.dart';    
                                              
                                                                             
    class SpendingData {                                                     
      static double monthlyBudget = 500.0;                                   
                                                                             
      static List<Spending> spendings = [                                    
        Spending(name: "Restaurant", amount: 25, date: DateTime.now()),      
        Spending(name: "Supermarkt", amount: 50, date: DateTime.now().       
  subtract(const Duration(days: 1))),                                        
        Spending(name: "Kino", amount: 30, date: DateTime.now().             
  subtract(const Duration(days: 3))),                                        
      ];                                                                     
                                                                             
      // Berechnet die Gesamtausgaben                                        
      static double get totalSpent =>                                        
          spendings.fold(0.0, (sum, item) => sum + item.amount);             
                                                                             
      // Berechnet das verbleibende Restbudget                               
      static double get remainingBudget => monthlyBudget - totalSpent;       
    }                                            