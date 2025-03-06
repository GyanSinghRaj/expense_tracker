import 'package:expense_tracker/features/domain/usecases/user/log_out.dart';
import 'package:expense_tracker/features/presentation/blocs/user/user_display_cubit.dart';
import 'package:expense_tracker/features/presentation/blocs/user/user_display_state.dart';
import 'package:expense_tracker/features/presentation/pages/old/budget_page.dart';
import 'package:expense_tracker/features/presentation/pages/old/categories.dart';
import 'package:expense_tracker/features/presentation/pages/old/expense_pages/expense_page.dart';
import 'package:expense_tracker/features/presentation/pages/old/home_page.dart';
import 'package:expense_tracker/features/presentation/pages/old/login_page.dart';
import 'package:expense_tracker/features/presentation/widgets/button_cubit/button_cubit.dart';
import 'package:expense_tracker/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _drawerItem(
                  icon: Icons.home,
                  text: 'Home',
                  onTap: () => _navigateTo(context, '/home'),
                ),
                _drawerItem(
                  icon: Icons.account_circle,
                  text: 'Profile',
                  onTap: () => _navigateTo(context, '/profile'),
                ),
                _drawerItem(
                  icon: Icons.account_balance_wallet,
                  text: 'Budget',
                  onTap: () => _navigateTo(context, '/budget'),
                ),
                _drawerItem(
                  icon: Icons.receipt_long,
                  text: 'Expenses',
                  onTap: () =>
                      _navigateTo(context, '/expenses', isExpense: true),
                ),
                _drawerItem(
                  icon: FontAwesomeIcons.chartLine,
                  text: 'Reports',
                  onTap: () => _navigateTo(context, '/reports'),
                ),
                Divider(),
                _drawerItem(
                  icon: Icons.palette,
                  text: 'Appearance',
                  onTap: () => _navigateTo(context, '/appearance'),
                ),
                _drawerItem(
                  icon: FontAwesomeIcons.userShield,
                  text: 'Settings & Privacy',
                  onTap: () => _navigateTo(context, '/settings'),
                ),
                _drawerItem(
                  icon: FontAwesomeIcons.bell,
                  text: 'Notifications',
                  onTap: () => _navigateTo(context, '/notifications'),
                ),
                _drawerItem(
                  icon: FontAwesomeIcons.whatsapp,
                  text: 'Help & Support',
                  onTap: () => _navigateTo(context, '/help'),
                ),
                _drawerItem(
                  icon: Icons.info_outline,
                  text: 'About',
                  onTap: () => _navigateTo(context, '/about'),
                ),
                Divider(),
                _drawerItem(
                    icon: Icons.logout,
                    text: 'Logout',
                    color: Colors.red,
                    onTap: () {
                      context
                          .read<ButtonStateCubit>()
                          .excute(usecase: sl<LogoutUseCase>());
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return BlocBuilder<UserDisplayCubit, UserDisplayState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const CircularProgressIndicator();
        }
        if (state is UserLoaded) {
          return UserAccountsDrawerHeader(
            accountName: Text(
              state.userModel.username,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: Text(state.userModel.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.6),
              image: DecorationImage(
                image: AssetImage('assets/drawer_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          );
        }
        if (state is LoadUserFailure) {
          return Text(
            state.errorMessage,
            style: TextStyle(color: Colors.red),
          );
        }
        return Container();
      },
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color color = Colors.blue,
  }) {
    return ListTile(
      leading: FaIcon(icon, color: color),
      title: Text(text, style: TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }

  void _navigateTo(BuildContext context, String route,
      {bool isExpense = false}) {
    Navigator.pop(context);
    switch (route) {
      case '/home':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      case '/profile':
      case '/budget':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BudgetPage()));
      case '/reports':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoriesPage()),
        );
      case '/appearance':
      case '/settings':
      case '/notifications':
      case '/help':
      case '/about':
        Navigator.pushNamed(context, route);
        break;
      case '/expenses':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExpensePage()),
        );
        break;
      default:
        Navigator.pushNamed(context, '/home');
        break;
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
