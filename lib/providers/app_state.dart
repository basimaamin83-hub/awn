import 'package:flutter/material.dart';

enum AppUserRole { guest, disability, volunteer, both }

class AppState extends ChangeNotifier {
  AppState();

  Locale _locale = const Locale('ar');
  Locale get locale => _locale;

  /// اسم قصير للترحيب في الشريط.
  String userName = 'محمد';

  /// الاسم الرباعي (للملف والعرض الرسمي).
  String userFullNameAr = 'محمد أحمد حسن المصاروة';
  String userFullNameEn = 'Mohammad Ahmad Hassan Al-Masarweh';

  String userPhotoUrl = 'https://picsum.photos/seed/awnuser/400/400';
  String userPhone = '+962791234567';

  /// طالب المساعدة (يظهر للمتطوع أثناء الخدمة).
  String requesterFullNameAr = 'فاطمة خالد يوسف النابلسي';
  String requesterFullNameEn = 'Fatima Khaled Yousef Al-Nabulsi';
  String requesterPhotoUrl = 'https://picsum.photos/seed/awnrequester/400/400';
  String requesterPhone = '+962775554433';

  /// المتطوع المعيّن (يظهر لذي الإعاقة أثناء الخدمة).
  String volunteerPeerFullNameAr = 'سارة محمد علي الطراونة';
  String volunteerPeerFullNameEn = 'Sara Mohammad Ali Al-Tarawneh';
  String volunteerPeerPhotoUrl = 'https://picsum.photos/seed/awnvolunteer/400/400';
  String volunteerPeerPhone = '+962788990011';

  AppUserRole role = AppUserRole.guest;
  bool disabilityProfileComplete = false;
  bool volunteerProfileComplete = false;
  bool volunteerAvailable = false;

  int volunteerPoints = 120;
  double volunteerRating = 4.8;
  int servicesCompleted = 12;

  String userFullNameFor(Locale locale) =>
      locale.languageCode == 'ar' ? userFullNameAr : userFullNameEn;

  /// `volunteerSide` كما في الشاشة: `true` = أنا متطوع، الطرف الآخر طالب المساعدة.
  String peerFullNameInService(bool volunteerSide, Locale locale) {
    final ar = locale.languageCode == 'ar';
    if (volunteerSide) {
      return ar ? requesterFullNameAr : requesterFullNameEn;
    }
    return ar ? volunteerPeerFullNameAr : volunteerPeerFullNameEn;
  }

  String peerPhotoInService(bool volunteerSide) =>
      volunteerSide ? requesterPhotoUrl : volunteerPeerPhotoUrl;

  String peerPhoneInService(bool volunteerSide) =>
      volunteerSide ? requesterPhone : volunteerPeerPhone;

  void setLocale(Locale value) {
    if (_locale == value) return;
    _locale = value;
    notifyListeners();
  }

  void setRole(AppUserRole r) {
    role = r;
    notifyListeners();
  }

  void setDisabilityProfileComplete(bool v) {
    disabilityProfileComplete = v;
    notifyListeners();
  }

  void setVolunteerProfileComplete(bool v) {
    volunteerProfileComplete = v;
    notifyListeners();
  }

  void setVolunteerAvailable(bool v) {
    volunteerAvailable = v;
    notifyListeners();
  }

  String get homeRoute {
    switch (role) {
      case AppUserRole.disability:
        return '/home-disability';
      case AppUserRole.volunteer:
        return '/home-volunteer';
      case AppUserRole.both:
        return '/home-combined';
      case AppUserRole.guest:
        return '/guest';
    }
  }
}
