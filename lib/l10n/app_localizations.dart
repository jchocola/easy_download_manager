import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('de'),
    Locale('en'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('ru'),
    Locale('uk'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// No description provided for @aboutTheApp.
  ///
  /// In en, this message translates to:
  /// **'About the app'**
  String get aboutTheApp;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @addDownload.
  ///
  /// In en, this message translates to:
  /// **'Add download'**
  String get addDownload;

  /// No description provided for @additionalInformation.
  ///
  /// In en, this message translates to:
  /// **'Additional information'**
  String get additionalInformation;

  /// No description provided for @additionalParameters.
  ///
  /// In en, this message translates to:
  /// **'Additional parameters'**
  String get additionalParameters;

  /// No description provided for @advice.
  ///
  /// In en, this message translates to:
  /// **'Advice'**
  String get advice;

  /// No description provided for @allRightsReserved.
  ///
  /// In en, this message translates to:
  /// **'All rights reserved'**
  String get allRightsReserved;

  /// No description provided for @attention.
  ///
  /// In en, this message translates to:
  /// **'Attention'**
  String get attention;

  /// No description provided for @atTheMomentYouCanDownloadOneTorrentAtATimeWeReWorkingOnAddingSupportForMultipleSimultaneousDownloadsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'At the moment, you can download one torrent at a time. We\'re working on adding support for multiple simultaneous downloads coming soon!'**
  String
  get atTheMomentYouCanDownloadOneTorrentAtATimeWeReWorkingOnAddingSupportForMultipleSimultaneousDownloadsComingSoon;

  /// No description provided for @audibleAlerts.
  ///
  /// In en, this message translates to:
  /// **'AUDIBLE ALERTS'**
  String get audibleAlerts;

  /// No description provided for @automaticallyPauseDownloadsWhenRoamingInternationally.
  ///
  /// In en, this message translates to:
  /// **'Automatically pause downloads when roaming internationally'**
  String get automaticallyPauseDownloadsWhenRoamingInternationally;

  /// No description provided for @automaticRenewal.
  ///
  /// In en, this message translates to:
  /// **'AUTOMATIC RENEWAL'**
  String get automaticRenewal;

  /// No description provided for @basicSettings.
  ///
  /// In en, this message translates to:
  /// **'BASIC SETTINGS'**
  String get basicSettings;

  /// No description provided for @buildDate.
  ///
  /// In en, this message translates to:
  /// **'Build date'**
  String get buildDate;

  /// No description provided for @byAscending.
  ///
  /// In en, this message translates to:
  /// **'By ascending'**
  String get byAscending;

  /// No description provided for @byDate.
  ///
  /// In en, this message translates to:
  /// **'By date'**
  String get byDate;

  /// No description provided for @byDescending.
  ///
  /// In en, this message translates to:
  /// **'By descending'**
  String get byDescending;

  /// No description provided for @byName.
  ///
  /// In en, this message translates to:
  /// **'By name'**
  String get byName;

  /// No description provided for @bySize.
  ///
  /// In en, this message translates to:
  /// **'By size'**
  String get bySize;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cannotOpenFileMaybeFileNotExists.
  ///
  /// In en, this message translates to:
  /// **'Cannot open file. Maybe file not exists'**
  String get cannotOpenFileMaybeFileNotExists;

  /// No description provided for @categoriesSettings.
  ///
  /// In en, this message translates to:
  /// **'CATEGORIES SETTINGS'**
  String get categoriesSettings;

  /// No description provided for @cloud.
  ///
  /// In en, this message translates to:
  /// **'Cloud'**
  String get cloud;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @configureBehaviorWhenNetworkConnectionChanges.
  ///
  /// In en, this message translates to:
  /// **'Configure behavior when network connection changes'**
  String get configureBehaviorWhenNetworkConnectionChanges;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue_text'**
  String get continueText;

  /// No description provided for @createdBy.
  ///
  /// In en, this message translates to:
  /// **'Created by'**
  String get createdBy;

  /// No description provided for @creationDate.
  ///
  /// In en, this message translates to:
  /// **'Creation date'**
  String get creationDate;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteFile.
  ///
  /// In en, this message translates to:
  /// **'Delete file'**
  String get deleteFile;

  /// No description provided for @developer.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developer;

  /// No description provided for @directDownloadFromWebServer.
  ///
  /// In en, this message translates to:
  /// **'Direct download from web server'**
  String get directDownloadFromWebServer;

  /// No description provided for @downloadConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Download confirmation'**
  String get downloadConfirmation;

  /// No description provided for @downloadDetails.
  ///
  /// In en, this message translates to:
  /// **'Download details'**
  String get downloadDetails;

  /// No description provided for @downloadError.
  ///
  /// In en, this message translates to:
  /// **'Download error'**
  String get downloadError;

  /// No description provided for @downloadHistory.
  ///
  /// In en, this message translates to:
  /// **'Download history'**
  String get downloadHistory;

  /// No description provided for @downloadingFromCloudServices.
  ///
  /// In en, this message translates to:
  /// **'Downloading from cloud services'**
  String get downloadingFromCloudServices;

  /// No description provided for @downloadingViaTorrentProtocol.
  ///
  /// In en, this message translates to:
  /// **'Downloading via Torrent Protocol'**
  String get downloadingViaTorrentProtocol;

  /// No description provided for @downloadOnlyViaWiFi.
  ///
  /// In en, this message translates to:
  /// **'Download only via Wi-Fi'**
  String get downloadOnlyViaWiFi;

  /// No description provided for @downloads.
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get downloads;

  /// No description provided for @downloadsWillOnlyBeAvailableWhenConnectedToAWiFiNetwork.
  ///
  /// In en, this message translates to:
  /// **'Downloads will only be available when connected to a Wi-Fi network.'**
  String get downloadsWillOnlyBeAvailableWhenConnectedToAWiFiNetwork;

  /// No description provided for @downloadType.
  ///
  /// In en, this message translates to:
  /// **'Download type'**
  String get downloadType;

  /// No description provided for @downloadViaWiFi.
  ///
  /// In en, this message translates to:
  /// **'Download via Wi-Fi'**
  String get downloadViaWiFi;

  /// No description provided for @editSettings.
  ///
  /// In en, this message translates to:
  /// **'Edit settings'**
  String get editSettings;

  /// No description provided for @edmEasyDownloadManager.
  ///
  /// In en, this message translates to:
  /// **'EDM- Easy Download Manager'**
  String get edmEasyDownloadManager;

  /// No description provided for @enableDownloadOnlyViaWiFiAndPauseWhenRoamingToSaveMobileDataAndReduceCosts.
  ///
  /// In en, this message translates to:
  /// **'Enable “Download only via Wi-Fi” and “Pause when roaming” to save mobile data and reduce costs.'**
  String
  get enableDownloadOnlyViaWiFiAndPauseWhenRoamingToSaveMobileDataAndReduceCosts;

  /// No description provided for @enableDownloadSpeedLimit.
  ///
  /// In en, this message translates to:
  /// **'Enable download speed limit'**
  String get enableDownloadSpeedLimit;

  /// No description provided for @enableGeneralSpeedLimit.
  ///
  /// In en, this message translates to:
  /// **'Enable general speed limit'**
  String get enableGeneralSpeedLimit;

  /// No description provided for @enableSoundNotificationsSoYouDonTMissImportantDownloadsCompletingTheProgressBarHelpsYouTrackDownloadsWithoutOpeningTheApp.
  ///
  /// In en, this message translates to:
  /// **'Enable sound notifications so you don\'t miss important downloads completing. The progress bar helps you track downloads without opening the app.'**
  String
  get enableSoundNotificationsSoYouDonTMissImportantDownloadsCompletingTheProgressBarHelpsYouTrackDownloadsWithoutOpeningTheApp;

  /// No description provided for @encoding.
  ///
  /// In en, this message translates to:
  /// **'Encoding'**
  String get encoding;

  /// No description provided for @ensureThatAllDownloadSettingsAreConfiguredCorrectlyBeforeConfirming.
  ///
  /// In en, this message translates to:
  /// **'Ensure that all download settings are configured correctly before confirming.'**
  String
  get ensureThatAllDownloadSettingsAreConfiguredCorrectlyBeforeConfirming;

  /// No description provided for @enterTheLinkToTheFileForDownload.
  ///
  /// In en, this message translates to:
  /// **'Enter the link to the file for download'**
  String get enterTheLinkToTheFileForDownload;

  /// No description provided for @errors.
  ///
  /// In en, this message translates to:
  /// **'Errors'**
  String get errors;

  /// No description provided for @fileDeleted.
  ///
  /// In en, this message translates to:
  /// **'File deleted'**
  String get fileDeleted;

  /// No description provided for @fileName.
  ///
  /// In en, this message translates to:
  /// **'File name'**
  String get fileName;

  /// No description provided for @fileNotExists.
  ///
  /// In en, this message translates to:
  /// **'File not exists'**
  String get fileNotExists;

  /// No description provided for @files.
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get files;

  /// No description provided for @getNotifiedWhenTheDownloadIsComplete.
  ///
  /// In en, this message translates to:
  /// **'Get notified when the download is complete'**
  String get getNotifiedWhenTheDownloadIsComplete;

  /// No description provided for @hash.
  ///
  /// In en, this message translates to:
  /// **'Hash'**
  String get hash;

  /// No description provided for @httpHttps.
  ///
  /// In en, this message translates to:
  /// **'HTTP/HTTPS'**
  String get httpHttps;

  /// No description provided for @ifDownloadsAreNotProgressingStopTheForegroundDeleteADownloadAndRestartIt.
  ///
  /// In en, this message translates to:
  /// **'If downloads are not progressing, stop the foreground , delete a download, and restart it.'**
  String
  get ifDownloadsAreNotProgressingStopTheForegroundDeleteADownloadAndRestartIt;

  /// No description provided for @insertUrl.
  ///
  /// In en, this message translates to:
  /// **'Insert URL ...'**
  String get insertUrl;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @legalInformation.
  ///
  /// In en, this message translates to:
  /// **'LEGAL INFORMATION'**
  String get legalInformation;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @manageDownloadNotificationsAndSoundAlerts.
  ///
  /// In en, this message translates to:
  /// **'Manage download notifications and sound alerts'**
  String get manageDownloadNotificationsAndSoundAlerts;

  /// No description provided for @maximumSpeed.
  ///
  /// In en, this message translates to:
  /// **'Maximum speed'**
  String get maximumSpeed;

  /// No description provided for @network.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get network;

  /// No description provided for @networkManagement.
  ///
  /// In en, this message translates to:
  /// **'Network management'**
  String get networkManagement;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @notifyWhenCompleted.
  ///
  /// In en, this message translates to:
  /// **'Notify when completed'**
  String get notifyWhenCompleted;

  /// No description provided for @numberOfFiles.
  ///
  /// In en, this message translates to:
  /// **'Number of files'**
  String get numberOfFiles;

  /// No description provided for @numberOfPieces.
  ///
  /// In en, this message translates to:
  /// **'Number of pieces'**
  String get numberOfPieces;

  /// No description provided for @onlyWiFi.
  ///
  /// In en, this message translates to:
  /// **'Only Wi-Fi'**
  String get onlyWiFi;

  /// No description provided for @onPause.
  ///
  /// In en, this message translates to:
  /// **'On pause'**
  String get onPause;

  /// No description provided for @openFile.
  ///
  /// In en, this message translates to:
  /// **'Open file'**
  String get openFile;

  /// No description provided for @optimizationAdvice.
  ///
  /// In en, this message translates to:
  /// **'Optimization advice'**
  String get optimizationAdvice;

  /// No description provided for @optionalDownloadSettings.
  ///
  /// In en, this message translates to:
  /// **'Optional download settings'**
  String get optionalDownloadSettings;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @otherSettings.
  ///
  /// In en, this message translates to:
  /// **'OTHER SETTINGS'**
  String get otherSettings;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @paused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get paused;

  /// No description provided for @pickTorrentFile.
  ///
  /// In en, this message translates to:
  /// **'Pick torrent file'**
  String get pickTorrentFile;

  /// No description provided for @pieceSize.
  ///
  /// In en, this message translates to:
  /// **'Piece size'**
  String get pieceSize;

  /// No description provided for @playSoundWhenDownloadIsComplete.
  ///
  /// In en, this message translates to:
  /// **'Play sound when download is complete'**
  String get playSoundWhenDownloadIsComplete;

  /// No description provided for @pleaseEnterTheFileNameWithExtensionExPdfMp4Mp3IfDonTKnowLeaveItAsDefault.
  ///
  /// In en, this message translates to:
  /// **'Please enter the file name with extension (ex: .pdf, .mp4, .mp3)\nIf don\'t know, leave it as default.'**
  String
  get pleaseEnterTheFileNameWithExtensionExPdfMp4Mp3IfDonTKnowLeaveItAsDefault;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @private.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get private;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @quickSelection.
  ///
  /// In en, this message translates to:
  /// **'Quick selection'**
  String get quickSelection;

  /// No description provided for @quickSwitches.
  ///
  /// In en, this message translates to:
  /// **'QUICK SWITCHES'**
  String get quickSwitches;

  /// No description provided for @resumeDownloadsWhenNetworkConnectionIsRestored.
  ///
  /// In en, this message translates to:
  /// **'Resume downloads when network connection is restored'**
  String get resumeDownloadsWhenNetworkConnectionIsRestored;

  /// No description provided for @roaming.
  ///
  /// In en, this message translates to:
  /// **'ROAMING'**
  String get roaming;

  /// No description provided for @roamingPause.
  ///
  /// In en, this message translates to:
  /// **'Roaming pause'**
  String get roamingPause;

  /// No description provided for @saveFolder.
  ///
  /// In en, this message translates to:
  /// **'Save folder'**
  String get saveFolder;

  /// No description provided for @selectFile.
  ///
  /// In en, this message translates to:
  /// **'Select file'**
  String get selectFile;

  /// No description provided for @selectHowYouWantToDownloadTheFile.
  ///
  /// In en, this message translates to:
  /// **'Select how you want to download the file'**
  String get selectHowYouWantToDownloadTheFile;

  /// No description provided for @selectWhereToSaveTheFile.
  ///
  /// In en, this message translates to:
  /// **'Select where to save the file'**
  String get selectWhereToSaveTheFile;

  /// No description provided for @setASpeedLimitToReserveBandwidthForOtherApplicationsAndEnsureAStableConnection.
  ///
  /// In en, this message translates to:
  /// **'Set a speed limit to reserve bandwidth for other applications and ensure a stable connection.'**
  String
  get setASpeedLimitToReserveBandwidthForOtherApplicationsAndEnsureAStableConnection;

  /// No description provided for @setSpeedLimitsAndRulesForAutomaticEnforcement.
  ///
  /// In en, this message translates to:
  /// **'Set speed limits and rules for automatic enforcement'**
  String get setSpeedLimitsAndRulesForAutomaticEnforcement;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @sorting.
  ///
  /// In en, this message translates to:
  /// **'Sorting'**
  String get sorting;

  /// No description provided for @speed.
  ///
  /// In en, this message translates to:
  /// **'Speed'**
  String get speed;

  /// No description provided for @speedLimit.
  ///
  /// In en, this message translates to:
  /// **'Speed limit'**
  String get speedLimit;

  /// No description provided for @startDownloading.
  ///
  /// In en, this message translates to:
  /// **'Start downloading'**
  String get startDownloading;

  /// No description provided for @storageLocation.
  ///
  /// In en, this message translates to:
  /// **'Storage location'**
  String get storageLocation;

  /// No description provided for @suspendWhileRoaming.
  ///
  /// In en, this message translates to:
  /// **'Suspend while roaming'**
  String get suspendWhileRoaming;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @tipsForSavingTraffic.
  ///
  /// In en, this message translates to:
  /// **'Tips for saving traffic'**
  String get tipsForSavingTraffic;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @torrent.
  ///
  /// In en, this message translates to:
  /// **'Torrent'**
  String get torrent;

  /// No description provided for @torrentInformation.
  ///
  /// In en, this message translates to:
  /// **'Torrent information'**
  String get torrentInformation;

  /// No description provided for @torrentnotificationcontent.
  ///
  /// In en, this message translates to:
  /// **'Frequently sign in to the app to avoid interruptions (every 10 minutes)'**
  String get torrentnotificationcontent;

  /// No description provided for @torrentnotificationtitle.
  ///
  /// In en, this message translates to:
  /// **'Downloading torrent file'**
  String get torrentnotificationtitle;

  /// No description provided for @torrents.
  ///
  /// In en, this message translates to:
  /// **'Torrents'**
  String get torrents;

  /// No description provided for @totalFileSize.
  ///
  /// In en, this message translates to:
  /// **'Total file size'**
  String get totalFileSize;

  /// No description provided for @totalSize.
  ///
  /// In en, this message translates to:
  /// **'Total size'**
  String get totalSize;

  /// No description provided for @url.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get url;

  /// No description provided for @urlDownloads.
  ///
  /// In en, this message translates to:
  /// **'URL Downloads'**
  String get urlDownloads;

  /// No description provided for @useSpeedLimitsToSaveBandwidthAndPreventNetworkOverloadNetworkSettingsWillHelpOptimizeDownloadsDependingOnTheTypeOfConnection.
  ///
  /// In en, this message translates to:
  /// **'Use speed limits to save bandwidth and prevent network overload. Network settings will help optimize downloads depending on the type of connection.'**
  String
  get useSpeedLimitsToSaveBandwidthAndPreventNetworkOverloadNetworkSettingsWillHelpOptimizeDownloadsDependingOnTheTypeOfConnection;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'fr',
    'hi',
    'it',
    'ja',
    'ko',
    'ru',
    'uk',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ru':
      return AppLocalizationsRu();
    case 'uk':
      return AppLocalizationsUk();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
