// import 'package:expense_tracker/features/expense/data/repositories/expense_repository_impl.dart';
import 'package:expense_tracker/features/expense/presentation/pages/custom_Drawer.dart';
import 'package:expense_tracker/features/expense/presentation/widget/add_expense.dart';
import 'package:expense_tracker/features/expense/presentation/widget/custom_expense_card.dart';
import 'package:expense_tracker/features/user/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';

class ExpensePage extends StatefulWidget {
  // final ExpenseRepositoryImpl expenseRepository;
  const ExpensePage({
    super.key,
  });

  @override
  State<ExpensePage> createState() => ExpensePageState();
}

class ExpensePageState extends State<ExpensePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.4),
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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("October"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_circle_left_outlined)),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_circle_right_outlined)),
                  ],
                ),
                Text("\$4000"),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(100),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text(
                                "Monthly Budget",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            Text(
                              "\$2000",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.brown[300]),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              "80%",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: LinearProgressIndicator(
                            value: 0.8,
                            backgroundColor: Colors.brown[100],
                            valueColor: AlwaysStoppedAnimation(Colors.brown),
                            minHeight: 6,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(40)),
                          ),
                          child: Column(
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Row(
                              //     children: [
                              //       TextButton(
                              //           onPressed: () {},
                              //           child: Text(
                              //             "Expenses",
                              //             style: TextStyle(
                              //                 fontWeight: FontWeight.bold,
                              //                 fontSize: 18,
                              //                 color: Colors.black),
                              //           )),
                              //       TextButton(
                              //           onPressed: () {},
                              //           child: Text("Budget",
                              //            style: TextStyle(
                              //                 fontWeight: FontWeight.bold,
                              //                 fontSize: 18,
                              //                 color: Colors.black),)),
                              //       Spacer(),
                              //       IconButton(
                              //           onPressed: () {},
                              //           icon: Icon(Icons.filter_list_alt)),

                              //     ],
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Expense',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Text(
                                          'Budgets',
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignUpPage()));
                                        },
                                        icon: Icon(Icons.filter_list_alt))
                                  ],
                                ),
                              ),

                              // Custom Card
                              CustomExpenseCard(
                                  icon: Icons.shopping_cart,
                                  title: "Shops",
                                  subtitle: "46% of Budget",
                                  amount: "\$20000",
                                  transactions: "15 transactions")
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddExpense(expenseRepository: expensere,)));
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
