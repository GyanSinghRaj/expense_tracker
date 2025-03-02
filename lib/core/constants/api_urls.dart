class ApiUrls {
  static const baseURL = 'http://192.168.100.126:8000/';

  // static const baseURL = 'http://192.168.1.85:8000/';
  // static const baseURL = 'http://192.168.100.126:8000/';

  static const register = '${baseURL}api/users/register';
  static const userProfile = '${baseURL}api/users/profile';
  static const login = '${baseURL}api/users/login';

  static const createBudget = '${baseURL}api/Budgets/';

  static const deleteBudget = '${baseURL}api/Budgets/';
  static const updateBudget = '${baseURL}api/Budgets/';

  static const getBudgets = '${baseURL}api/Budgets/';

  static const getBudgetById = '${baseURL}api/Budgets/';

  static const createExpense = '${baseURL}api/Expenses/';

  static const deleteExpense = '${baseURL}api/Expenses/';
  static const updateExpense = '${baseURL}api/Expenses/';

  static const getExpenses = '${baseURL}api/Expenses/';

  static const getExpenseById = '${baseURL}api/Expenses/';
}
