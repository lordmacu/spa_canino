class Coupon {
  String _name;
  String _price;
  String _code;
  String _date;
  String _description;
  String _color;
  int _id;
 bool _isUsed;

  bool get isUsed => _isUsed;

  set isUsed(bool value) {
    _isUsed = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get color => _color;

  set color(String value) {
    _color = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }


  @override
  String toString() {
    return 'Coupon{_name: $_name, _price: $_price, _code: $_code, _date: $_date, _description: $_description, _color: $_color}';
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }


  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get code => _code;

  set code(String value) {
    _code = value;
  }

  String get price => _price;

  set price(String value) {
    _price = value;
  }
}