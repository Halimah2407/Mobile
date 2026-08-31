class UserModel {
  final String id;
  final String name;
  final String? email;
  final int age;
  final bool isActive; 

UserModel({
    required this.id,
    required this.name, 
    this.email, 
    required this.age, 
    required this.isActive
 });

factory UserModel.fromJson(Map json) {
  return UserModel(

    id: json['id'] as String? ?? '',

    name: json['name'] as String? ?? 'Unknown User',

    email: json['email'] as String?,

    age: json['age'] as int? ?? 0,

    isActive: json['isActive'] as bool? ?? false,
  ); 
}

Map toJson() {
  return {
    'id': id,
    'name': name,
    'email': email,
    'age': age,
    'isActive': isActive,
  };
}
}

void main() {
  Map jsonResponse = {
    'name': 'Budi Santoso',
    'age': 22,
  };

UserModel user = UserModel.fromJson(jsonResponse);

print('Nama: ${user.name}');
print('ID: ${user.id}');
print('Status: ${user.isActive}');

print('To Json: ${user.toJson()}');
}
