import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wellness/core/ui/widgets/app_text_field.dart';

class DateTextField extends StatefulWidget {
  const DateTextField({super.key});

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2222),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(hintText: 'Select Date', readOnly: true, prefixIcon: Icon( Icons.calendar_month), controller: _dateController, onTap: ()=> _selectDate(context),);
  }
}
