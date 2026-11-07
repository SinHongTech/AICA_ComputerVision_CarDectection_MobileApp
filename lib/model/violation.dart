enum ViolationStatus {
  suspected,
  confirmed,
  underReview,
  disputed,
  resolved,
  paid,
}

class Violation {
  const Violation({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.plate,
    required this.reference,
    required this.status,
    this.amount = 0,
  });

  final String id;
  final String title;
  final String date;
  final String time;
  final String location;
  final String plate;
  final String reference;
  final ViolationStatus status;
  final int amount;
}
