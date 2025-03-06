import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/features/data/models/budget_model.dart';
import 'package:expense_tracker/features/presentation/blocs/budget/budget_bloc.dart';
import 'package:expense_tracker/features/presentation/blocs/budget/budget_event.dart';
import 'package:expense_tracker/features/presentation/blocs/budget/budget_state.dart';
import 'package:expense_tracker/core/constants/app_styles.dart';
import 'package:expense_tracker/features/domain/repositories/category_repository.dart';
import 'package:expense_tracker/locator.dart';
import 'package:intl/intl.dart';

class UpdateBudgetScreen extends StatefulWidget {
  final BudgetModel budget;

  const UpdateBudgetScreen({Key? key, required this.budget}) : super(key: key);

  @override
  State<UpdateBudgetScreen> createState() => _UpdateBudgetScreenState();
}

class _UpdateBudgetScreenState extends State<UpdateBudgetScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _amountController;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedCategory;

  bool _isLoading = false;
  late CategoryRepository _categoryRepository;
  List<Map<String, String>> _categories = [];

  @override
  void initState() {
    super.initState();
    _amountController =
        TextEditingController(text: widget.budget.amount.toString());
    _startDate = widget.budget.startDate;
    _endDate = widget.budget.endDate;
    _selectedCategory = widget.budget.categoryId;
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

  void _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  void _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    setState(() {
      _isLoading = false;
    });
  }

  void _updateBudget() {
    if (_formKey.currentState!.validate()) {
      if (_startDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a start date.')),
        );
        return;
      }
      if (_endDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select an end date.')),
        );
        return;
      }
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a category.')),
        );
        return;
      }
      final updatedBudget = BudgetModel(
          budgetId: widget.budget.budgetId,
          userId: widget.budget.userId,
          categoryId: _selectedCategory!,
          amount: double.parse(_amountController.text.trim()),
          startDate: _startDate!,
          endDate: _endDate!,
          createdAt: widget.budget.createdAt,
          updatedAt: widget.budget.updatedAt);

      context.read<BudgetBloc>().add(UpdateBudgetEvent(updatedBudget));
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Budget'),
      ),
      body: BlocListener<BudgetBloc, BudgetState>(
        listener: (context, state) {
          if (state is BudgetUpdatedState) {
            Navigator.pop(context);
          } else if (state is BudgetErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
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
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _amountController,
                      decoration: kTextFormFieldDecoration.copyWith(
                        labelText: 'Amount',
                      ),
                      keyboardType: TextInputType.number,
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
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Start Date",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                    TextFormField(
                      readOnly: true,
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
                          onPressed: () => _selectDate(context, true),
                          icon: Icon(Icons.calendar_month_outlined,
                              color: Colors.blueAccent),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 1.5,
                            color: Colors.blueAccent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 1.2,
                            color: Colors.grey[400]!,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.blue,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "End Date",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                    TextFormField(
                      readOnly: true,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: _endDate == null
                            ? "No Date Selected"
                            : 'Date: ${DateFormat.yMMMd().format(_endDate!)}',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600],
                        ),
                        prefixIcon: IconButton(
                          onPressed: () => _selectDate(context, false),
                          icon: Icon(Icons.calendar_month_outlined,
                              color: Colors.blueAccent),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 1.5,
                            color: Colors.blueAccent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 1.2,
                            color: Colors.grey[400]!,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.blue,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _updateBudget,
                      child: Text('Update Budget'),
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
