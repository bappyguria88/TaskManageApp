class AddNewTaskModel {
  final String title;
  final String description;
  final String stastus;

  AddNewTaskModel( {required this.title, required this.description, required this.stastus,});

  Map<String,dynamic>toJson(){
    return {
      'title': title,
      'description': description,
      'status': 'New'
    };
  }
}