import 'package:flutter/material.dart';

class Spending {
    String name;
    double amount;
    DateTime date;
    SpendingCategory category;
    bool isRecurring;


    Spending({
        required this.name,
        required this.amount,
        required this.date,
        this.category = SpendingCategory.other,
        this.isRecurring = false,
    });
}

enum SpendingCategory{
    food,
    shopping,
    leisure,
    subscriptions, 
    donations,
    other;

    String get displayName {
        switch (this) {
        case SpendingCategory.food:
            return 'Food & Drink';
        case SpendingCategory.shopping:
            return 'Shopping';
        case SpendingCategory.leisure:
            return 'Leisure';
        case SpendingCategory.subscriptions:
            return 'Subscriptions & Bills';
        case SpendingCategory.donations:
            return 'Donations';
        case SpendingCategory.other:
            return 'Other';
        }
        }
        Color get color {                                                                                    
        switch (this) {                                                                                    
          case SpendingCategory.food:                                                                      
            return const Color(0xFFF59E0B); // Warm Orange                                                 
          case SpendingCategory.shopping:                                                                  
            return const Color(0xFFEC4899); // Rose Pink                                                   
          case SpendingCategory.leisure:                                                                   
            return const Color(0xFF8B5CF6); // Purple                                                      
          case SpendingCategory.subscriptions:                                                             
            return const Color(0xFF3B82F6); // Blue                                                        
          case SpendingCategory.donations:                                                                 
            return const Color(0xFFEF4444); // Red                                                         
          case SpendingCategory.other:                                                                     
            return const Color(0xFF64748B); // Slate Grey                                                  
        } 
    }

}

      




