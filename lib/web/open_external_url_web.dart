import 'dart:js_interop';

@JS('window.open')
external JSAny? _openBrowserWindow(JSString url, JSString target);

void openExternalUrlImpl(String url) {
  _openBrowserWindow(url.toJS, '_blank'.toJS);
}
