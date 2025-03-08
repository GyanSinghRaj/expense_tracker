class ApiUrls {
  // static const baseURL = 'http://192.168.100.126:8000/';
  static const baseURL = 'http://localhost:8000/';

  // static const baseURL = 'http://192.168.1.92:8000/';
  // static const baseURL = 'http://192.168.36.10:8000/';

  static const register = '${baseURL}api/users/register';
  static const userProfile = '${baseURL}api/users/profile';
  static const login = '${baseURL}api/users/login';

  static const createBudget = '${baseURL}api/budgets/';

  static const deleteBudget = '${baseURL}api/budgets/';
  static const updateBudget = '${baseURL}api/budgets/';

  static const getBudgets = '${baseURL}api/budgets/';

  static const getBudgetById = '${baseURL}api/budgets/';

  static const createExpense = '${baseURL}api/expenses/';

  static const deleteExpense = '${baseURL}api/expenses/';
  static const updateExpense = '${baseURL}api/expenses/';

  static const getExpenses = '${baseURL}api/expenses/';

  static const getExpenseById = '${baseURL}api/expenses/';
  static const getCategories = '${baseURL}api/categories/';
}
