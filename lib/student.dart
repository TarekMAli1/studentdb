class Students {
  int id;
  String name;
  int age;
  Students(this.id, this.name, this.age);
  // Dog({required this.id, required this.name, required this.age});
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'age': age,
      };

  Map<String, dynamic> toMapWithoutId() => {
        'name': name,
        'age': age,
      };
}
