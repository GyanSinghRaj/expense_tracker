import 'package:expense_tracker/features/presentation/widgets/bloc/navigation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NavigationBloc extends Bloc<NavigationEvent, void> {
  NavigationBloc() : super(null) {
    on<NavigateToHome>((event, emit) {
      navigatorKey.currentState?.pushNamed('/home');
    });
    on<NavigateToProfile>((event, emit) {
      navigatorKey.currentState?.pushNamed('/profile');
    });
    on<NavigateToSettings>((event, emit) {
      navigatorKey.currentState?.pushNamed('/settings');
    });
    on<NavigateToBudgets>((event, emit) {
      navigatorKey.currentState?.pushNamed(
        '/budgets',
      );
    });
    on<NavigateToExpenses>((event, emit) {
      navigatorKey.currentState?.pushNamed('/expenses');
    });
    on<NavigateToReports>((event, emit) {
      navigatorKey.currentState?.pushNamed('/reports');
    });
    on<NavigateToAppearance>((event, emit) {
      navigatorKey.currentState?.pushNamed('/appearance');
    });
    on<NavigateToNotification>((event, emit) {
      navigatorKey.currentState?.pushNamed('/notifications');
    });
    on<NavigateToHelpSupports>((event, emit) {
      navigatorKey.currentState?.pushNamed('/helps');
    });
    on<NavigateToAbouts>((event, emit) {
      navigatorKey.currentState?.pushNamed('/abouts');
    });
    // on<NavigateToLogout>((event, emit) {
    //   navigatorKey.currentState?.pushNamed('/');
    // });
    ;
  }
}
