import 'package:expense_tracker/features/presentation/blocs/user/user_display_cubit.dart';
import 'package:expense_tracker/features/presentation/blocs/user/user_display_state.dart';
import 'package:expense_tracker/features/presentation/pages/old/signup_page.dart';
import 'package:expense_tracker/features/presentation/pages/old/expense_pages/add_expense.dart';
import 'package:expense_tracker/features/presentation/widgets/button_cubit/button_cubit.dart';
import 'package:expense_tracker/features/presentation/widgets/button_cubit/button_state.dart';
import 'package:expense_tracker/features/presentation/widgets/custom_Drawer.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserDisplayCubit()..displayUser()),
          BlocProvider(create: (context) => ButtonStateCubit()),
        ],
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(),
                  ));
            }
          },
          child: BlocBuilder<UserDisplayCubit, UserDisplayState>(
              builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UserLoaded) {
              return Padding(
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
                    const Text('Spending Categories',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: ListView(
                        children: [
                          CategoryCard(
                              'Utilities', '\$547.84', 34, Colors.orange),
                          CategoryCard(
                              'Expenses', '\$194.29', 12, Colors.green),
                          CategoryCard('Payments', '\$348.0', 20, Colors.blue),
                          CategoryCard(
                              'Subscriptions', '\$96.52', 8, Colors.purple),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            if (state is LoadUserFailure) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return Container();
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddExpenseForm()));
        },
        child: const Icon(Icons.add),
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
        titleStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: 12,
        color: Colors.green,
        radius: 50,
        title: 'Expenses',
        titleStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: 20,
        color: Colors.blue,
        radius: 55,
        title: 'Payments',
        titleStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: 8,
        color: Colors.purple,
        radius: 45,
        title: 'Subscriptions',
        titleStyle: const TextStyle(
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

  const CategoryCard(this.title, this.amount, this.percentage, this.color,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: const Icon(Icons.category, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$amount | $percentage%'),
        trailing: Text('$percentage%'),
      ),
    );
  }
}
