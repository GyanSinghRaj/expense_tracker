import 'package:expense_tracker/core/constants/app_styles.dart';
import 'package:expense_tracker/features/data/models/budget_model.dart';
import 'package:expense_tracker/features/domain/repositories/category_repository.dart';
import 'package:expense_tracker/features/presentation/blocs/budget/budget_bloc.dart';
import 'package:expense_tracker/features/presentation/blocs/budget/budget_event.dart';
import 'package:expense_tracker/features/presentation/blocs/budget/budget_state.dart';
import 'package:expense_tracker/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddBudgetPage extends StatefulWidget {
  @override
  _AddBudgetPageState createState() => _AddBudgetPageState();
}

class _AddBudgetPageState extends State<AddBudgetPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  // final TextEditingController _Controller = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedCategory;

  bool _isLoading = false;
  late CategoryRepository _categoryRepository;
  List<Map<String, String>> _categories = [];

  @override
  void initState() {
    super.initState();
    _categoryRepository = sl<CategoryRepository>();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    setState(() {
      _isLoading = true;
    });
    final result = await _categoryRepository.getCategories();
    result.fold(
      (error) => _showError(error),
      (response) => setState(() {
        _categories = response.data.map<Map<String, String>>((category) {
          return {
            'name': category['name'] as String,
            'id': category['_id'] as String,
          };
        }).toList();
        _isLoading = false;
      }),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _startDate) {
      setState(() {
        _startDate = pickedDate;
      });
    }
  }

  void _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    setState(() {
      _isLoading = false;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      const userId = "sdafhkjsaf";
      final budgetId = const Uuid().v4();
      if (_startDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a date.')),
        );
        return;
      }
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a category.')),
        );
        return;
      }
      final newBudget = BudgetModel(
          userId: userId,
          amount: double.parse(_amountController.text),
          budgetId: budgetId,
          startDate: _startDate!,
          endDate: _startDate!,
          categoryId: _selectedCategory!,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now());
      context.read<BudgetBloc>().add(AddBudgetEvent(newBudget));

      setState(() {
        _amountController.clear();
      });
      // Navigator.pushNamed(context, '/');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'New Budget',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        backgroundColor: Colors.blue.withOpacity(0.4),
      ),
      body: BlocListener<BudgetBloc, BudgetState>(
        listener: (context, state) {
          if (state is BudgetAddedState) {
            Navigator.pop(context);
          }
          if (state is BudgetErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')));
          }
        },
        child: BlocBuilder<BudgetBloc, BudgetState>(
          builder: (context, state) {
            if (_isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // Category Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      items: _categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category['id'],
                          child: Text(category['name']!),
                        );
                      }).toList(),
                      decoration: kTextFormFieldDecoration.copyWith(
                          labelText: "Category"),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a category.';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 12),

                    // Amount Field
                    TextFormField(
                      controller: _amountController,
                      decoration: kTextFormFieldDecoration.copyWith(
                        labelText: 'Amount',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Start Date",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                    TextFormField(
                      readOnly:
                          true, // Prevents manual input, forcing date picker use
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: _startDate == null
                            ? "No Date Selected"
                            : 'Date: ${DateFormat.yMMMd().format(_startDate!)}',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600],
                        ),
                        prefixIcon: IconButton(
                          onPressed: () => _selectDate(context),
                          icon: Icon(Icons.calendar_month_outlined,
                              color: Colors.blueAccent),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200], // Light background
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 1.5,
                            color:
                                Colors.blueAccent, // Blue border when focused
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 1.2,
                            color:
                                Colors.grey[400]!, // Grey border when inactive
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.blue, // Bright border on focus
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                      ),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "End Date",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                    TextFormField(
                      readOnly:
                          true, // Prevents manual input, forcing date picker use
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: _endDate == null
                            ? "No Date Selected"
                            : 'Date: ${DateFormat.yMMMd().format(_startDate!)}',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600],
                        ),
                        prefixIcon: IconButton(
                          onPressed: () => _selectDate(context),
                          icon: Icon(Icons.calendar_month_outlined,
                              color: Colors.blueAccent),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200], // Light background
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 1.5,
                            color:
                                Colors.blueAccent, // Blue border when focused
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 1.2,
                            color:
                                Colors.grey[400]!, // Grey border when inactive
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.blue, // Bright border on focus
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Submit Button
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Add Budget'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        textStyle: TextStyle(fontSize: 16),
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
