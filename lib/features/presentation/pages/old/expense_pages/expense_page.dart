import 'package:expense_tracker/features/presentation/blocs/expense/expense_bloc.dart';
import 'package:expense_tracker/features/presentation/blocs/expense/expense_event.dart';
import 'package:expense_tracker/features/presentation/blocs/expense/expense_state.dart';
import 'package:expense_tracker/features/presentation/pages/old/expense_pages/expense_item.dart';
import 'package:expense_tracker/features/presentation/widgets/custom_Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  void initState() {
    super.initState();
    // Load expenses when the page is initialized
    context.read<ExpenseBloc>().add(LoadExpensesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = Navigator.pushNamed(context, '/add_expense');
              if (result == true) {
                if (context.mounted) {
                  context.read<ExpenseBloc>().add(LoadExpensesEvent());
                }
              }
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExpenseLoadedState) {
            if (state.expenses.isEmpty) {
              return const Center(child: Text('No expenses available.'));
            }
            return ListView.builder(
              itemCount: state.expenses.length,
              itemBuilder: (context, index) {
                final expense = state.expenses[index];
                return ExpenseItem(
                  expense: expense,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/expense_details',
                      arguments: expense,
                    );
                  },
                  onDelete: () {
                    (context)
                        .read<ExpenseBloc>()
                        .add(DeleteExpenseEvent(expense.expenseId));
                  },
                  onEdit: () {
                    Navigator.pushNamed(context, '/edit_expense',
                        arguments: expense);
                  },
                );
              },
            );
          } else if (state is ExpenseErrorState) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
