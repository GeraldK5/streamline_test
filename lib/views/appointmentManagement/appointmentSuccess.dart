import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:streamline_test/views/main/homeScreen.dart';
import 'package:streamline_test/views/widgets/color_schemes.dart';
import 'package:streamline_test/models/Appointment.dart';

class AppointmentSuccessPage extends StatelessWidget {
  final Appointment appointment;

  const AppointmentSuccessPage({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  String formatDateTime(DateTime date, String timeString) {
    try {
      final dateTime = DateTime.parse(
          '${DateFormat('yyyy-MM-dd').format(date)} $timeString');
      final dateFormat = DateFormat('MMMM dd, yyyy');
      final timeFormat = DateFormat('hh:mm a');
      return '${dateFormat.format(dateTime)} at ${timeFormat.format(dateTime)}';
    } catch (e) {
      return '${DateFormat('MMMM dd, yyyy').format(date)} at $timeString';
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDateTime =
        formatDateTime(appointment.date, appointment.selectedTimeSlot);

    final lottieAnimation = Lottie.asset(
      'assets/animations/success.json',
      width: 200,
      height: 200,
      repeat: true,
    );

    final successTitle = const Text(
      'Appointment Booked!',
      style: TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );

    final requestConfirmation = Text(
      'Your appointment for ${appointment.firstName} ${appointment.lastName} has been successfully scheduled.',
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    );

    final appointmentTimeContainer = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkBackground.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryGreen,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Appointment Date & Time',
            style: TextStyle(
              color: AppColors.primaryGreen,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            formattedDateTime,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );

    final reminderInfo = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryGreen.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: AppColors.primaryGreen,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'You will receive a reminder notification 24 hours before your appointment.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );

    final homeButton = ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryGreen,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        'Back to Home',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Animate(
                child: lottieAnimation,
                effects: [
                  FadeEffect(duration: 800.milliseconds),
                  MoveEffect(
                    begin: const Offset(0, 50),
                    end: const Offset(0, 0),
                    duration: 800.milliseconds,
                    curve: Curves.easeOutQuad,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Animate(
                child: successTitle,
                effects: [
                  FadeEffect(
                    delay: 300.milliseconds,
                    duration: 600.milliseconds,
                  ),
                  MoveEffect(
                    begin: const Offset(0, 30),
                    end: const Offset(0, 0),
                    delay: 300.milliseconds,
                    duration: 600.milliseconds,
                    curve: Curves.easeOutQuad,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Animate(
                child: requestConfirmation,
                effects: [
                  FadeEffect(
                    delay: 500.milliseconds,
                    duration: 600.milliseconds,
                  ),
                  MoveEffect(
                    begin: const Offset(0, 30),
                    end: const Offset(0, 0),
                    delay: 500.milliseconds,
                    duration: 600.milliseconds,
                    curve: Curves.easeOutQuad,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Animate(
                child: appointmentTimeContainer,
                effects: [
                  FadeEffect(
                    delay: 700.milliseconds,
                    duration: 600.milliseconds,
                  ),
                  MoveEffect(
                    begin: const Offset(0, 30),
                    end: const Offset(0, 0),
                    delay: 700.milliseconds,
                    duration: 600.milliseconds,
                    curve: Curves.easeOutQuad,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Animate(
                child: reminderInfo,
                effects: [
                  FadeEffect(
                    delay: 900.milliseconds,
                    duration: 600.milliseconds,
                  ),
                  MoveEffect(
                    begin: const Offset(0, 30),
                    end: const Offset(0, 0),
                    delay: 900.milliseconds,
                    duration: 600.milliseconds,
                    curve: Curves.easeOutQuad,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Animate(
                child: homeButton,
                effects: [
                  FadeEffect(
                    delay: 1100.milliseconds,
                    duration: 600.milliseconds,
                  ),
                  MoveEffect(
                    begin: const Offset(0, 30),
                    end: const Offset(0, 0),
                    delay: 1100.milliseconds,
                    duration: 600.milliseconds,
                    curve: Curves.easeOutQuad,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
