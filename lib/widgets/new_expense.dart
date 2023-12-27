import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  //   var _enteredTitle="";
  // void saveTitleInput(String inputValue){
  //    _enteredTitle=inputValue;
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  DateTime? _selectedDate;
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(2017, now.month, now.day);
    final lastDate = now;
    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: lastDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  Category _selectedCategory = Category.leisure;

  void _submitExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid input"),
                content: const Text(
                    'Please make sure a valid title , amount , date and category was entered ...'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("Okey"),
                  )
                ],
              ));
      return;
    } else {
      widget.onAddExpense(
        Expense(
            title: _titleController.text,
            amount: enteredAmount,
            date: _selectedDate!,
            category: _selectedCategory),
      );
             Navigator.pop(context);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Expanded(
        child: Column(
          children: [
            TextField(
              // onChanged: saveTitleInput,
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text("Title"),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      prefixText: "₹ ",
                      label: Text("Amount "),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedDate == null
                          ? "Date not selected"
                          : formatter.format(_selectedDate!)),
                      IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: _submitExpense,
                  child: const Text(
                    "Save Expense ",
                    
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
