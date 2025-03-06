// import 'package:expense_tracker/features/presentation/pages/old/budget/add_budget_page.dart';
// import 'package:expense_tracker/features/presentation/widgets/custom_Drawer.dart';
// import 'package:flutter/material.dart';

// class BudgetPage extends StatelessWidget {
//   final List<Map<String, dynamic>> budgets = [
//     {'name': 'Health', 'amount': '\$xxx'},
//     {'name': 'Education', 'amount': '\$xxx'},
//     {'name': 'Transportation', 'amount': '\$xxx'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.black87,
//       appBar: AppBar(
//         backgroundColor: Colors.black87,
//         title: const Text('Budget', style: TextStyle(color: Colors.white)),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => AddBudgetPage()),
//               );
//             },
//           ),
//         ],
//       ),
//       // drawer: CustomDrawer(),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.brown.shade100,
//                 ),
//                 onPressed: () {},
//                 child: const Text('Add', style: TextStyle(color: Colors.black)),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text('Total:   \$xxx',
//                 style: TextStyle(
//                     color: Color.fromARGB(255, 100, 82, 82), fontSize: 16)),
//             const SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: budgets.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     color: Colors.black54,
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     child: ListTile(
//                       leading: const Icon(Icons.circle_outlined,
//                           color: Colors.white),
//                       title: Text(budgets[index]['name'],
//                           style: const TextStyle(color: Colors.white)),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.edit, color: Colors.white),
//                             onPressed: () {},
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.delete, color: Colors.white),
//                             onPressed: () {},
//                           ),
//                           Text(budgets[index]['amount'],
//                               style: const TextStyle(color: Colors.white)),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
