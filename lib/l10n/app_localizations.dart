import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Awn'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Together we make a difference'**
  String get appTagline;

  /// No description provided for @loginWithSand.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Sanad'**
  String get loginWithSand;

  /// No description provided for @loginSanadSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The same Sanad digital ID is used for volunteers and people with disabilities — then you choose your role in Awn.'**
  String get loginSanadSubtitle;

  /// No description provided for @browseAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Browse as guest'**
  String get browseAsGuest;

  /// No description provided for @chooseRoleTitle.
  ///
  /// In en, this message translates to:
  /// **'Who are you?'**
  String get chooseRoleTitle;

  /// No description provided for @roleDisability.
  ///
  /// In en, this message translates to:
  /// **'I am a person with a disability'**
  String get roleDisability;

  /// No description provided for @roleVolunteer.
  ///
  /// In en, this message translates to:
  /// **'I am a volunteer'**
  String get roleVolunteer;

  /// No description provided for @roleBoth.
  ///
  /// In en, this message translates to:
  /// **'Both — I need help and I volunteer'**
  String get roleBoth;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @submitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @sendButton.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get sendButton;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// No description provided for @disabilityProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Awn card'**
  String get disabilityProfileTitle;

  /// No description provided for @disabilityTypeSection.
  ///
  /// In en, this message translates to:
  /// **'Disability type'**
  String get disabilityTypeSection;

  /// No description provided for @servicesNeededSection.
  ///
  /// In en, this message translates to:
  /// **'Services I need'**
  String get servicesNeededSection;

  /// No description provided for @volunteerInstructionsSection.
  ///
  /// In en, this message translates to:
  /// **'Notes for volunteers'**
  String get volunteerInstructionsSection;

  /// No description provided for @volunteerProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Volunteer card'**
  String get volunteerProfileTitle;

  /// No description provided for @skillsSection.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skillsSection;

  /// No description provided for @regionsSection.
  ///
  /// In en, this message translates to:
  /// **'Volunteer areas'**
  String get regionsSection;

  /// No description provided for @availabilitySection.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availabilitySection;

  /// No description provided for @maxDistanceSection.
  ///
  /// In en, this message translates to:
  /// **'Maximum distance'**
  String get maxDistanceSection;

  /// No description provided for @submitRegistration.
  ///
  /// In en, this message translates to:
  /// **'Submit registration request'**
  String get submitRegistration;

  /// No description provided for @dashboardGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String dashboardGreeting(String name);

  /// No description provided for @urgentHelpCta.
  ///
  /// In en, this message translates to:
  /// **'Urgent help now'**
  String get urgentHelpCta;

  /// No description provided for @urgentHelpDetail.
  ///
  /// In en, this message translates to:
  /// **'Your request is sent immediately to available volunteers nearby — for situations that need support right away.'**
  String get urgentHelpDetail;

  /// No description provided for @scheduleHelp.
  ///
  /// In en, this message translates to:
  /// **'Schedule help'**
  String get scheduleHelp;

  /// No description provided for @myCurrentRequests.
  ///
  /// In en, this message translates to:
  /// **'My current requests'**
  String get myCurrentRequests;

  /// No description provided for @myPastRequests.
  ///
  /// In en, this message translates to:
  /// **'Past requests'**
  String get myPastRequests;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @availableNow.
  ///
  /// In en, this message translates to:
  /// **'Available now'**
  String get availableNow;

  /// No description provided for @availableNowHint.
  ///
  /// In en, this message translates to:
  /// **'You are visible for nearby requests'**
  String get availableNowHint;

  /// No description provided for @mapRequests.
  ///
  /// In en, this message translates to:
  /// **'Nearby instant requests'**
  String get mapRequests;

  /// No description provided for @scheduledRequests.
  ///
  /// In en, this message translates to:
  /// **'Scheduled requests'**
  String get scheduledRequests;

  /// No description provided for @statsServices.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get statsServices;

  /// No description provided for @statsPoints.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get statsPoints;

  /// No description provided for @statsRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get statsRating;

  /// No description provided for @whatDoYouNeed.
  ///
  /// In en, this message translates to:
  /// **'What do you need?'**
  String get whatDoYouNeed;

  /// No description provided for @serviceCarry.
  ///
  /// In en, this message translates to:
  /// **'Carry items'**
  String get serviceCarry;

  /// No description provided for @serviceShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get serviceShopping;

  /// No description provided for @serviceEscort.
  ///
  /// In en, this message translates to:
  /// **'Escort'**
  String get serviceEscort;

  /// No description provided for @serviceCleaning.
  ///
  /// In en, this message translates to:
  /// **'Light cleaning'**
  String get serviceCleaning;

  /// No description provided for @serviceMedicine.
  ///
  /// In en, this message translates to:
  /// **'Medicine reminder'**
  String get serviceMedicine;

  /// No description provided for @serviceOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get serviceOther;

  /// No description provided for @confirmLocation.
  ///
  /// In en, this message translates to:
  /// **'Confirm location'**
  String get confirmLocation;

  /// No description provided for @useMyLocation.
  ///
  /// In en, this message translates to:
  /// **'Use my current location'**
  String get useMyLocation;

  /// No description provided for @additionalNotes.
  ///
  /// In en, this message translates to:
  /// **'Additional notes'**
  String get additionalNotes;

  /// No description provided for @sendRequest.
  ///
  /// In en, this message translates to:
  /// **'Send request'**
  String get sendRequest;

  /// No description provided for @scheduleRequest.
  ///
  /// In en, this message translates to:
  /// **'Schedule request'**
  String get scheduleRequest;

  /// No description provided for @pickDate.
  ///
  /// In en, this message translates to:
  /// **'Pick date'**
  String get pickDate;

  /// No description provided for @pickTime.
  ///
  /// In en, this message translates to:
  /// **'Pick time'**
  String get pickTime;

  /// No description provided for @searchingVolunteer.
  ///
  /// In en, this message translates to:
  /// **'Looking for a nearby volunteer…'**
  String get searchingVolunteer;

  /// No description provided for @cancelRequest.
  ///
  /// In en, this message translates to:
  /// **'Cancel request'**
  String get cancelRequest;

  /// No description provided for @serviceInProgress.
  ///
  /// In en, this message translates to:
  /// **'Service in progress'**
  String get serviceInProgress;

  /// No description provided for @callButton.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get callButton;

  /// No description provided for @chatButton.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chatButton;

  /// No description provided for @finishServiceVolunteer.
  ///
  /// In en, this message translates to:
  /// **'I finished the service'**
  String get finishServiceVolunteer;

  /// No description provided for @finishServiceUser.
  ///
  /// In en, this message translates to:
  /// **'Service completed'**
  String get finishServiceUser;

  /// No description provided for @rateVolunteerTitle.
  ///
  /// In en, this message translates to:
  /// **'How was your experience with {name}?'**
  String rateVolunteerTitle(String name);

  /// No description provided for @rateUserTitle.
  ///
  /// In en, this message translates to:
  /// **'Rate this request'**
  String get rateUserTitle;

  /// No description provided for @submitRating.
  ///
  /// In en, this message translates to:
  /// **'Submit rating'**
  String get submitRating;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @reportIssue.
  ///
  /// In en, this message translates to:
  /// **'Report an issue'**
  String get reportIssue;

  /// No description provided for @reportTitle.
  ///
  /// In en, this message translates to:
  /// **'Report a problem'**
  String get reportTitle;

  /// No description provided for @reportType.
  ///
  /// In en, this message translates to:
  /// **'Issue type'**
  String get reportType;

  /// No description provided for @reportDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get reportDescription;

  /// No description provided for @guestTitle.
  ///
  /// In en, this message translates to:
  /// **'About Awn'**
  String get guestTitle;

  /// No description provided for @guestBody.
  ///
  /// In en, this message translates to:
  /// **'Awn is a government platform connecting people with disabilities with trusted volunteers in Jordan for daily support (carrying items, shopping, escorting) using GPS for faster response.'**
  String get guestBody;

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

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @sosEmergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency (SOS)'**
  String get sosEmergency;

  /// No description provided for @pointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Volunteer points'**
  String get pointsLabel;

  /// No description provided for @mockLocation.
  ///
  /// In en, this message translates to:
  /// **'Amman — sample location'**
  String get mockLocation;

  /// No description provided for @volunteerAccepted.
  ///
  /// In en, this message translates to:
  /// **'Volunteer accepted'**
  String get volunteerAccepted;

  /// No description provided for @ratingPunctuality.
  ///
  /// In en, this message translates to:
  /// **'Punctuality'**
  String get ratingPunctuality;

  /// No description provided for @ratingRespect.
  ///
  /// In en, this message translates to:
  /// **'Respect & courtesy'**
  String get ratingRespect;

  /// No description provided for @ratingQuality.
  ///
  /// In en, this message translates to:
  /// **'Quality of service'**
  String get ratingQuality;

  /// No description provided for @ratingInstructions.
  ///
  /// In en, this message translates to:
  /// **'Following instructions'**
  String get ratingInstructions;

  /// No description provided for @ratingClarity.
  ///
  /// In en, this message translates to:
  /// **'Request clarity'**
  String get ratingClarity;

  /// No description provided for @ratingCooperation.
  ///
  /// In en, this message translates to:
  /// **'Cooperation'**
  String get ratingCooperation;

  /// No description provided for @ratingCommitment.
  ///
  /// In en, this message translates to:
  /// **'Time commitment'**
  String get ratingCommitment;

  /// No description provided for @ratingRespectUser.
  ///
  /// In en, this message translates to:
  /// **'Respect for volunteer'**
  String get ratingRespectUser;

  /// No description provided for @onboardingHint.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile to start'**
  String get onboardingHint;

  /// No description provided for @skipForDemo.
  ///
  /// In en, this message translates to:
  /// **'Demo: skip to dashboard'**
  String get skipForDemo;

  /// No description provided for @homeTab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// No description provided for @volunteerTab.
  ///
  /// In en, this message translates to:
  /// **'Volunteer'**
  String get volunteerTab;

  /// No description provided for @requestsTab.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requestsTab;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get noNotifications;

  /// No description provided for @notifVolunteerAccepted.
  ///
  /// In en, this message translates to:
  /// **'A volunteer accepted your request'**
  String get notifVolunteerAccepted;

  /// No description provided for @notifScheduledReminder.
  ///
  /// In en, this message translates to:
  /// **'Reminder: help scheduled in 1 hour'**
  String get notifScheduledReminder;

  /// No description provided for @notifNewRating.
  ///
  /// In en, this message translates to:
  /// **'You received a new rating'**
  String get notifNewRating;

  /// No description provided for @sosSent.
  ///
  /// In en, this message translates to:
  /// **'Emergency alert sent to supervisors (demo).'**
  String get sosSent;

  /// No description provided for @demoSimulated.
  ///
  /// In en, this message translates to:
  /// **'Demo: action simulated in the full app.'**
  String get demoSimulated;

  /// No description provided for @roleBadgeDisability.
  ///
  /// In en, this message translates to:
  /// **'Recipient'**
  String get roleBadgeDisability;

  /// No description provided for @roleBadgeVolunteer.
  ///
  /// In en, this message translates to:
  /// **'Volunteer'**
  String get roleBadgeVolunteer;

  /// No description provided for @roleBadgeBoth.
  ///
  /// In en, this message translates to:
  /// **'Recipient & volunteer'**
  String get roleBadgeBoth;

  /// No description provided for @peerVolunteerName.
  ///
  /// In en, this message translates to:
  /// **'Sara M.'**
  String get peerVolunteerName;

  /// No description provided for @requesterRole.
  ///
  /// In en, this message translates to:
  /// **'Requesting support'**
  String get requesterRole;

  /// No description provided for @volunteerRole.
  ///
  /// In en, this message translates to:
  /// **'Volunteer'**
  String get volunteerRole;

  /// No description provided for @pageNotFound.
  ///
  /// In en, this message translates to:
  /// **'This page could not be found.'**
  String get pageNotFound;

  /// No description provided for @goHome.
  ///
  /// In en, this message translates to:
  /// **'Go to home'**
  String get goHome;

  /// No description provided for @selectServiceError.
  ///
  /// In en, this message translates to:
  /// **'Please choose a service type'**
  String get selectServiceError;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @mapYou.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get mapYou;

  /// No description provided for @mapVolunteer.
  ///
  /// In en, this message translates to:
  /// **'Volunteer'**
  String get mapVolunteer;

  /// No description provided for @mapHelpRequest.
  ///
  /// In en, this message translates to:
  /// **'Help request'**
  String get mapHelpRequest;

  /// No description provided for @mapKmAway.
  ///
  /// In en, this message translates to:
  /// **'{km} km away'**
  String mapKmAway(String km);

  /// No description provided for @mapLiveNearby.
  ///
  /// In en, this message translates to:
  /// **'Live map'**
  String get mapLiveNearby;

  /// No description provided for @mapOsmAttribution.
  ///
  /// In en, this message translates to:
  /// **'OpenStreetMap'**
  String get mapOsmAttribution;

  /// No description provided for @mapNearbyVolunteersTitle.
  ///
  /// In en, this message translates to:
  /// **'Volunteers near you'**
  String get mapNearbyVolunteersTitle;

  /// No description provided for @mapNearbyRequestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Nearby help requests'**
  String get mapNearbyRequestsTitle;

  /// No description provided for @nearbyVolunteersListTitle.
  ///
  /// In en, this message translates to:
  /// **'Nearby volunteers (details)'**
  String get nearbyVolunteersListTitle;

  /// No description provided for @mockVolunteerName0.
  ///
  /// In en, this message translates to:
  /// **'Sara M.'**
  String get mockVolunteerName0;

  /// No description provided for @mockVolunteerName1.
  ///
  /// In en, this message translates to:
  /// **'Khaled A.'**
  String get mockVolunteerName1;

  /// No description provided for @mockVolunteerName2.
  ///
  /// In en, this message translates to:
  /// **'Lina H.'**
  String get mockVolunteerName2;

  /// No description provided for @mockVolunteerName3.
  ///
  /// In en, this message translates to:
  /// **'Omar A.'**
  String get mockVolunteerName3;

  /// No description provided for @volunteerCompletedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} services completed'**
  String volunteerCompletedCount(int count);

  /// No description provided for @chatTitle.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chatTitle;

  /// No description provided for @chatInputHint.
  ///
  /// In en, this message translates to:
  /// **'Type a message…'**
  String get chatInputHint;

  /// No description provided for @chatInitialFromVolunteer.
  ///
  /// In en, this message translates to:
  /// **'I\'m nearby and available — tell me how I can help.'**
  String get chatInitialFromVolunteer;

  /// No description provided for @chatInitialFromRequester.
  ///
  /// In en, this message translates to:
  /// **'Thanks for accepting. I\'m at the pin on the map.'**
  String get chatInitialFromRequester;

  /// No description provided for @chatDemoRequesterName.
  ///
  /// In en, this message translates to:
  /// **'Ahmad T.'**
  String get chatDemoRequesterName;

  /// No description provided for @chatSubtitleVolunteerTalking.
  ///
  /// In en, this message translates to:
  /// **'You are chatting with the person requesting help'**
  String get chatSubtitleVolunteerTalking;

  /// No description provided for @chatSubtitleRequesterTalking.
  ///
  /// In en, this message translates to:
  /// **'You are chatting with the volunteer'**
  String get chatSubtitleRequesterTalking;

  /// No description provided for @tapPeerOnMap.
  ///
  /// In en, this message translates to:
  /// **'Tap to contact the other person'**
  String get tapPeerOnMap;

  /// No description provided for @etaApproxMinutes.
  ///
  /// In en, this message translates to:
  /// **'About {minutes} min to arrival'**
  String etaApproxMinutes(int minutes);

  /// No description provided for @liveYouAreMoving.
  ///
  /// In en, this message translates to:
  /// **'You are moving toward the requester (live)'**
  String get liveYouAreMoving;

  /// No description provided for @livePeerMovingToYou.
  ///
  /// In en, this message translates to:
  /// **'Volunteer on the way to you (live)'**
  String get livePeerMovingToYou;

  /// No description provided for @peerContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get peerContactTitle;

  /// No description provided for @callCouldNotOpen.
  ///
  /// In en, this message translates to:
  /// **'Could not open the phone app on this device.'**
  String get callCouldNotOpen;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
