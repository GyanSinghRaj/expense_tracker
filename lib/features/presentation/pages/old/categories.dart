import 'package:flutter/material.dart';
import 'package:expense_tracker/features/domain/repositories/category_repository.dart';
import 'package:expense_tracker/locator.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final TextEditingController _categoryController = TextEditingController();
  late CategoryRepository _categoryRepository;
  List<dynamic> _categories = [];
  bool _isLoading = false;

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
        _categories = response.data;
        _isLoading = false;
      }),
    );
  }

  Future<void> _addCategory() async {
    if (_categoryController.text.isEmpty) return;
    final categoryData = {
      'name': _categoryController.text,
    };
    final result = await _categoryRepository.addCategory(categoryData);
    result.fold(
      (error) => _showError(error),
      (response) {
        _categoryController.clear();
        _fetchCategories();
      },
    );
  }

  void _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Categories')),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Expanded(child: _buildCategoryList()),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildAddCategoryRow(),
                ),
              ],
            ),
    );
  }

  Widget _buildCategoryList() {
    return ListView.builder(
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            title: Text(
              _categories[index]['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(_categories[index]['_id']),
          ),
        );
      },
    );
  }

  Widget _buildAddCategoryRow() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _categoryController,
            decoration: const InputDecoration(
              labelText: 'New Category',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: _addCategory,
          child: const Text('Add'),
        ),
      ],
    );
  }

  // void _showAddCategoryDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Add New Category'),
  //         content: TextFormField(
  //           controller: _categoryController,
  //           decoration: const InputDecoration(
  //             labelText: 'Category Name',
  //             border: OutlineInputBorder(),
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               _addCategory();
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Add'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
