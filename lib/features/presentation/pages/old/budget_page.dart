import 'package:expense_tracker/features/presentation/blocs/budget/budget_bloc.dart';
import 'package:expense_tracker/features/presentation/blocs/budget/budget_event.dart';
import 'package:expense_tracker/features/presentation/blocs/budget/budget_state.dart';
import 'package:expense_tracker/features/presentation/pages/old/budget/add_budget_page.dart';
import 'package:expense_tracker/features/presentation/pages/old/budget/budget_details.dart';
import 'package:expense_tracker/features/presentation/pages/old/budget/budget_item.dart';
import 'package:expense_tracker/features/presentation/widgets/custom_Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  @override
  void initState() {
    super.initState();
    // Load budgets when the page is initialized
    context.read<BudgetBloc>().add(LoadBudgetsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BudgetPages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddBudgetPage()),
              );
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: BlocBuilder<BudgetBloc, BudgetState>(
        builder: (context, state) {
          if (state is BudgetLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BudgetLoadedState) {
            if (state.budgets.isEmpty) {
              return const Center(child: Text('No budgets available.'));
            }
            return ListView.builder(
              itemCount: state.budgets.length,
              itemBuilder: (context, index) {
                final budget = state.budgets[index];
                return BudgetItem(
                  budget: budget,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BudgetDetailScreen(budget: budget)));
                  },
                  onDelete: () {
                    context
                        .read<BudgetBloc>()
                        .add(DeleteBudgetEvent(budget.budgetId));
                  },
                  onEdit: () {
                    Navigator.pushNamed(context, '/edit_budget',
                        arguments: budget);
                  },
                );
              },
            );
          } else if (state is BudgetErrorState) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
