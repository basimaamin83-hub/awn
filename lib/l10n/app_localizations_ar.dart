// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'عون';

  @override
  String get appTagline => 'معاً نصنع الفرق';

  @override
  String get loginWithSand => 'تسجيل الدخول عبر سند';

  @override
  String get loginSanadSubtitle =>
      'نفس الدخول عبر الهوية الرقمية (سند) للمتطوعين ولذوي الإعاقة؛ بعدها تختار دورك في المنصة.';

  @override
  String get browseAsGuest => 'تصفح كزائر';

  @override
  String get chooseRoleTitle => 'من أنت؟';

  @override
  String get roleDisability => 'أنا شخص ذو إعاقة';

  @override
  String get roleVolunteer => 'أنا متطوع';

  @override
  String get roleBoth => 'كلاهما — أحتاج مساعدة وأتطوع';

  @override
  String get continueButton => 'متابعة';

  @override
  String get saveButton => 'حفظ';

  @override
  String get submitButton => 'إرسال';

  @override
  String get cancelButton => 'إلغاء';

  @override
  String get sendButton => 'إرسال';

  @override
  String get backButton => 'رجوع';

  @override
  String get disabilityProfileTitle => 'بطاقة عون';

  @override
  String get disabilityTypeSection => 'نوع الإعاقة';

  @override
  String get servicesNeededSection => 'الخدمات التي أحتاجها';

  @override
  String get volunteerInstructionsSection => 'تعليمات للمتطوع';

  @override
  String get volunteerProfileTitle => 'بطاقة المتطوع';

  @override
  String get skillsSection => 'المهارات';

  @override
  String get regionsSection => 'مناطق التطوع';

  @override
  String get availabilitySection => 'أوقات التفرغ';

  @override
  String get maxDistanceSection => 'أقصى مسافة';

  @override
  String get submitRegistration => 'تقديم طلب التسجيل';

  @override
  String dashboardGreeting(String name) {
    return 'مرحباً، $name';
  }

  @override
  String get urgentHelpCta => 'مساعدة فورية';

  @override
  String get urgentHelpDetail =>
      'يُرسل طلبك فوراً للمتطوعين المتاحين قربك — للحالات التي تحتاج دعماً الآن.';

  @override
  String get scheduleHelp => 'جدولة مساعدة';

  @override
  String get myCurrentRequests => 'طلباتي الحالية';

  @override
  String get myPastRequests => 'طلباتي السابقة';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get availableNow => 'متاح الآن';

  @override
  String get availableNowHint => 'أنت مرئي للطلبات القريبة';

  @override
  String get mapRequests => 'طلبات فورية قريبة';

  @override
  String get scheduledRequests => 'طلبات مجدولة';

  @override
  String get statsServices => 'خدمات';

  @override
  String get statsPoints => 'نقاط';

  @override
  String get statsRating => 'تقييم';

  @override
  String get whatDoYouNeed => 'ماذا تحتاج؟';

  @override
  String get serviceCarry => 'حمل أغراض';

  @override
  String get serviceShopping => 'شراء حاجيات';

  @override
  String get serviceEscort => 'مرافقة';

  @override
  String get serviceCleaning => 'تنظيف خفيف';

  @override
  String get serviceMedicine => 'تذكير بأدوية';

  @override
  String get serviceOther => 'خدمة أخرى';

  @override
  String get confirmLocation => 'تأكيد الموقع';

  @override
  String get useMyLocation => 'استخدام موقعي الحالي';

  @override
  String get additionalNotes => 'تعليمات إضافية';

  @override
  String get sendRequest => 'إرسال الطلب';

  @override
  String get scheduleRequest => 'جدولة الطلب';

  @override
  String get pickDate => 'اختر التاريخ';

  @override
  String get pickTime => 'اختر الوقت';

  @override
  String get searchingVolunteer => 'جاري البحث عن متطوع قريب منك…';

  @override
  String get cancelRequest => 'إلغاء الطلب';

  @override
  String get serviceInProgress => 'الخدمة قيد التنفيذ';

  @override
  String get callButton => 'اتصال';

  @override
  String get chatButton => 'دردشة';

  @override
  String get finishServiceVolunteer => 'أنهيت الخدمة';

  @override
  String get finishServiceUser => 'تمت الخدمة';

  @override
  String rateVolunteerTitle(String name) {
    return 'كيف كانت تجربتك مع $name؟';
  }

  @override
  String get rateUserTitle => 'قيّم الطلب';

  @override
  String get submitRating => 'إرسال التقييم';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get editProfile => 'تعديل الملف';

  @override
  String get reportIssue => 'الإبلاغ عن مشكلة';

  @override
  String get reportTitle => 'الإبلاغ عن مشكلة';

  @override
  String get reportType => 'نوع المشكلة';

  @override
  String get reportDescription => 'الوصف';

  @override
  String get guestTitle => 'عن عون';

  @override
  String get guestBody =>
      'عون منصة حكومية تربط الأشخاص ذوي الإعاقة بمتطوعين موثوقين في الأردن لدعم يومي (حمل أغراض، شراء، مرافقة) باستخدام تحديد الموقع لأسرع استجابة.';

  @override
  String get language => 'اللغة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get sosEmergency => 'طوارئ (SOS)';

  @override
  String get pointsLabel => 'نقاط التطوع';

  @override
  String get mockLocation => 'عمان — موقع تجريبي';

  @override
  String get volunteerAccepted => 'تم قبول المتطوع';

  @override
  String get ratingPunctuality => 'الالتزام بالموعد';

  @override
  String get ratingRespect => 'اللباقة والاحترام';

  @override
  String get ratingQuality => 'جودة الخدمة';

  @override
  String get ratingInstructions => 'فهم التعليمات';

  @override
  String get ratingClarity => 'وضوح الطلب';

  @override
  String get ratingCooperation => 'التعاون';

  @override
  String get ratingCommitment => 'الالتزام بالوقت';

  @override
  String get ratingRespectUser => 'احترام المتطوع';

  @override
  String get onboardingHint => 'أكمل ملفك للبدء';

  @override
  String get skipForDemo => 'تجريبي: تخطّ إلى لوحة التحكم';

  @override
  String get homeTab => 'الرئيسية';

  @override
  String get volunteerTab => 'تطوع';

  @override
  String get requestsTab => 'الطلبات';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String get noNotifications => 'لا توجد إشعارات بعد';

  @override
  String get notifVolunteerAccepted => 'قبل متطوع طلبك';

  @override
  String get notifScheduledReminder => 'تذكير: موعد مساعدة خلال ساعة';

  @override
  String get notifNewRating => 'وصلك تقييم جديد';

  @override
  String get sosSent => 'تم إرسال تنبيه طوارئ للمشرفين (تجريبي).';

  @override
  String get demoSimulated => 'تجريبي: ستُفعَّل في النسخة الكاملة مع الخادم.';

  @override
  String get roleBadgeDisability => 'مستلم خدمة';

  @override
  String get roleBadgeVolunteer => 'متطوع';

  @override
  String get roleBadgeBoth => 'مستلم خدمة ومتطوع';

  @override
  String get peerVolunteerName => 'سارة م.';

  @override
  String get requesterRole => 'يطلب مساعدة';

  @override
  String get volunteerRole => 'متطوع';

  @override
  String get pageNotFound => 'تعذر العثور على هذه الصفحة.';

  @override
  String get goHome => 'العودة للرئيسية';

  @override
  String get selectServiceError => 'يرجى اختيار نوع الخدمة';

  @override
  String get yesterday => 'أمس';

  @override
  String get mapYou => 'أنت';

  @override
  String get mapVolunteer => 'متطوع';

  @override
  String get mapHelpRequest => 'طلب مساعدة';

  @override
  String mapKmAway(String km) {
    return 'على بُعد $km كم';
  }

  @override
  String get mapLiveNearby => 'خريطة مباشرة';

  @override
  String get mapOsmAttribution => 'OpenStreetMap';

  @override
  String get mapNearbyVolunteersTitle => 'متطوعون قريبون منك';

  @override
  String get mapNearbyRequestsTitle => 'طلبات مساعدة قريبة';

  @override
  String get nearbyVolunteersListTitle => 'تفاصيل المتطوعين القريبين';

  @override
  String get mockVolunteerName0 => 'سارة م.';

  @override
  String get mockVolunteerName1 => 'خالد ع.';

  @override
  String get mockVolunteerName2 => 'لينا ح.';

  @override
  String get mockVolunteerName3 => 'عمر أ.';

  @override
  String volunteerCompletedCount(int count) {
    return '$count خدمة مكتملة';
  }

  @override
  String get chatTitle => 'الدردشة';

  @override
  String get chatInputHint => 'اكتب رسالة…';

  @override
  String get chatInitialFromVolunteer =>
      'أنا قريب منك ومتاحة الآن — أخبرني كيف أقدر أساعدك.';

  @override
  String get chatInitialFromRequester =>
      'شكراً لقبول الطلب، أنا عند النقطة الموضحة على الخريطة.';

  @override
  String get chatDemoRequesterName => 'أحمد ط.';

  @override
  String get chatSubtitleVolunteerTalking => 'أنت تتحدث مع طالب المساعدة';

  @override
  String get chatSubtitleRequesterTalking => 'أنت تتحدث مع المتطوع';

  @override
  String get tapPeerOnMap => 'اضغط للتواصل مع الطرف الآخر';

  @override
  String etaApproxMinutes(int minutes) {
    return 'حوالي $minutes دقيقة للوصول';
  }

  @override
  String get liveYouAreMoving => 'أنت تتحرك نحو طالب المساعدة (مباشر)';

  @override
  String get livePeerMovingToYou => 'المتطوع في الطريق إليك (مباشر)';

  @override
  String get peerContactTitle => 'التواصل';

  @override
  String get callCouldNotOpen => 'تعذر فتح تطبيق الاتصال على هذا الجهاز.';
}
