import 'open_external_url_stub.dart'
    if (dart.library.js_interop) 'open_external_url_web.dart';

void openExternalUrl(String url) {
  openExternalUrlImpl(url);
}
