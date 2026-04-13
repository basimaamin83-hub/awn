// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Awn';

  @override
  String get appTagline => 'Together we make a difference';

  @override
  String get loginWithSand => 'Sign in with Sanad';

  @override
  String get loginSanadSubtitle =>
      'The same Sanad digital ID is used for volunteers and people with disabilities — then you choose your role in Awn.';

  @override
  String get browseAsGuest => 'Browse as guest';

  @override
  String get chooseRoleTitle => 'Who are you?';

  @override
  String get roleDisability => 'I am a person with a disability';

  @override
  String get roleVolunteer => 'I am a volunteer';

  @override
  String get roleBoth => 'Both — I need help and I volunteer';

  @override
  String get continueButton => 'Continue';

  @override
  String get saveButton => 'Save';

  @override
  String get submitButton => 'Submit';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get sendButton => 'Send';

  @override
  String get backButton => 'Back';

  @override
  String get disabilityProfileTitle => 'Awn card';

  @override
  String get disabilityTypeSection => 'Disability type';

  @override
  String get servicesNeededSection => 'Services I need';

  @override
  String get volunteerInstructionsSection => 'Notes for volunteers';

  @override
  String get volunteerProfileTitle => 'Volunteer card';

  @override
  String get skillsSection => 'Skills';

  @override
  String get regionsSection => 'Volunteer areas';

  @override
  String get availabilitySection => 'Availability';

  @override
  String get maxDistanceSection => 'Maximum distance';

  @override
  String get submitRegistration => 'Submit registration request';

  @override
  String dashboardGreeting(String name) {
    return 'Hello, $name';
  }

  @override
  String get urgentHelpCta => 'Urgent help now';

  @override
  String get urgentHelpDetail =>
      'Your request is sent immediately to available volunteers nearby — for situations that need support right away.';

  @override
  String get scheduleHelp => 'Schedule help';

  @override
  String get myCurrentRequests => 'My current requests';

  @override
  String get myPastRequests => 'Past requests';

  @override
  String get viewAll => 'View all';

  @override
  String get availableNow => 'Available now';

  @override
  String get availableNowHint => 'You are visible for nearby requests';

  @override
  String get mapRequests => 'Nearby instant requests';

  @override
  String get scheduledRequests => 'Scheduled requests';

  @override
  String get statsServices => 'Services';

  @override
  String get statsPoints => 'Points';

  @override
  String get statsRating => 'Rating';

  @override
  String get whatDoYouNeed => 'What do you need?';

  @override
  String get serviceCarry => 'Carry items';

  @override
  String get serviceShopping => 'Shopping';

  @override
  String get serviceEscort => 'Escort';

  @override
  String get serviceCleaning => 'Light cleaning';

  @override
  String get serviceMedicine => 'Medicine reminder';

  @override
  String get serviceOther => 'Other';

  @override
  String get confirmLocation => 'Confirm location';

  @override
  String get useMyLocation => 'Use my current location';

  @override
  String get additionalNotes => 'Additional notes';

  @override
  String get sendRequest => 'Send request';

  @override
  String get scheduleRequest => 'Schedule request';

  @override
  String get pickDate => 'Pick date';

  @override
  String get pickTime => 'Pick time';

  @override
  String get searchingVolunteer => 'Looking for a nearby volunteer…';

  @override
  String get cancelRequest => 'Cancel request';

  @override
  String get serviceInProgress => 'Service in progress';

  @override
  String get callButton => 'Call';

  @override
  String get chatButton => 'Chat';

  @override
  String get finishServiceVolunteer => 'I finished the service';

  @override
  String get finishServiceUser => 'Service completed';

  @override
  String rateVolunteerTitle(String name) {
    return 'How was your experience with $name?';
  }

  @override
  String get rateUserTitle => 'Rate this request';

  @override
  String get submitRating => 'Submit rating';

  @override
  String get profileTitle => 'Profile';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get reportIssue => 'Report an issue';

  @override
  String get reportTitle => 'Report a problem';

  @override
  String get reportType => 'Issue type';

  @override
  String get reportDescription => 'Description';

  @override
  String get guestTitle => 'About Awn';

  @override
  String get guestBody =>
      'Awn is a government platform connecting people with disabilities with trusted volunteers in Jordan for daily support (carrying items, shopping, escorting) using GPS for faster response.';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get notifications => 'Notifications';

  @override
  String get sosEmergency => 'Emergency (SOS)';

  @override
  String get pointsLabel => 'Volunteer points';

  @override
  String get mockLocation => 'Amman — sample location';

  @override
  String get volunteerAccepted => 'Volunteer accepted';

  @override
  String get ratingPunctuality => 'Punctuality';

  @override
  String get ratingRespect => 'Respect & courtesy';

  @override
  String get ratingQuality => 'Quality of service';

  @override
  String get ratingInstructions => 'Following instructions';

  @override
  String get ratingClarity => 'Request clarity';

  @override
  String get ratingCooperation => 'Cooperation';

  @override
  String get ratingCommitment => 'Time commitment';

  @override
  String get ratingRespectUser => 'Respect for volunteer';

  @override
  String get onboardingHint => 'Complete your profile to start';

  @override
  String get skipForDemo => 'Demo: skip to dashboard';

  @override
  String get homeTab => 'Home';

  @override
  String get volunteerTab => 'Volunteer';

  @override
  String get requestsTab => 'Requests';

  @override
  String get signOut => 'Sign out';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get noNotifications => 'No notifications yet';

  @override
  String get notifVolunteerAccepted => 'A volunteer accepted your request';

  @override
  String get notifScheduledReminder => 'Reminder: help scheduled in 1 hour';

  @override
  String get notifNewRating => 'You received a new rating';

  @override
  String get sosSent => 'Emergency alert sent to supervisors (demo).';

  @override
  String get demoSimulated => 'Demo: action simulated in the full app.';

  @override
  String get roleBadgeDisability => 'Recipient';

  @override
  String get roleBadgeVolunteer => 'Volunteer';

  @override
  String get roleBadgeBoth => 'Recipient & volunteer';

  @override
  String get peerVolunteerName => 'Sara M.';

  @override
  String get requesterRole => 'Requesting support';

  @override
  String get volunteerRole => 'Volunteer';

  @override
  String get pageNotFound => 'This page could not be found.';

  @override
  String get goHome => 'Go to home';

  @override
  String get selectServiceError => 'Please choose a service type';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get mapYou => 'You';

  @override
  String get mapVolunteer => 'Volunteer';

  @override
  String get mapHelpRequest => 'Help request';

  @override
  String mapKmAway(String km) {
    return '$km km away';
  }

  @override
  String get mapLiveNearby => 'Live map';

  @override
  String get mapOsmAttribution => 'OpenStreetMap';

  @override
  String get mapNearbyVolunteersTitle => 'Volunteers near you';

  @override
  String get mapNearbyRequestsTitle => 'Nearby help requests';

  @override
  String get nearbyVolunteersListTitle => 'Nearby volunteers (details)';

  @override
  String get mockVolunteerName0 => 'Sara M.';

  @override
  String get mockVolunteerName1 => 'Khaled A.';

  @override
  String get mockVolunteerName2 => 'Lina H.';

  @override
  String get mockVolunteerName3 => 'Omar A.';

  @override
  String volunteerCompletedCount(int count) {
    return '$count services completed';
  }

  @override
  String get chatTitle => 'Chat';

  @override
  String get chatInputHint => 'Type a message…';

  @override
  String get chatInitialFromVolunteer =>
      'I\'m nearby and available — tell me how I can help.';

  @override
  String get chatInitialFromRequester =>
      'Thanks for accepting. I\'m at the pin on the map.';

  @override
  String get chatDemoRequesterName => 'Ahmad T.';

  @override
  String get chatSubtitleVolunteerTalking =>
      'You are chatting with the person requesting help';

  @override
  String get chatSubtitleRequesterTalking =>
      'You are chatting with the volunteer';

  @override
  String get tapPeerOnMap => 'Tap to contact the other person';

  @override
  String etaApproxMinutes(int minutes) {
    return 'About $minutes min to arrival';
  }

  @override
  String get liveYouAreMoving => 'You are moving toward the requester (live)';

  @override
  String get livePeerMovingToYou => 'Volunteer on the way to you (live)';

  @override
  String get peerContactTitle => 'Contact';

  @override
  String get callCouldNotOpen => 'Could not open the phone app on this device.';
}
