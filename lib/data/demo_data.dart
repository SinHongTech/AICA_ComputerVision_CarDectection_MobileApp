import '../model/app_notification.dart';
import '../model/vehicle.dart';
import '../model/violation.dart';

const demoViolations = <Violation>[
  Violation(
    id: 'red-light',
    title: 'Possible red-light violation',
    date: '14 Oct 2026',
    time: '08:42',
    location: 'Norodom Blvd × Sihanouk Blvd',
    plate: '2AB-1234',
    reference: 'DEMO-AI-20261014-017',
    status: ViolationStatus.suspected,
  ),
  Violation(
    id: 'speeding',
    title: 'Speeding (68 km/h in 50 zone)',
    date: '09 Oct 2026',
    time: '17:15',
    location: 'Russian Federation Blvd',
    plate: '2AB-1234',
    reference: 'DEMO-FN-20261009-232',
    status: ViolationStatus.confirmed,
    amount: 150000,
  ),
  Violation(
    id: 'helmet',
    title: 'No helmet',
    date: '06 Oct 2026',
    time: '09:20',
    location: 'Monivong Blvd, Wat Phnom',
    plate: '1KH-5678',
    reference: 'DEMO-FN-20261006-118',
    status: ViolationStatus.confirmed,
    amount: 30000,
  ),
  Violation(
    id: 'parking',
    title: 'Illegal parking',
    date: '02 Oct 2026',
    time: '12:05',
    location: 'Street 240, Riverside',
    plate: '2AB-1234',
    reference: 'DEMO-AI-20261002-043',
    status: ViolationStatus.underReview,
  ),
  Violation(
    id: 'wrong-way',
    title: 'Wrong-way driving',
    date: '27 Sep 2026',
    time: '18:31',
    location: 'Street 63 × Street 278',
    plate: '1KH-5678',
    reference: 'DEMO-AP-20260927-061',
    status: ViolationStatus.disputed,
  ),
  Violation(
    id: 'stop-line',
    title: 'Crossing stop line',
    date: '15 Aug 2026',
    time: '10:12',
    location: 'Preah Monivong Blvd',
    plate: '2AB-1234',
    reference: 'DEMO-FN-20260815-042',
    status: ViolationStatus.resolved,
    amount: 50000,
  ),
];

const demoVehicles = <Vehicle>[
  Vehicle(
    name: 'Toyota Prius 2018',
    type: 'Car',
    plate: '2AB-1234',
    colour: 'Pearl white',
    year: 2018,
    expiry: '30 Jun 2027',
  ),
  Vehicle(
    name: 'Honda Click 125i',
    type: 'Motorcycle',
    plate: '1KH-5678',
    colour: 'Black',
    year: 2021,
    expiry: '22 Feb 2027',
  ),
];

const demoNotifications = <AppNotification>[
  AppNotification(
    title: 'New potential violation',
    message:
        'AI flagged a possible red-light event for 2AB-1234. Not yet a fine.',
    when: '2 h ago',
    violationId: 'red-light',
  ),
  AppNotification(
    title: 'Official fine confirmed',
    message: 'Speeding fine of 150,000 ៛ is ready for review.',
    when: 'Yesterday',
    violationId: 'speeding',
  ),
  AppNotification(
    title: 'Payment reminder',
    message: '2 fines due by 31 Oct 2026.',
    when: 'Yesterday',
  ),
  AppNotification(
    title: 'Appeal status update',
    message: 'Your appeal for wrong-way driving was received.',
    when: '3 d ago',
    violationId: 'wrong-way',
  ),
  AppNotification(
    title: 'Payment successful',
    message: 'Receipt DEMO-RC-0816-0042 is available.',
    when: '16 Aug',
  ),
  AppNotification(
    title: 'Licence information update',
    message: 'Points service is not connected yet.',
    when: '1 Aug',
  ),
];

Violation? violationById(String id) {
  for (final violation in demoViolations) {
    if (violation.id == id) return violation;
  }
  return null;
}

String riel(int amount) =>
    '${amount.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]},')} ៛';
