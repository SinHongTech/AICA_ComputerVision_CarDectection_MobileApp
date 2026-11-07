import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_km.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('km'),
  ];

  /// No description provided for @violationDetails.
  ///
  /// In en, this message translates to:
  /// **'Violation details'**
  String get violationDetails;

  /// No description provided for @appeal.
  ///
  /// In en, this message translates to:
  /// **'Appeal'**
  String get appeal;

  /// No description provided for @appealOrDispute.
  ///
  /// In en, this message translates to:
  /// **'Appeal or dispute'**
  String get appealOrDispute;

  /// No description provided for @payFine.
  ///
  /// In en, this message translates to:
  /// **'Pay Fine'**
  String get payFine;

  /// No description provided for @videoEvidenceIsADemoPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Video evidence is a demo placeholder.'**
  String get videoEvidenceIsADemoPlaceholder;

  /// No description provided for @demoPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'DEMO PLACEHOLDER'**
  String get demoPlaceholder;

  /// No description provided for @officiallyConfirmed.
  ///
  /// In en, this message translates to:
  /// **'✹  Officially confirmed'**
  String get officiallyConfirmed;

  /// No description provided for @aiSuspectedOnly.
  ///
  /// In en, this message translates to:
  /// **'✦  AI-suspected only'**
  String get aiSuspectedOnly;

  /// No description provided for @reviewTheDetailsYouMayPayOr.
  ///
  /// In en, this message translates to:
  /// **'Review the details. You may pay or appeal.'**
  String get reviewTheDetailsYouMayPayOr;

  /// No description provided for @noFineExistsAnOfficerMustReview.
  ///
  /// In en, this message translates to:
  /// **'No fine exists. An officer must review this clip first.'**
  String get noFineExistsAnOfficerMustReview;

  /// No description provided for @whatDoesThisMean.
  ///
  /// In en, this message translates to:
  /// **'What does this mean?'**
  String get whatDoesThisMean;

  /// No description provided for @ourCameraSystemNoticedThatYourVehicle.
  ///
  /// In en, this message translates to:
  /// **'Our camera system noticed that your vehicle may have broken a traffic rule at this place and time. This is a plain-language summary for demo purposes, not legal advice.'**
  String get ourCameraSystemNoticedThatYourVehicle;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @explainThisViolation.
  ///
  /// In en, this message translates to:
  /// **'Explain this violation'**
  String get explainThisViolation;

  /// No description provided for @incident.
  ///
  /// In en, this message translates to:
  /// **'Incident'**
  String get incident;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @dateTime.
  ///
  /// In en, this message translates to:
  /// **'Date & time'**
  String get dateTime;

  /// No description provided for @reference.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get reference;

  /// No description provided for @vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get vehicle;

  /// No description provided for @officialFine.
  ///
  /// In en, this message translates to:
  /// **'Official fine'**
  String get officialFine;

  /// No description provided for @baseFine.
  ///
  /// In en, this message translates to:
  /// **'Base fine'**
  String get baseFine;

  /// No description provided for @serviceFee.
  ///
  /// In en, this message translates to:
  /// **'Service fee'**
  String get serviceFee;

  /// No description provided for @payBy.
  ///
  /// In en, this message translates to:
  /// **'Pay by'**
  String get payBy;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @noOfficialFineHasBeenIssuedFor.
  ///
  /// In en, this message translates to:
  /// **'No official fine has been issued for this event.'**
  String get noOfficialFineHasBeenIssuedFor;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get personalInformation;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @emailOptional.
  ///
  /// In en, this message translates to:
  /// **'Email (optional)'**
  String get emailOptional;

  /// No description provided for @pleaseEnterYourName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name.'**
  String get pleaseEnterYourName;

  /// No description provided for @demoProfileSavedLocally.
  ///
  /// In en, this message translates to:
  /// **'Demo profile saved locally.'**
  String get demoProfileSavedLocally;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @unableToOpenAppSettings.
  ///
  /// In en, this message translates to:
  /// **'Unable to open app settings.'**
  String get unableToOpenAppSettings;

  /// No description provided for @notificationsAreAllowed.
  ///
  /// In en, this message translates to:
  /// **'Notifications are allowed.'**
  String get notificationsAreAllowed;

  /// No description provided for @notificationPermissionWasNotAllowedTheApp.
  ///
  /// In en, this message translates to:
  /// **'Notification permission was not allowed. The app will continue normally.'**
  String get notificationPermissionWasNotAllowedTheApp;

  /// No description provided for @notificationsAreDisabledYouCanEnableThem.
  ///
  /// In en, this message translates to:
  /// **'Notifications are disabled. You can enable them in app settings.'**
  String get notificationsAreDisabledYouCanEnableThem;

  /// No description provided for @allowed.
  ///
  /// In en, this message translates to:
  /// **'Allowed'**
  String get allowed;

  /// No description provided for @notAllowed.
  ///
  /// In en, this message translates to:
  /// **'Not allowed'**
  String get notAllowed;

  /// No description provided for @enableFromAndroidAppSettings.
  ///
  /// In en, this message translates to:
  /// **'Enable from Android app settings'**
  String get enableFromAndroidAppSettings;

  /// No description provided for @checkingPermission.
  ///
  /// In en, this message translates to:
  /// **'Checking permission…'**
  String get checkingPermission;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @enable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get enable;

  /// No description provided for @notificationPreferences.
  ///
  /// In en, this message translates to:
  /// **'Notification preferences'**
  String get notificationPreferences;

  /// No description provided for @deviceNotifications.
  ///
  /// In en, this message translates to:
  /// **'Device notifications'**
  String get deviceNotifications;

  /// No description provided for @privacySecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & security'**
  String get privacySecurity;

  /// No description provided for @biometricUnlock.
  ///
  /// In en, this message translates to:
  /// **'Biometric unlock'**
  String get biometricUnlock;

  /// No description provided for @biometricUnlockIsAVisualDemoOnly.
  ///
  /// In en, this message translates to:
  /// **'Biometric unlock is a visual demo only.'**
  String get biometricUnlockIsAVisualDemoOnly;

  /// No description provided for @changeAppPin.
  ///
  /// In en, this message translates to:
  /// **'Change app PIN'**
  String get changeAppPin;

  /// No description provided for @appPinIsNotConfiguredInThis.
  ///
  /// In en, this message translates to:
  /// **'App PIN is not configured in this demo.'**
  String get appPinIsNotConfiguredInThis;

  /// No description provided for @downloadMyData.
  ///
  /// In en, this message translates to:
  /// **'Download my data'**
  String get downloadMyData;

  /// No description provided for @dataExportNeedsABackend.
  ///
  /// In en, this message translates to:
  /// **'Data export needs a backend.'**
  String get dataExportNeedsABackend;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @accountDeletionNeedsABackend.
  ///
  /// In en, this message translates to:
  /// **'Account deletion needs a backend.'**
  String get accountDeletionNeedsABackend;

  /// No description provided for @yourDataIsUsedOnlyToShow.
  ///
  /// In en, this message translates to:
  /// **'Your data is used only to show your own records.'**
  String get yourDataIsUsedOnlyToShow;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & support'**
  String get helpSupport;

  /// No description provided for @faqs.
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get faqs;

  /// No description provided for @faqsAreNotConnectedInThisDemo.
  ///
  /// In en, this message translates to:
  /// **'FAQs are not connected in this demo.'**
  String get faqsAreNotConnectedInThisDemo;

  /// No description provided for @callSupport.
  ///
  /// In en, this message translates to:
  /// **'Call support'**
  String get callSupport;

  /// No description provided for @demoNumber.
  ///
  /// In en, this message translates to:
  /// **'Demo number'**
  String get demoNumber;

  /// No description provided for @supportNumberIsADemoPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Support number is a demo placeholder.'**
  String get supportNumberIsADemoPlaceholder;

  /// No description provided for @chatWithUs.
  ///
  /// In en, this message translates to:
  /// **'Chat with us'**
  String get chatWithUs;

  /// No description provided for @chatSupportNeedsABackend.
  ///
  /// In en, this message translates to:
  /// **'Chat support needs a backend.'**
  String get chatSupportNeedsABackend;

  /// No description provided for @vehicleDetails.
  ///
  /// In en, this message translates to:
  /// **'Vehicle details'**
  String get vehicleDetails;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @colour.
  ///
  /// In en, this message translates to:
  /// **'Colour'**
  String get colour;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @registrationExpires.
  ///
  /// In en, this message translates to:
  /// **'Registration expires'**
  String get registrationExpires;

  /// No description provided for @verification.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verification;

  /// No description provided for @submitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get submitted;

  /// No description provided for @matchedToRegistry.
  ///
  /// In en, this message translates to:
  /// **'Matched to registry'**
  String get matchedToRegistry;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @linkedViolations.
  ///
  /// In en, this message translates to:
  /// **'Linked violations'**
  String get linkedViolations;

  /// No description provided for @useTheDemoCode123456.
  ///
  /// In en, this message translates to:
  /// **'Use the demo code 123456.'**
  String get useTheDemoCode123456;

  /// No description provided for @verifyYourNumber.
  ///
  /// In en, this message translates to:
  /// **'Verify your number'**
  String get verifyYourNumber;

  /// No description provided for @resendCodeIn030.
  ///
  /// In en, this message translates to:
  /// **'Resend code in 0:30'**
  String get resendCodeIn030;

  /// No description provided for @demoPrototypeUseCode123456.
  ///
  /// In en, this message translates to:
  /// **'Demo prototype: use code 123456.'**
  String get demoPrototypeUseCode123456;

  /// No description provided for @verifyContinue.
  ///
  /// In en, this message translates to:
  /// **'Verify & continue'**
  String get verifyContinue;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get goodEvening;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @youHaveFinesToPay.
  ///
  /// In en, this message translates to:
  /// **'You have fines to pay'**
  String get youHaveFinesToPay;

  /// No description provided for @label2ConfirmedPayBy31Oct2026.
  ///
  /// In en, this message translates to:
  /// **'2 confirmed · pay by 31 Oct 2026'**
  String get label2ConfirmedPayBy31Oct2026;

  /// No description provided for @payNow.
  ///
  /// In en, this message translates to:
  /// **'Pay now'**
  String get payNow;

  /// No description provided for @payFines.
  ///
  /// In en, this message translates to:
  /// **'Pay fines'**
  String get payFines;

  /// No description provided for @vehicles.
  ///
  /// In en, this message translates to:
  /// **'Vehicles'**
  String get vehicles;

  /// No description provided for @licence.
  ///
  /// In en, this message translates to:
  /// **'Licence'**
  String get licence;

  /// No description provided for @recentAlerts.
  ///
  /// In en, this message translates to:
  /// **'Recent alerts'**
  String get recentAlerts;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @pleaseAgreeToTheTermsBeforeContinuing.
  ///
  /// In en, this message translates to:
  /// **'Please agree to the terms before continuing.'**
  String get pleaseAgreeToTheTermsBeforeContinuing;

  /// No description provided for @enterAValidCambodianPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid Cambodian phone number.'**
  String get enterAValidCambodianPhoneNumber;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @signInOrCreateAnAccountWith.
  ///
  /// In en, this message translates to:
  /// **'Sign in or create an account with your phone number. We will send a one-time code.'**
  String get signInOrCreateAnAccountWith;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @example12345678.
  ///
  /// In en, this message translates to:
  /// **'Example: 12 345 678'**
  String get example12345678;

  /// No description provided for @iAgreeToTheTermsAndThe.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms and the Privacy Notice. My phone number and vehicle data are used only to show my own records.'**
  String get iAgreeToTheTermsAndThe;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get sendCode;

  /// No description provided for @encryptedNotAnOfficialGovernmentApp.
  ///
  /// In en, this message translates to:
  /// **'Encrypted. Not an official government app.'**
  String get encryptedNotAnOfficialGovernmentApp;

  /// No description provided for @drivingLicence.
  ///
  /// In en, this message translates to:
  /// **'Driving Licence'**
  String get drivingLicence;

  /// No description provided for @drivingLicenceLabel.
  ///
  /// In en, this message translates to:
  /// **'DRIVING LICENCE'**
  String get drivingLicenceLabel;

  /// No description provided for @demoCardNotAnOfficialDocument.
  ///
  /// In en, this message translates to:
  /// **'Demo card · not an official document'**
  String get demoCardNotAnOfficialDocument;

  /// No description provided for @dob19.
  ///
  /// In en, this message translates to:
  /// **'DOB ·· ··· 19··'**
  String get dob19;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @issued.
  ///
  /// In en, this message translates to:
  /// **'Issued'**
  String get issued;

  /// No description provided for @expires.
  ///
  /// In en, this message translates to:
  /// **'Expires'**
  String get expires;

  /// No description provided for @officialPoints.
  ///
  /// In en, this message translates to:
  /// **'Official points'**
  String get officialPoints;

  /// No description provided for @demoDataSampleBalanceForDesignPreview.
  ///
  /// In en, this message translates to:
  /// **'DEMO DATA · Sample balance for design preview only'**
  String get demoDataSampleBalanceForDesignPreview;

  /// No description provided for @backToUnavailableState.
  ///
  /// In en, this message translates to:
  /// **'Back to unavailable state'**
  String get backToUnavailableState;

  /// No description provided for @pointsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Points unavailable'**
  String get pointsUnavailable;

  /// No description provided for @yourLicenceIsNotConnectedToAn.
  ///
  /// In en, this message translates to:
  /// **'Your licence is not connected to an official points service. We never show estimated points as official records.'**
  String get yourLicenceIsNotConnectedToAn;

  /// No description provided for @officialPointsServiceIsNotConnected.
  ///
  /// In en, this message translates to:
  /// **'Official points service is not connected.'**
  String get officialPointsServiceIsNotConnected;

  /// No description provided for @checkConnection.
  ///
  /// In en, this message translates to:
  /// **'Check connection'**
  String get checkConnection;

  /// No description provided for @previewVerifiedStateDemoData.
  ///
  /// In en, this message translates to:
  /// **'Preview verified state (demo data)'**
  String get previewVerifiedStateDemoData;

  /// No description provided for @pointDeductionHistory.
  ///
  /// In en, this message translates to:
  /// **'Point deduction history'**
  String get pointDeductionHistory;

  /// No description provided for @redLightViolation09Sep2026.
  ///
  /// In en, this message translates to:
  /// **'Red-light violation · 09 Sep 2026'**
  String get redLightViolation09Sep2026;

  /// No description provided for @speeding11Jan2026.
  ///
  /// In en, this message translates to:
  /// **'Speeding · 11 Jan 2026'**
  String get speeding11Jan2026;

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get payments;

  /// No description provided for @finesToPay.
  ///
  /// In en, this message translates to:
  /// **'Fines to pay'**
  String get finesToPay;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @noFinesToPay.
  ///
  /// In en, this message translates to:
  /// **'No fines to pay.'**
  String get noFinesToPay;

  /// No description provided for @selectFine.
  ///
  /// In en, this message translates to:
  /// **'Select fine'**
  String get selectFine;

  /// No description provided for @paymentHistory.
  ///
  /// In en, this message translates to:
  /// **'Payment history'**
  String get paymentHistory;

  /// No description provided for @crossingStopLine.
  ///
  /// In en, this message translates to:
  /// **'Crossing stop line'**
  String get crossingStopLine;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @seatbeltFine.
  ///
  /// In en, this message translates to:
  /// **'Seatbelt fine'**
  String get seatbeltFine;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @parkingFine.
  ///
  /// In en, this message translates to:
  /// **'Parking fine'**
  String get parkingFine;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @demoPayment.
  ///
  /// In en, this message translates to:
  /// **'Demo payment'**
  String get demoPayment;

  /// No description provided for @paymentHistoryIsDemoData.
  ///
  /// In en, this message translates to:
  /// **'Payment history is demo data.'**
  String get paymentHistoryIsDemoData;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @violations.
  ///
  /// In en, this message translates to:
  /// **'Violations'**
  String get violations;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @allCount.
  ///
  /// In en, this message translates to:
  /// **'All {count}'**
  String allCount(int count);

  /// No description provided for @toPayCount.
  ///
  /// In en, this message translates to:
  /// **'To pay {count}'**
  String toPayCount(int count);

  /// No description provided for @inReviewCount.
  ///
  /// In en, this message translates to:
  /// **'In review {count}'**
  String inReviewCount(int count);

  /// No description provided for @doneCount.
  ///
  /// In en, this message translates to:
  /// **'Done {count}'**
  String doneCount(int count);

  /// No description provided for @searchPlateOrLocation.
  ///
  /// In en, this message translates to:
  /// **'Search plate or location'**
  String get searchPlateOrLocation;

  /// No description provided for @aiDetectionsAreOnlySuspectedAFine.
  ///
  /// In en, this message translates to:
  /// **'ⓘ  AI detections are only suspected. A fine exists after official confirmation.'**
  String get aiDetectionsAreOnlySuspectedAFine;

  /// No description provided for @noMatchingViolations.
  ///
  /// In en, this message translates to:
  /// **'No matching violations.'**
  String get noMatchingViolations;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get chooseLanguage;

  /// No description provided for @phoneVerified.
  ///
  /// In en, this message translates to:
  /// **'✓ Phone verified'**
  String get phoneVerified;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'MY ACCOUNT'**
  String get myAccount;

  /// No description provided for @myVehicles.
  ///
  /// In en, this message translates to:
  /// **'My vehicles'**
  String get myVehicles;

  /// No description provided for @label2Registered.
  ///
  /// In en, this message translates to:
  /// **'2 registered'**
  String get label2Registered;

  /// No description provided for @drivingLicenceLabelAlt.
  ///
  /// In en, this message translates to:
  /// **'Driving licence'**
  String get drivingLicenceLabelAlt;

  /// No description provided for @settingsLabel.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settingsLabel;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @cambodiaSmartTrafficV100Demo.
  ///
  /// In en, this message translates to:
  /// **'Cambodia Smart Traffic · v1.0.0 (demo)'**
  String get cambodiaSmartTrafficV100Demo;

  /// No description provided for @cambodiaSmartTraffic.
  ///
  /// In en, this message translates to:
  /// **'Cambodia Smart Traffic'**
  String get cambodiaSmartTraffic;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @addAVehicle.
  ///
  /// In en, this message translates to:
  /// **'Add a vehicle'**
  String get addAVehicle;

  /// No description provided for @car.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get car;

  /// No description provided for @motorcycle.
  ///
  /// In en, this message translates to:
  /// **'Motorcycle'**
  String get motorcycle;

  /// No description provided for @plateNumber.
  ///
  /// In en, this message translates to:
  /// **'Plate number'**
  String get plateNumber;

  /// No description provided for @officialRegistryVerificationIsNotConnectedIn.
  ///
  /// In en, this message translates to:
  /// **'Official registry verification is not connected in this demo.'**
  String get officialRegistryVerificationIsNotConnectedIn;

  /// No description provided for @vehicleVerificationNeedsAnOfficialRegistryConnection.
  ///
  /// In en, this message translates to:
  /// **'Vehicle verification needs an official registry connection.'**
  String get vehicleVerificationNeedsAnOfficialRegistryConnection;

  /// No description provided for @submitForVerification.
  ///
  /// In en, this message translates to:
  /// **'Submit for verification'**
  String get submitForVerification;

  /// No description provided for @enterAPlateNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a plate number'**
  String get enterAPlateNumber;

  /// No description provided for @vehicleVerificationPendingFor.
  ///
  /// In en, this message translates to:
  /// **'{plate} was not added. Official registry verification is required.'**
  String vehicleVerificationPendingFor(String plate);

  /// No description provided for @myVehiclesLabel.
  ///
  /// In en, this message translates to:
  /// **'My Vehicles'**
  String get myVehiclesLabel;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @verifiedLabel.
  ///
  /// In en, this message translates to:
  /// **'✓ Verified'**
  String get verifiedLabel;

  /// No description provided for @confirmDemoPayment.
  ///
  /// In en, this message translates to:
  /// **'Confirm payment'**
  String get confirmDemoPayment;

  /// No description provided for @confirmPayment.
  ///
  /// In en, this message translates to:
  /// **'Confirm payment'**
  String get confirmPayment;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirmDemo.
  ///
  /// In en, this message translates to:
  /// **'Confirm & pay'**
  String get confirmDemo;

  /// No description provided for @confirmAndPay.
  ///
  /// In en, this message translates to:
  /// **'Confirm & pay'**
  String get confirmAndPay;

  /// No description provided for @demoPaymentDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This is a demo payment. No money will be transferred.'**
  String get demoPaymentDisclaimer;

  /// No description provided for @processingPayment.
  ///
  /// In en, this message translates to:
  /// **'Processing payment...'**
  String get processingPayment;

  /// No description provided for @pleaseDontCloseTheApp.
  ///
  /// In en, this message translates to:
  /// **'Please don\'t close the app.'**
  String get pleaseDontCloseTheApp;

  /// No description provided for @yourDemoReceiptIsReady.
  ///
  /// In en, this message translates to:
  /// **'Your demo receipt is ready.'**
  String get yourDemoReceiptIsReady;

  /// No description provided for @viewDemoReceipt.
  ///
  /// In en, this message translates to:
  /// **'View demo receipt'**
  String get viewDemoReceipt;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @demoReceiptTitle.
  ///
  /// In en, this message translates to:
  /// **'Demo receipt'**
  String get demoReceiptTitle;

  /// No description provided for @prototypeNotOfficialReceipt.
  ///
  /// In en, this message translates to:
  /// **'Prototype only — not an official government receipt.'**
  String get prototypeNotOfficialReceipt;

  /// No description provided for @violationReference.
  ///
  /// In en, this message translates to:
  /// **'Violation reference'**
  String get violationReference;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @demoSimulationPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Demo simulation'**
  String get demoSimulationPaymentMethod;

  /// No description provided for @demoPaid.
  ///
  /// In en, this message translates to:
  /// **'Demo paid'**
  String get demoPaid;

  /// No description provided for @demoPaymentComplete.
  ///
  /// In en, this message translates to:
  /// **'Demo payment complete'**
  String get demoPaymentComplete;

  /// No description provided for @thisIsALocalSimulationNoOfficial.
  ///
  /// In en, this message translates to:
  /// **'This is a local simulation. No official payment was made.'**
  String get thisIsALocalSimulationNoOfficial;

  /// No description provided for @reviewPay.
  ///
  /// In en, this message translates to:
  /// **'Review & pay'**
  String get reviewPay;

  /// No description provided for @paymentsAreNotConnectedToAnAuthorised.
  ///
  /// In en, this message translates to:
  /// **'Payments are not connected to an authorised government service yet. This screen simulates the flow.'**
  String get paymentsAreNotConnectedToAnAuthorised;

  /// No description provided for @fines.
  ///
  /// In en, this message translates to:
  /// **'Fines'**
  String get fines;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get paymentMethod;

  /// No description provided for @bankApp.
  ///
  /// In en, this message translates to:
  /// **'Bank app'**
  String get bankApp;

  /// No description provided for @notConnectedYet.
  ///
  /// In en, this message translates to:
  /// **'Not connected yet'**
  String get notConnectedYet;

  /// No description provided for @mobileWallet.
  ///
  /// In en, this message translates to:
  /// **'Mobile wallet'**
  String get mobileWallet;

  /// No description provided for @demoSimulation.
  ///
  /// In en, this message translates to:
  /// **'Demo simulation'**
  String get demoSimulation;

  /// No description provided for @prototypeOnly.
  ///
  /// In en, this message translates to:
  /// **'Prototype only'**
  String get prototypeOnly;

  /// No description provided for @weNeverAskForOrStoreCard.
  ///
  /// In en, this message translates to:
  /// **'We never ask for or store card details in this app.'**
  String get weNeverAskForOrStoreCard;

  /// No description provided for @notMyVehicle.
  ///
  /// In en, this message translates to:
  /// **'Not my vehicle'**
  String get notMyVehicle;

  /// No description provided for @signalWasGreen.
  ///
  /// In en, this message translates to:
  /// **'Signal was green'**
  String get signalWasGreen;

  /// No description provided for @emergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get emergency;

  /// No description provided for @wrongLocation.
  ///
  /// In en, this message translates to:
  /// **'Wrong location'**
  String get wrongLocation;

  /// No description provided for @chooseAReasonOrDescribeWhatHappened.
  ///
  /// In en, this message translates to:
  /// **'Choose a reason or describe what happened.'**
  String get chooseAReasonOrDescribeWhatHappened;

  /// No description provided for @appealSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Appeal submitted'**
  String get appealSubmitted;

  /// No description provided for @appealDispute.
  ///
  /// In en, this message translates to:
  /// **'Appeal / Dispute'**
  String get appealDispute;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @submitAppeal.
  ///
  /// In en, this message translates to:
  /// **'Submit appeal'**
  String get submitAppeal;

  /// No description provided for @yourDemoAppealWasSavedLocally.
  ///
  /// In en, this message translates to:
  /// **'Your demo appeal was saved locally.'**
  String get yourDemoAppealWasSavedLocally;

  /// No description provided for @noOfficialSubmissionWasMade.
  ///
  /// In en, this message translates to:
  /// **'No official submission was made.'**
  String get noOfficialSubmissionWasMade;

  /// No description provided for @reasonOptional.
  ///
  /// In en, this message translates to:
  /// **'Reason (optional)'**
  String get reasonOptional;

  /// No description provided for @yourExplanation.
  ///
  /// In en, this message translates to:
  /// **'Your explanation'**
  String get yourExplanation;

  /// No description provided for @describeWhatHappened.
  ///
  /// In en, this message translates to:
  /// **'Describe what happened...'**
  String get describeWhatHappened;

  /// No description provided for @supportingEvidence.
  ///
  /// In en, this message translates to:
  /// **'Supporting evidence'**
  String get supportingEvidence;

  /// No description provided for @evidenceUploadNeedsABackend.
  ///
  /// In en, this message translates to:
  /// **'Evidence upload needs a backend.'**
  String get evidenceUploadNeedsABackend;

  /// No description provided for @attachPhotoOrDocument.
  ///
  /// In en, this message translates to:
  /// **'Attach photo or document'**
  String get attachPhotoOrDocument;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @aiSuspected.
  ///
  /// In en, this message translates to:
  /// **'AI suspected'**
  String get aiSuspected;

  /// No description provided for @confirmedFine.
  ///
  /// In en, this message translates to:
  /// **'Confirmed fine'**
  String get confirmedFine;

  /// No description provided for @underReview.
  ///
  /// In en, this message translates to:
  /// **'Under review'**
  String get underReview;

  /// No description provided for @disputed.
  ///
  /// In en, this message translates to:
  /// **'Disputed'**
  String get disputed;

  /// No description provided for @resolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get resolved;

  /// No description provided for @noFine.
  ///
  /// In en, this message translates to:
  /// **'No fine'**
  String get noFine;

  /// No description provided for @smartTrafficMonitoring.
  ///
  /// In en, this message translates to:
  /// **'Smart traffic monitoring'**
  String get smartTrafficMonitoring;

  /// No description provided for @aiReviewsCctvFootageOnPublicRoads.
  ///
  /// In en, this message translates to:
  /// **'AI reviews CCTV footage on public roads and flags possible violations for officers to check.'**
  String get aiReviewsCctvFootageOnPublicRoads;

  /// No description provided for @instantViolationNotifications.
  ///
  /// In en, this message translates to:
  /// **'Instant violation notifications'**
  String get instantViolationNotifications;

  /// No description provided for @getAlertedWithVideoEvidenceLocationAnd.
  ///
  /// In en, this message translates to:
  /// **'Get alerted with video evidence, location and time. See what is suspected and what is officially confirmed.'**
  String get getAlertedWithVideoEvidenceLocationAnd;

  /// No description provided for @secureFineLicenceManagement.
  ///
  /// In en, this message translates to:
  /// **'Secure fine & licence management'**
  String get secureFineLicenceManagement;

  /// No description provided for @reviewFinesAppealWhenSomethingLooksWrong.
  ///
  /// In en, this message translates to:
  /// **'Review fines, appeal when something looks wrong, and keep your vehicles and licence in one place.'**
  String get reviewFinesAppealWhenSomethingLooksWrong;

  /// No description provided for @possibleRedLightViolation.
  ///
  /// In en, this message translates to:
  /// **'Possible red-light violation'**
  String get possibleRedLightViolation;

  /// No description provided for @speeding68KmHIn50Zone.
  ///
  /// In en, this message translates to:
  /// **'Speeding (68 km/h in 50 zone)'**
  String get speeding68KmHIn50Zone;

  /// No description provided for @noHelmet.
  ///
  /// In en, this message translates to:
  /// **'No helmet'**
  String get noHelmet;

  /// No description provided for @illegalParking.
  ///
  /// In en, this message translates to:
  /// **'Illegal parking'**
  String get illegalParking;

  /// No description provided for @wrongWayDriving.
  ///
  /// In en, this message translates to:
  /// **'Wrong-way driving'**
  String get wrongWayDriving;

  /// No description provided for @newPotentialViolation.
  ///
  /// In en, this message translates to:
  /// **'New potential violation'**
  String get newPotentialViolation;

  /// No description provided for @officialFineConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Official fine confirmed'**
  String get officialFineConfirmed;

  /// No description provided for @paymentReminder.
  ///
  /// In en, this message translates to:
  /// **'Payment reminder'**
  String get paymentReminder;

  /// No description provided for @appealStatusUpdate.
  ///
  /// In en, this message translates to:
  /// **'Appeal status update'**
  String get appealStatusUpdate;

  /// No description provided for @paymentSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Payment successful'**
  String get paymentSuccessful;

  /// No description provided for @licenceInformationUpdate.
  ///
  /// In en, this message translates to:
  /// **'Licence information update'**
  String get licenceInformationUpdate;

  /// No description provided for @aiFlaggedAPossibleRedLightEvent.
  ///
  /// In en, this message translates to:
  /// **'AI flagged a possible red-light event for 2AB-1234. Not yet a fine.'**
  String get aiFlaggedAPossibleRedLightEvent;

  /// No description provided for @speedingFineOf150000IsReady.
  ///
  /// In en, this message translates to:
  /// **'Speeding fine of 150,000 ៛ is ready for review.'**
  String get speedingFineOf150000IsReady;

  /// No description provided for @label2FinesDueBy31Oct2026.
  ///
  /// In en, this message translates to:
  /// **'2 fines due by 31 Oct 2026.'**
  String get label2FinesDueBy31Oct2026;

  /// No description provided for @yourAppealForWrongWayDrivingWas.
  ///
  /// In en, this message translates to:
  /// **'Your appeal for wrong-way driving was received.'**
  String get yourAppealForWrongWayDrivingWas;

  /// No description provided for @receiptDemoRc08160042IsAvailable.
  ///
  /// In en, this message translates to:
  /// **'Receipt DEMO-RC-0816-0042 is available.'**
  String get receiptDemoRc08160042IsAvailable;

  /// No description provided for @pointsServiceIsNotConnectedYet.
  ///
  /// In en, this message translates to:
  /// **'Points service is not connected yet.'**
  String get pointsServiceIsNotConnectedYet;

  /// No description provided for @label2HAgo.
  ///
  /// In en, this message translates to:
  /// **'2 h ago'**
  String get label2HAgo;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @label3DAgo.
  ///
  /// In en, this message translates to:
  /// **'3 d ago'**
  String get label3DAgo;

  /// No description provided for @newPotentialViolations.
  ///
  /// In en, this message translates to:
  /// **'New potential violations'**
  String get newPotentialViolations;

  /// No description provided for @paymentReminders.
  ///
  /// In en, this message translates to:
  /// **'Payment reminders'**
  String get paymentReminders;

  /// No description provided for @tipsNews.
  ///
  /// In en, this message translates to:
  /// **'Tips & news'**
  String get tipsNews;

  /// No description provided for @carLabel.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get carLabel;

  /// No description provided for @motorcycleLabel.
  ///
  /// In en, this message translates to:
  /// **'Motorcycle'**
  String get motorcycleLabel;

  /// No description provided for @pearlWhite.
  ///
  /// In en, this message translates to:
  /// **'Pearl white'**
  String get pearlWhite;

  /// No description provided for @black.
  ///
  /// In en, this message translates to:
  /// **'Black'**
  String get black;

  /// No description provided for @codeSent.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to +855 {phone}'**
  String codeSent(String phone);

  /// No description provided for @payAmount.
  ///
  /// In en, this message translates to:
  /// **'Pay {amount}'**
  String payAmount(String amount);

  /// No description provided for @markedPaid.
  ///
  /// In en, this message translates to:
  /// **'{amount} marked paid'**
  String markedPaid(String amount);

  /// No description provided for @confirmPaymentBody.
  ///
  /// In en, this message translates to:
  /// **'Pay {amount} for {count} official fine(s)?'**
  String confirmPaymentBody(int count, String amount);

  /// No description provided for @explanationChecks.
  ///
  /// In en, this message translates to:
  /// **'✓ AI marks clips it is unsure about. People make the final decision.\n\n✓ You can watch the evidence and appeal if it looks wrong.\n\n✓ You only pay after an official confirmation.'**
  String get explanationChecks;

  /// No description provided for @availableOnAndroid.
  ///
  /// In en, this message translates to:
  /// **'Available on Android'**
  String get availableOnAndroid;

  /// No description provided for @homeOutstandingConfirmedFines.
  ///
  /// In en, this message translates to:
  /// **'Outstanding Confirmed Fines'**
  String get homeOutstandingConfirmedFines;

  /// No description provided for @homeLicencePointsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Licence info · points unavailable'**
  String get homeLicencePointsUnavailable;

  /// No description provided for @homeAiDetectionTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Detection vs Confirmed Fine'**
  String get homeAiDetectionTitle;

  /// No description provided for @homeAiDetectionBody.
  ///
  /// In en, this message translates to:
  /// **'Pending detections require officer verification before any fine is confirmed.'**
  String get homeAiDetectionBody;

  /// No description provided for @homeRecentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent Violations & Activity'**
  String get homeRecentActivity;

  /// No description provided for @homeViewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get homeViewAll;

  /// No description provided for @homeConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get homeConfirmed;

  /// No description provided for @homeUnderAiReview.
  ///
  /// In en, this message translates to:
  /// **'Under AI Review'**
  String get homeUnderAiReview;

  /// No description provided for @homeNoFineYet.
  ///
  /// In en, this message translates to:
  /// **'No fine yet'**
  String get homeNoFineYet;

  /// No description provided for @homeVehicleOnFile.
  ///
  /// In en, this message translates to:
  /// **'Vehicle on file'**
  String get homeVehicleOnFile;

  /// No description provided for @homeDemoRecord.
  ///
  /// In en, this message translates to:
  /// **'Demo record'**
  String get homeDemoRecord;

  /// No description provided for @homeDemoReceipt.
  ///
  /// In en, this message translates to:
  /// **'Sample demo receipt'**
  String get homeDemoReceipt;

  /// No description provided for @homePrototypeSimulation.
  ///
  /// In en, this message translates to:
  /// **'Prototype simulation'**
  String get homePrototypeSimulation;

  /// No description provided for @homeNoPaymentsYet.
  ///
  /// In en, this message translates to:
  /// **'No payments yet'**
  String get homeNoPaymentsYet;

  /// No description provided for @homeDemoPaid.
  ///
  /// In en, this message translates to:
  /// **'Demo paid'**
  String get homeDemoPaid;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'km'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'km':
      return AppLocalizationsKm();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
