class BannerModel {
  final int id;
  final String title;
  final String slug;
  final String? description;
  final String image;
  final String? link;
  final String? buttonText;
  final String position;
  final String positionLabel;
  final int sortOrder;
  final bool isActive;
  final bool isFeatured;
  final bool isCurrentlyActive;
  final String? startsAt;
  final String? endsAt;
  final String createdAt;
  final String updatedAt;

  BannerModel({
    required this.id,
    required this.title,
    required this.slug,
    this.description,
    required this.image,
    this.link,
    this.buttonText,
    required this.position,
    required this.positionLabel,
    required this.sortOrder,
    required this.isActive,
    required this.isFeatured,
    required this.isCurrentlyActive,
    this.startsAt,
    this.endsAt,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a BannerModel instance from a Map (e.g., from database query)
  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'] as int,
      title: map['title'] as String,
      slug: map['slug'] as String,
      description: map['description'] as String?,
      image: map['image'] as String,
      link: map['link'] as String?,
      buttonText: map['button_text'] as String?,
      position: map['position'] as String,
      positionLabel: map['position_label'] as String,
      sortOrder: map['sort_order'] as int,
      isActive: map['is_active'] as bool,
      isFeatured: map['is_featured'] as bool,
      isCurrentlyActive: map['is_currently_active'] as bool,
      startsAt: map['starts_at'] as String?,
      endsAt: map['ends_at'] as String?,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }
}




class BannersModel {
  final bool success;
  final List<BannerModel> banners;

  BannersModel({
    required this.success,
    required this.banners,
  });

  // Create a BannersModel instance from a Map (e.g., from database query)
  factory BannersModel.fromMap(Map<String, dynamic> map) {
    return BannersModel(
      success: map['success'] as bool,
      banners: (map['data'] as List<dynamic>)
          .map((category) => BannerModel.fromMap(category as Map<String, dynamic>))
          .toList(),
    );
  }
}