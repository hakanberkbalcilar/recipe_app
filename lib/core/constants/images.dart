class Images {
  static String asPng(String path) => 'assets/images/$path.png';
  static String asJpg(String path) => 'assets/images/$path.jpg';

  static final String icon = asPng('icon');
}
