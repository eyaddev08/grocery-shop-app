
class UploadResponseModel {

  const UploadResponseModel({required this.avatarUrl});

  factory UploadResponseModel.fromJson(Map<String, dynamic> json) => UploadResponseModel(
      avatarUrl: json['avatar_url'] as String,
    );
  final String avatarUrl;
}