import 'package:flutter/material.dart';
import 'package:streamline_test/services/sqlflite.dart';
import 'package:streamline_test/models/Appointment.dart';
import 'package:streamline_test/views/widgets/color_schemes.dart';

class AppointmentDetailsPage extends StatefulWidget {
  final Appointment appointment;

  const AppointmentDetailsPage({super.key, required this.appointment});

  @override
  State<AppointmentDetailsPage> createState() => _AppointmentDetailsPageState();
}

class _AppointmentDetailsPageState extends State<AppointmentDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.appointment.firstName);
    _lastNameController =
        TextEditingController(text: widget.appointment.lastName);
    _emailController = TextEditingController(text: widget.appointment.email);
    _phoneController = TextEditingController(text: widget.appointment.phone);
  }

  void _updateAppointment() async {
    if (_formKey.currentState!.validate()) {
      Appointment updated = Appointment(
        id: widget.appointment.id,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        date: widget.appointment.date,
        selectedTimeSlot: widget.appointment.selectedTimeSlot,
      );
      await dbHelper.updateAppointment(updated);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment updated!')),
      );
      Navigator.pop(context, true); // Refresh on return
    }
  }

  void _cancelAppointment() async {
    await dbHelper.deleteAppointment(widget.appointment.id!);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Appointment canceled.')),
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
        backgroundColor: AppColors.primaryGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty || !value.contains('@')
                    ? 'Enter a valid email'
                    : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              Text('Date: ${widget.appointment.date}'),
              Text('Time: ${widget.appointment.selectedTimeSlot}'),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _updateAppointment,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGreen),
                      child: const Text('Update', style: TextStyle(color: AppColors.white)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _cancelAppointment,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error),
                      child: const Text('Cancel Appointment', style: TextStyle(color: AppColors.white)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
