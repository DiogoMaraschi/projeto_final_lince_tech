import 'package:flutter/foundation.dart';

import '../../core/database/database_helper.dart';
import '../../entities/profile.dart';
import 'profile_model.dart';

abstract class ProfileRepository {
  Future<int> insert(Profile profile);

  Future<int> update(Profile profile);

  Future<Profile?> getProfile();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final DatabaseHelper databaseHelper;

  ProfileRepositoryImpl({required this.databaseHelper});

  static const String tableName = 'profile';

  @override
  Future<int> insert(Profile profile) async {
    final profileModel = ProfileModel.fromEntity(profile);

    final conn = await databaseHelper.database;

    return await conn.insert(tableName, profileModel.toMap());
  }

  @override
  Future<int> update(Profile profile) async {
    final profileModel = ProfileModel.fromEntity(profile);

    final conn = await databaseHelper.database;

    return conn.update(
      tableName,
      profileModel.toMap(),
      where: 'id = ?',
      whereArgs: [profile.id],
    );
  }

  @override
  Future<Profile?> getProfile() async {
    final conn = await databaseHelper.database;
    final result =await conn.query(tableName);

    if (result.isEmpty) return null;

    return ProfileModel.fromMap(result.first);
  }
}
