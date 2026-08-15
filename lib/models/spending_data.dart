import 'package:flutter/material.dart';                                  
import 'spending.dart';    
                                              
                                                                             
    class SpendingData {                                                     
      static double monthlyBudget = 500.0;                                   
                                                                             
      static List<Spending> spendings = [                                    
        Spending(name: "Restaurant", amount: 25, date: DateTime.now(), category: SpendingCategory.food),      
        Spending(name: "Supermarkt", amount: 50, date: DateTime.now().       
  subtract(const Duration(days: 1)), category: SpendingCategory.food),                                        
        Spending(name: "Kino", amount: 30, date: DateTime.now().             
  subtract(const Duration(days: 3)), category: SpendingCategory.leisure),                                        
      ];       

      // Wiederkehrende Kosten filtern                                                                       
    static List<Spending> get recurringSpendings =>                                                        
        spendings.where((s) => s.isRecurring).toList();                                                    
                                                                                                           
    // Summe aller Fixkosten                                                                               
    static double get totalRecurring =>                                                                    
        recurringSpendings.fold(0.0, (sum, item) => sum + item.amount);                                    
                                                                                                           
    // Wie viel Prozent des Budgets sind durch Fixkosten gebunden?                                         
    static double get fixedBudgetPercentage =>                                                             
        monthlyBudget > 0 ? (totalRecurring / monthlyBudget) * 100 : 0;                                                               
                                                                             
      // Berechnet die Gesamtausgaben                                        
      static double get totalSpent =>                                        
          spendings.fold(0.0, (sum, item) => sum + item.amount);             
                                                                             
      // Berechnet das verbleibende Restbudget                               
      static double get remainingBudget => monthlyBudget - totalSpent;    

      // Berechnet die Summe für jede Kategorie (für das Tortendiagramm)
      static Map<SpendingCategory, double> get categoryTotals {
        final Map<SpendingCategory, double> map = {};
        for (var spending in spendings) {
          map[spending.category] = (map[spending.category] ?? 0.0) + spending.amount;
        }
        return map;
      }   
    }                                            