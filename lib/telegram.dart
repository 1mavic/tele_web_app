@JS('Telegram')
library web_app;

import 'package:js/js.dart';
import 'package:js/js.dart' show allowInterop;

abstract class JsObjectWrapper<T> {
  ///
  JsObjectWrapper(this.jsObject);

  /// Creates a new JsObjectWrapper type from a [jsObject].
  JsObjectWrapper.fromJsObject(this.jsObject);

  /// JS object.
  final T jsObject;
}

// ignore_for_file: public_member_api_docs, non_constant_identifier_names

external WebAppJsImpl get WebApp;

@JS()
external String get visualViewport;

/// {@template telegram_web}
/// A Telegram Web App part in JS
/// {@endtemplate}
@JS('WebApp')
abstract class WebAppJsImpl {
  external factory WebAppJsImpl();

  external String get initData;
  external WebAppInitDataJsImpl get initDataUnsafe;
  external String get colorScheme;
  external ThemeParamsJsImpl get themeParams;
  external bool get isExpanded;
  external num get viewportHeight;
  external num get viewportStableHeight;
  external MainButtonJsImpl get MainButton;
  external void onEvent(String eventType, void Function() eventHandler);
  external void offEvent(String eventType, void Function() eventHandler);
  external void sendData(String data);
  external void ready();
  external void expand();
  external void close();
}

@JS()
@anonymous
abstract class MainButtonJsImpl {
  external factory MainButtonJsImpl({
    String text,
    String color,
    String textColor,
    bool isVisible,
    bool isActive,
    bool isProgressVisible,
    void Function(String text) setText,
    void Function() onClick,
    void Function() show,
    void Function() hide,
    void Function() enable,
    void Function() disable,
    void Function(bool leaveActive) showProgress,
    void Function() hideProgress,
    void Function(MainButtonParams params) setParams,
  });

  external String get text;
  external String get color;
  external String get textColor;
  external bool get isVisible;
  external bool get isActive;
  external bool get isProgressVisible;
  external void setText(String text);
  external void onClick(void Function() callback);
  external void show();
  external void hide();
  external void enable();
  external void disable();
  // ignore: avoid_positional_boolean_parameters
  external void showProgress(bool leaveActive);
  external void hideProgress();
  external void setParams(MainButtonParams params);
}

@JS()
@anonymous
abstract class MainButtonParams {
  external factory MainButtonParams({
    String? text,
    String? color,
    String? text_color,
    bool? is_active,
    bool? is_visible,
  });

  external String? get text;
  external String? get color;
  external String? get text_color;
  external bool? get is_active;
  external bool? get is_visible;
}

@JS()
@anonymous
abstract class ThemeParamsJsImpl {
  external factory ThemeParamsJsImpl({
    String? bg_color,
    String? text_color,
    String? hint_color,
    String? link_color,
    String? button_color,
    String? button_text_color,
  });

  external String? get bg_color;
  external String? get text_color;
  external String? get hint_color;
  external String? get link_color;
  external String? get button_color;
  external String? get button_text_color;
}

@JS()
@anonymous
abstract class WebAppInitDataJsImpl {
  external factory WebAppInitDataJsImpl({
    String? query_id,
    WebAppUserJsImpl? user,
    WebAppUserJsImpl? receiver,
    String? start_param,
    num auth_date,
    String hash,
  });

  external String? get query_id;
  external WebAppUserJsImpl? get user;
  external WebAppUserJsImpl? get receiver;
  external String? get start_param;
  external num get auth_date;
  external String get hash;
}

@JS()
@anonymous
abstract class WebAppUserJsImpl {
  external factory WebAppUserJsImpl({
    num id,
    bool? is_bot,
    String? first_name,
    String? last_name,
    String? username,
    String? language_code,
    String? photo_url,
  });

  external num get id;
  external bool? get is_bot;
  external String get first_name;
  external String? get last_name;
  external String? get username;
  external String? get language_code;
  external String? get photo_url;
}

/// {@template tele_web_app}
/// Allows communication between your bot and the Web App built in Flutter
/// displayed inside Telegram
/// {@endtemplate}
class TeleWebApp extends JsObjectWrapper<WebAppJsImpl> {
  /// {@macro tele_web_app}
  factory TeleWebApp() {
    _instance ??= TeleWebApp._();
    return _instance!;
  }

  TeleWebApp._() : super(WebApp);

  static TeleWebApp? _instance;

  /// Raw data transferred to the Web App, convenient for validating data.
  ///
  /// WARNING: [Validate data](https://core.telegram.org/bots/webapps#validating-data-received-via-the-web-app)
  /// from this field before using it on the bot's server.
  String get initData => jsObject.initData;

  /// An object with input data transferred to the Web App.
  ///
  /// WARNING: Data from this field should not be trusted.
  /// You should only use data from initData on the bot's server and
  /// only after it has been [validated](https://core.telegram.org/bots/webapps#validating-data-received-via-the-web-app).
  WebAppInitData get initDataUnsafe =>
      WebAppInitData.fromJsObject(jsObject.initDataUnsafe);

  /// The color scheme currently used in the Telegram app.
  ///
  /// Either “light” or “dark”.
  String get colorScheme => jsObject.colorScheme;

  /// Containing the current theme settings used in the Telegram app.
  ThemeParams get themeParams => ThemeParams.fromJsObject(jsObject.themeParams);

  /// If the Web App expands to the maximum height available,
  /// its value is `true`.
  ///
  /// `false`, if the Web App occupies part of the screen and can
  /// be expanded to full height using the `expand()` method.
  bool get isExpanded => jsObject.isExpanded;

  /// The current height of the visible area of the Web App.
  double get viewportHeight => jsObject.viewportHeight.toDouble();

  /// The height of the visible area of the Web App in its last stable state.
  double get viewportStableHeight => jsObject.viewportStableHeight.toDouble();

  /// An object for controlling the main button.
  ///
  /// Is displayed at the bottom of the Web App in the Telegram interface.
  MainButton get mainButton => MainButton.fromJsObject(jsObject.MainButton);

  /// Sets the app event handler.
  ///
  /// Check the list of available events:
  ///
  /// - [WebAppEventType.themeChanged]
  ///
  ///   {@macro event_type_theme_changed}
  ///
  /// - [WebAppEventType.viewportChanged]
  ///
  ///   {@macro event_type_viewport_changed}
  ///
  /// - [WebAppEventType.mainButtonClicked]
  ///
  ///   {@macro event_type_main_button_clicked}
  void onEvent(WebAppEventType eventType, Function eventHandler) =>
      jsObject.onEvent(eventType.name, allowInterop(() => eventHandler));

  /// Deletes a previously set event handler.
  void offEvent(WebAppEventType eventType, Function eventHandler) =>
      jsObject.offEvent(eventType.name, allowInterop(() => eventHandler));

  /// Send data to the bot.
  ///
  /// When this method is called, a service message is sent to the bot
  /// containing the data data of the length up to 4096 bytes, and the
  /// Web App is closed. See the field web_app_data in the class
  /// [Message](https://core.telegram.org/bots/api#message).
  ///
  /// This method is only available for Web Apps launched via a
  /// [Keyboard button](https://core.telegram.org/bots/webapps#keyboard-button-web-apps).
  void sendData(String data) => jsObject.sendData(data);

  /// Informs the Telegram app that the Web App is ready to be displayed.
  ///
  /// It is recommended to call this method as early as possible,
  /// as soon as all essential interface elements are loaded.
  /// Once this method is called, the loading placeholder is hidden and
  /// the Web App is shown.
  ///
  /// If the method is not called, the placeholder will be hidden only
  /// when the page is fully loaded.
  void ready() => jsObject.ready();

  /// Expands the Web App to the maximum available height.
  ///
  /// To find out if the Web App is expanded to the maximum height,
  /// refer to the value of the [isExpanded] parameter
  void expand() => jsObject.expand();

  /// Close the Web App.
  void close() => jsObject.close();
}

/// {@template main_button}
/// It is responsible for controlling the main button.
///
/// Shown at the bottom of the web application in the Telegram interface.
/// {@endtemplate}
class MainButton extends JsObjectWrapper<MainButtonJsImpl> {
  /// Wrap a JS object.
  ///
  /// {@macro main_button}
  MainButton.fromJsObject(super.jsObject);

  /// Current button text.
  ///
  /// Set to CONTINUE by default.
  String get text => jsObject.text;

  /// Current button color.
  String get color => jsObject.color;

  /// Current button text color.
  String get textColor => jsObject.textColor;

  /// Shows whether the button is visible.
  ///
  /// Set to `false` by default.
  bool get isVisible => jsObject.isVisible;

  /// Shows whether the button is active.
  ///
  /// Set to `true` by default.
  bool get isActive => jsObject.isActive;

  /// Shows whether the button is displaying a loading indicator.
  bool get isProgressVisible => jsObject.isProgressVisible;

  ///	A method to set the button text.
  void setText(String text) => jsObject.setText(text);

  /// A method that sets the button press event handler.
  void onClick(void Function() callback) =>
      jsObject.onClick(allowInterop(callback));

  /// Make the button visible.
  void show() => jsObject.show();

  /// Hide the button.
  void hide() => jsObject.hide();

  /// Enable the button.
  void enable() => jsObject.enable();

  /// Disable the button.
  void disable() => jsObject.disable();

  /// Show a loading indicator on the button.
  ///
  /// It is recommended to display loading progress if the action tied
  /// to the button may take a long time. By default, the button is disabled
  /// while the action is in progress.
  void showProgress({bool leaveActive = true}) =>
      jsObject.showProgress(leaveActive);

  /// Hide the loading indicator.
  void hideProgress() => jsObject.hideProgress();

  /// Set the button parameters.
  void setParams({
    String? text,
    String? color,
    String? textColor,
    bool? isActive,
    bool? isVisible,
  }) =>
      jsObject.setParams(
        MainButtonParams(
          text: text,
          color: color,
          text_color: textColor,
          is_active: isActive,
          is_visible: isVisible,
        ),
      );
}

/// {@template theme_params}
/// Contains the user's current theme settings.
///
/// Web Apps can [adjust the appearance](https://core.telegram.org/bots/webapps#color-schemes)
/// of the interface to match the Telegram user's app in real time.
/// {@endtemplate}
class ThemeParams extends JsObjectWrapper<ThemeParamsJsImpl> {
  /// {@macro theme_params}
  ThemeParams.fromJsObject(super.jsObject);

  /// Background color in the #RRGGBB format.
  String? get bgColor => jsObject.bg_color;

  /// Main text color in the #RRGGBB format.
  String? get textColor => jsObject.text_color;

  /// Hint text color in the #RRGGBB format.
  String? get hintColor => jsObject.hint_color;

  /// Link color in the #RRGGBB format.
  String? get linkColor => jsObject.link_color;

  /// Button color in the #RRGGBB format.
  String? get buttonColor => jsObject.button_color;

  /// Button text color in the #RRGGBB format.
  String? get buttonTextColor => jsObject.button_text_color;
}

/// {@template webapp_init_data}
/// Contains data that is transferred to the Web App when it is opened.
///
/// It is empty if the Web App was launched from a
/// [keyboard button](https://core.telegram.org/bots/webapps#keyboard-button-web-apps).
/// {@endtemplate}
class WebAppInitData extends JsObjectWrapper<WebAppInitDataJsImpl> {
  /// {@macro webapp_init_data}
  WebAppInitData.fromJsObject(super.jsObject);

  /// A unique identifier for the Web App session.
  ///
  /// Required for sending messages via the
  /// [answerWebAppQuery](https://core.telegram.org/bots/api#answerwebappquery) method.
  String? get queryId => jsObject.query_id;

  /// Containing data about the current user.
  WebAppUser? get user => WebAppUser.fromJsObject(jsObject.user);

  /// Containing data about the chat partner of the current user in the chat
  /// where the bot was launched via the attachment menu.
  ///
  /// Returned only for Web Apps launched via the attachment menu.
  WebAppUser? get receiver => WebAppUser.fromJsObject(jsObject.receiver);

  /// The value of the startattach parameter, passed
  /// [via link](https://core.telegram.org/bots/webapps#adding-bots-to-the-attachment-menu).
  ///
  /// Only returned for Web Apps when launched from the `attachment`
  /// menu via link.
  ///
  /// The value of the `start_param` parameter will also be passed in
  /// the GET-parameter tgWebAppStartParam, so the Web App can load
  /// the correct interface right away.
  String? get startParam => jsObject.start_param;

  /// Time when the form was opened.
  DateTime get authDate =>
      DateTime.fromMillisecondsSinceEpoch(jsObject.auth_date as int);

  /// A hash of all passed parameters, which the bot server can use to
  /// [check their validity](https://core.telegram.org/bots/webapps#validating-data-received-via-the-web-app).
  String get hash => jsObject.hash;
}

/// {@template webapp_user}
/// Contains the data of the Web App user.
/// {@endtemplate}
class WebAppUser extends JsObjectWrapper<WebAppUserJsImpl?> {
  /// {@macro webapp_user}
  WebAppUser.fromJsObject(super.jsObject);

  /// A unique identifier for the user or bot.
  ///
  /// This number may have more than 32 significant bits and some programming
  /// languages may have difficulty/silent defects in interpreting it.
  /// It has at most 52 significant bits, so a 64-bit integer or a
  /// double-precision float type is safe for storing this identifier.
  int get id => jsObject!.id.toInt();

  /// True, if this user is a bot.
  ///
  /// Returns in the [receiver](https://core.telegram.org/bots/webapps#webappinitdata) field only.
  bool? get isBot => jsObject?.is_bot;

  /// First name of the user or bot.
  String? get firstName => jsObject?.first_name;

  /// Last name of the user or bot.
  String? get lastName => jsObject?.last_name;

  /// Username of the user or bot.
  String? get username => jsObject?.username;

  /// [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag) of the user's language.
  ///
  /// Returns in user field only.
  String? get languageCode => jsObject?.language_code;

  /// URL of the user’s profile photo.
  ///
  /// The photo can be in .jpeg or .svg formats.
  /// Only returned for Web Apps launched from the attachment menu.
  String? get photoUrl => jsObject?.photo_url;
}

/// {@template webapp_event_type}
/// Types of events that come from Telegram app.
/// {@endtemplate}
enum WebAppEventType {
  /// {@template event_type_theme_changed}
  /// Occurs whenever theme settings are changed in the user's Telegram app
  /// (including switching to night mode).
  ///
  /// `eventHandler` receives no parameters, new theme settings and color
  /// scheme can be received via this.themeParams and this.colorScheme
  /// respectively.
  /// {@endtemplate}
  themeChanged,

  /// {@template event_type_viewport_changed}
  /// Occurs when the visible section of the Web App is changed.
  ///
  /// `eventHandler` receives an parameter with the single field
  /// `isStateStable`.
  ///
  /// If `isStateStable = true`, the resizing of the Web App is finished.
  /// If it is `false`, the resizing is ongoing (the user is expanding or
  /// collapsing the Web App or an animated object is playing).
  /// The current value of the visible section’s height is available
  /// in `this.viewportHeight`.
  /// {@endtemplate}
  viewportChanged,

  /// {@template event_type_main_button_clicked}
  /// Occurs when the main button is pressed.
  /// eventHandler receives no parameters.
  /// {@endtemplate}
  mainButtonClicked
}
