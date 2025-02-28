
import 'package:expense_tracker/features/presentation/widgets/add_expense.dart';
import 'package:expense_tracker/features/presentation/widgets/custom_Drawer.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.4),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: const Text("Expenses"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddExpenseForm()));
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: _getSections(),
                  centerSpaceRadius: 70,
                  sectionsSpace: 2,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Spending Categories',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView(
                children: [
                  CategoryCard('Utilities', '\$547.84', 34, Colors.orange),
                  CategoryCard('Expenses', '\$194.29', 12, Colors.green),
                  CategoryCard('Payments', '\$348.0', 20, Colors.blue),
                  CategoryCard('Subscriptions', '\$96.52', 8, Colors.purple),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  List<PieChartSectionData> _getSections() {
    return [
      PieChartSectionData(
        value: 34,
        color: Colors.orange,
        radius: 60,
        title: 'Utilities',
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: 12,
        color: Colors.green,
        radius: 50,
        title: 'Expenses',
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: 20,
        color: Colors.blue,
        radius: 55,
        title: 'Payments',
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: 8,
        color: Colors.purple,
        radius: 45,
        title: 'Subscriptions',
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String amount;
  final int percentage;
  final Color color;

  CategoryCard(this.title, this.amount, this.percentage, this.color);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(Icons.category, color: Colors.white),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('\$$amount | $percentage%'),
        trailing: Text('$percentage%'),
      ),
    );
  }
}
