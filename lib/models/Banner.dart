class Banner {
  String _url;
  String _banner;

  String get url => _url;

  @override
  String toString() {
    return 'Banner{_url: $_url, _banner: $_banner}';
  }

  Banner(this._url, this._banner);

  set url(String value) {
    _url = value;
  }

  String get banner => _banner;

  set banner(String value) {
    _banner = value;
  }
}
