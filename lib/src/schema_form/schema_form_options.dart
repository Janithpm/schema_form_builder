class SchemaFormOptions {
  final Function next;
  final Function previous;
  final String title;
  final int currentPage;
  final bool isLastPage;

  SchemaFormOptions({
    required this.next,
    required this.previous,
    required this.title,
    required this.currentPage,
    required this.isLastPage,
  });
}