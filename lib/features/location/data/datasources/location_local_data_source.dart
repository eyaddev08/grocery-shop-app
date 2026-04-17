import 'package:hive/hive.dart';
import 'package:grocery_shop_app/features/location/data/models/location_model.dart';

abstract class LocationLocalDataSource {
  Future<void> cacheLocation(LocationModel location);
  Future<List<LocationModel>> getLastLocations();
}

class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  LocationLocalDataSourceImpl(this.box);
  static const String locationCacheBoxName = 'location_cache_box';
  static const int maxCachedLocations = 2;

  final Box<LocationModel> box;

  @override
  Future<void> cacheLocation(LocationModel location) async {
    await box.add(location);

    if (box.length > maxCachedLocations) {
      final overflow = box.length - maxCachedLocations;
      final keysToDelete = box.keys.take(overflow).toList();
      await box.deleteAll(keysToDelete);
    }
  }

  @override
  Future<List<LocationModel>> getLastLocations() async {
    final items = box.values.toList();
    items.sort((a, b) => b.pickedAt.compareTo(a.pickedAt));
    return items;
  }
}
