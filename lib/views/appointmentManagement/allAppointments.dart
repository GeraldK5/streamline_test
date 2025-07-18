import 'package:flutter/material.dart';
import 'package:streamline_test/services/sqlflite.dart';
import 'package:streamline_test/models/Appointment.dart';
import 'package:streamline_test/views/appointmentManagement/appointmentDetails.dart';
import 'package:streamline_test/views/widgets/color_schemes.dart';

class Allappointments extends StatefulWidget {
  const Allappointments({Key? key}) : super(key: key);

  @override
  State<Allappointments> createState() => _AllappointmentsState();
}

class _AllappointmentsState extends State<Allappointments> {
  late Future<List<Appointment>> _appointmentsFuture;

  @override
  void initState() {
    super.initState();
    _appointmentsFuture = DatabaseHelper().getAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      appBar: AppBar(
        title: const Text('All Appointments'),
        backgroundColor: AppColors.success, // light green
        foregroundColor: AppColors.white,
      ),
      body: FutureBuilder<List<Appointment>>(
        future: _appointmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No appointments found.'));
          }

          final appointments = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          AppointmentDetailsPage(appointment: appointment),
                    ),
                  );
                },
                child: Card(
                  color: AppColors.white,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppColors.mediumGray),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${appointment.firstName} ${appointment.lastName}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Email: ${appointment.email}'),
                        // Text('Phone: ${appointment.phone}'),
                        // const SizedBox(height: 6),
                        // Text('Date: ${appointment.date}'),
                        // Text('Time: ${appointment.selectedTimeSlot}'),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
