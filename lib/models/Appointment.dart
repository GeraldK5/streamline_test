class Appointment {
  int? id;
  String firstName;
  String lastName;
  String email;
  String phone;
  DateTime date;
  String selectedTimeSlot;

  Appointment({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.date,
    required this.selectedTimeSlot,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'date': date.toIso8601String(),
      'time_slot': selectedTimeSlot,
    };
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      date: DateTime.parse(json['date']),
      selectedTimeSlot: json['time_slot'],
    );
  }
}
