class Product{

  String _title;
  String _description;
  int _id;
  String _image;
  int _quantity;
  int _status;
  String _category;
  int _price;

  int get price => _price;

  set price(int value) {
    _price = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get description => _description;


  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
  }

  @override
  String toString() {
    return 'Product{_title: $_title, _description: $_description, _id: $_id, _image: $_image, _quantity: $_quantity, _status: $_status, _category: $_category}';
  }



  int get status => _status;

  set status(int value) {
    _status = value;
  }



  String get image => _image;

  set image(String value) {
    _image = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  set description(String value) {
    _description = value;
  }

  String get category => _category;

  set category(String value) {
    _category = value;
  }
}