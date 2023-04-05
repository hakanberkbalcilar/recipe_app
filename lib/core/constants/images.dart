class Images {
  static String asPng(String path) => 'assets/images/$path.png';
  static String asJpg(String path) => 'assets/images/$path.jpg';

  static final String logo = asPng('logo');
  static final String homeHeaderBackground = asJpg('home_header_background');
  static final String calculating = asPng('calculating');
  static final String documents = asPng('documents');
  static final String error = asPng('error');
  static final String installation = asPng('installation');
  static final String contacts = asPng('contacts');
  static final String shop = asPng('shop');
}
