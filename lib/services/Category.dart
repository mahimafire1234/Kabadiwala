class Category{
  final String userID;
  final List<Map> category_rate;

  Category({
    required this.userID,
    required this.category_rate
  });

  factory Category.fromJson(Map<String,dynamic> json){
    return Category(userID: json["userID"], category_rate: json["category_rate"]);
  }
}