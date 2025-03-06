import 'package:expense_tracker/core/constants/app_styles.dart';
import 'package:expense_tracker/features/data/models/expense_model.dart';
import 'package:expense_tracker/features/presentation/blocs/expense/expense_bloc.dart';
import 'package:expense_tracker/features/presentation/blocs/expense/expense_event.dart';
import 'package:expense_tracker/features/presentation/blocs/expense/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:expense_tracker/features/domain/repositories/category_repository.dart';
import 'package:expense_tracker/locator.dart';
import 'dart:io';

class AddExpenseForm extends StatefulWidget {
  @override
  _AddExpenseFormState createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime? _selectedDate;
  String? _selectedCategory;
  late CategoryRepository _categoryRepository;
  List<Map<String, String>> _categories = [];
  bool _isLoading = false;
  File? _image;
  final picker = ImagePicker();

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
            'expenseId': category['_id'] as String,
          };
        }).toList();
        _isLoading = false;
      }),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected')),
      );
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      const userId = "sdafhkjsaf";
      final expenseId = const Uuid().v4();
      if (_selectedDate == null) {
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
      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select an image.')),
        );
        return;
      }
      final newExpense = ExpenseModel(
          expenseId: expenseId,
          userId: userId,
          categoryId: _selectedCategory!,
          amount: double.parse(_amountController.text),
          date: _selectedDate!,
          description: _descriptionController.text.trim(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          billImage: _image!.path);

      context.read<ExpenseBloc>().add(AddExpenseEvent(newExpense));

      setState(() {
        _selectedDate = null;
        _selectedCategory = null;
        _amountController.clear();
        _descriptionController.clear();
      });
      Navigator.pop(context);
    }
  }

  void _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    setState(() {
      _isLoading = false;
    });
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'New Expense',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          backgroundColor: Colors.blue.withOpacity(0.4),
          actions: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.4),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Text(
                "Budget:\$4000",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ],
        ),
        body: BlocListener<ExpenseBloc, ExpenseState>(
          listener: (context, state) {
            if (state is ExpenseAddedState) {
              Navigator.pop(context);
            }
            if (state is ExpenseErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.message}')));
            }
          },
          child: BlocBuilder<ExpenseBloc, ExpenseState>(
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
                      // Title Field
                      TextFormField(
                        controller: _descriptionController,
                        decoration: kTextFormFieldDecoration.copyWith(
                            labelText: "Description"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title.';
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

                      // Category Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        items: _categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category['expenseId'],
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
                          hintText: _selectedDate == null
                              ? "No Date Selected"
                              : 'Date: ${DateFormat.yMMMd().format(_selectedDate!)}',
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
                              color: Colors
                                  .grey[400]!, // Grey border when inactive
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _image != null
                              ? Image.file(
                                  _image!,
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  height: 130,
                                  width: 130,
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.image,
                                    size: 100,
                                    color: Colors.grey[600],
                                  ),
                                ),
                          SizedBox(height: 20),
                          ElevatedButton.icon(
                            icon: Icon(Icons.photo_library),
                            label: Text('Pick from Gallery'),
                            onPressed: () => _pickImage(ImageSource.gallery),
                          ),
                          ElevatedButton.icon(
                            icon: Icon(Icons.camera_alt),
                            label: Text('Take a Photo'),
                            onPressed: () => _pickImage(ImageSource.camera),
                          ),
                        ],
                      ),

                      SizedBox(height: 16),

                      // Submit Button
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Add Expense'),
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
        ));
  }
}
