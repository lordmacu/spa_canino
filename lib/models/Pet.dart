class Pet {
  String _name;
  String _image;
  int _user_id;
  int _raza;
  int _type;
  int _status;
  int _id;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String _razaText;
  String _typeText;
  String _statusText;

  String get razaText => _razaText;

  set razaText(String value) {
    _razaText = value;
  }

  String _color;
  String _birthday;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get image => _image;

  String get birthday => _birthday;


  @override
  String toString() {
    return 'Pet{_name: $_name, _image: $_image, _user_id: $_user_id, _raza: $_raza, _type: $_type, _status: $_status, _razaText: $_razaText, _typeText: $_typeText, _statusText: $_statusText, _color: $_color, _birthday: $_birthday}';
  }

  set birthday(String value) {
    _birthday = value;
  }

  String get color => _color;

  set color(String value) {
    _color = value;
  }

  int get status => _status;

  set status(int value) {
    _status = value;
  }

  int get type => _type;

  set type(int value) {
    _type = value;
  }

  int get raza => _raza;

  set raza(int value) {
    _raza = value;
  }

  int get user_id => _user_id;

  set user_id(int value) {
    _user_id = value;
  }

  set image(String value) {
    _image = value;
  }

  String get typeText => _typeText;

  set typeText(String value) {
    _typeText = value;
  }

  String get statusText => _statusText;

  set statusText(String value) {
    _statusText = value;
  }
}
