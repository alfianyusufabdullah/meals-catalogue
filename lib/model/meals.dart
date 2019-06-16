class Meals {
  final String id;
  final String name;
  final String thumb;
  final List<String> tags;
  final List<String> ingredient;
  final List<String> steps;

  Meals(this.id, this.name, this.thumb,
      {this.tags, this.ingredient, this.steps});
}
