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

}
