import 'package:expense_tracker/features/domain/usecases/user/log_out.dart';
import 'package:expense_tracker/features/presentation/blocs/user/user_display_cubit.dart';
import 'package:expense_tracker/features/presentation/blocs/user/user_display_state.dart';
import 'package:expense_tracker/features/presentation/pages/old/login_page.dart';
import 'package:expense_tracker/features/presentation/widgets/bloc/navigation_bloc.dart';
import 'package:expense_tracker/features/presentation/widgets/bloc/navigation_event.dart';
import 'package:expense_tracker/features/presentation/widgets/button_cubit/button_cubit.dart';
import 'package:expense_tracker/features/presentation/widgets/button_cubit/button_state.dart';
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
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(NavigateToHome());
                    Navigator.pop(context);
                  },
                ),
                _drawerItem(
                    icon: Icons.account_circle,
                    text: 'Profile',
                    onTap: () {
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigateToProfile());
                      Navigator.pop(context);
                    }),
                _drawerItem(
                    icon: Icons.account_balance_wallet,
                    text: 'Budget',
                    onTap: () {
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigateToBudgets());
                      Navigator.pop(context);
                    }),
                _drawerItem(
                    icon: Icons.receipt_long,
                    text: 'Expenses',
                    onTap: () {
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigateToExpenses());
                      Navigator.pop(context);
                    }),
                _drawerItem(
                    icon: FontAwesomeIcons.chartLine,
                    text: 'Reports',
                    onTap: () {
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigateToReports());
                      Navigator.pop(context);
                    }),
                Divider(),
                _drawerItem(
                    icon: Icons.palette,
                    text: 'Appearance',
                    onTap: () {
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigateToAppearance());
                      Navigator.pop(context);
                    }),
                _drawerItem(
                    icon: FontAwesomeIcons.userShield,
                    text: 'Settings & Privacy',
                    onTap: () {
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigateToSettings());
                      Navigator.pop(context);
                    }),
                _drawerItem(
                  icon: FontAwesomeIcons.bell,
                  text: 'Notifications',
                  onTap: () =>
                      Navigator.pushNamed(context, '/home', arguments: context),
                ),
                _drawerItem(
                    icon: FontAwesomeIcons.whatsapp,
                    text: 'Help & Support',
                    onTap: () {
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigateToHelpSupports());
                      Navigator.pop(context);
                    }),
                _drawerItem(
                    icon: Icons.info_outline,
                    text: 'About',
                    onTap: () {
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigateToAbouts());
                      Navigator.pop(context);
                    }),
                Divider(),
                _drawerItem(
                    icon: Icons.logout,
                    text: 'Logout',
                    color: Colors.red,
                    onTap: () {
                      _showLogoutDialog(context);
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
                // backgroundImage: AssetImage('assets/profile.jpg'),
                ),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.6),
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BlocListener<ButtonStateCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonSuccessState) {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          } else if (state is ButtonFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.errorMessage}')),
            );
          } else if (state is ButtonLoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(
                child: const CircularProgressIndicator(),
              ),
            );
          }
        },
        child: AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                context
                    .read<ButtonStateCubit>()
                    .execute(usecase: sl<LogoutUseCase>());
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
