class Pagination<T> {
  final String? next;
  final int itemCount;
  final List<T> items;

  Pagination({required this.next, required this.itemCount, required this.items});

  Pagination<T> merge(Pagination<T> other) => Pagination(next: other.next, itemCount: other.itemCount, items: items + other.items);

  factory Pagination.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic> json) itemFromJson) => Pagination<T>(
      next: (((json['_links'] as Map)['next'] as Map?)?['href']) as String?,
      items: (json['hits'] as List).map((e) => itemFromJson(e)).toList(),
      itemCount: json['count'] as int);
}
