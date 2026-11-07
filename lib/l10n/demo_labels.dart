import 'package:flutter/widgets.dart';

import '../model/violation.dart';
import '../data/demo_data.dart';
import '../data/demo_store.dart';
import 'l10n_context.dart';

/// Runtime status: paying a fine marks it paid, and an appeal puts it in
/// dispute so it is no longer payable.
ViolationStatus effectiveStatus(Violation violation) {
  if (demoStore.paidFineIds.contains(violation.id)) {
    return ViolationStatus.paid;
  }
  if (demoStore.appeals.containsKey(violation.id)) {
    return ViolationStatus.disputed;
  }
  return violation.status;
}

String violationTitle(BuildContext context, Violation violation) =>
    switch (violation.id) {
      'red-light' => context.l10n.possibleRedLightViolation,
      'speeding' => context.l10n.speeding68KmHIn50Zone,
      'helmet' => context.l10n.noHelmet,
      'parking' => context.l10n.illegalParking,
      'wrong-way' => context.l10n.wrongWayDriving,
      'stop-line' => context.l10n.crossingStopLine,
      _ => violation.title,
    };

String vehicleTypeLabel(BuildContext context, String value) => switch (value) {
  'Car' => context.l10n.carLabel,
  'Motorcycle' => context.l10n.motorcycleLabel,
  _ => value,
};

String vehicleColourLabel(BuildContext context, String value) =>
    switch (value) {
      'Pearl white' => context.l10n.pearlWhite,
      'Black' => context.l10n.black,
      _ => value,
    };

String appealReasonLabel(BuildContext context, String value) => switch (value) {
  'Not my vehicle' => context.l10n.notMyVehicle,
  'Signal was green' => context.l10n.signalWasGreen,
  'Emergency' => context.l10n.emergency,
  'Wrong location' => context.l10n.wrongLocation,
  _ => value,
};

String paymentStatusLabel(BuildContext context, String value) =>
    switch (value) {
      'Paid' => context.l10n.paid,
      'Pending' => context.l10n.pending,
      'Failed' => context.l10n.failed,
      _ => value,
    };

String notificationPreferenceLabel(BuildContext context, String value) =>
    switch (value) {
      'New potential violations' => context.l10n.newPotentialViolations,
      'Official fine confirmed' => context.l10n.officialFineConfirmed,
      'Payment reminders' => context.l10n.paymentReminders,
      'Tips & news' => context.l10n.tipsNews,
      _ => value,
    };

String onboardingTitle(BuildContext context, int index) => switch (index) {
  0 => context.l10n.smartTrafficMonitoring,
  1 => context.l10n.instantViolationNotifications,
  2 => context.l10n.secureFineLicenceManagement,
  _ => '',
};

String onboardingDescription(BuildContext context, int index) =>
    switch (index) {
      0 => context.l10n.aiReviewsCctvFootageOnPublicRoads,
      1 => context.l10n.getAlertedWithVideoEvidenceLocationAnd,
      2 => context.l10n.reviewFinesAppealWhenSomethingLooksWrong,
      _ => '',
    };

String notificationTitle(BuildContext context, int index) => switch (index) {
  0 => context.l10n.newPotentialViolation,
  1 => context.l10n.officialFineConfirmed,
  2 => context.l10n.paymentReminder,
  3 => context.l10n.appealStatusUpdate,
  4 => context.l10n.paymentSuccessful,
  5 => context.l10n.licenceInformationUpdate,
  _ => demoNotifications[index].title,
};

String notificationMessage(BuildContext context, int index) => switch (index) {
  0 => context.l10n.aiFlaggedAPossibleRedLightEvent,
  1 => context.l10n.speedingFineOf150000IsReady,
  2 => context.l10n.label2FinesDueBy31Oct2026,
  3 => context.l10n.yourAppealForWrongWayDrivingWas,
  4 => context.l10n.receiptDemoRc08160042IsAvailable,
  5 => context.l10n.pointsServiceIsNotConnectedYet,
  _ => demoNotifications[index].message,
};

String notificationWhen(BuildContext context, int index) => switch (index) {
  0 => context.l10n.label2HAgo,
  1 || 2 => context.l10n.yesterday,
  3 => context.l10n.label3DAgo,
  _ => demoNotifications[index].when,
};
