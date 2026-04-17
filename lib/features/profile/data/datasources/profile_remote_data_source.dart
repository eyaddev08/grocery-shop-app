import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../../../../core/error/exception.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> updateProfile(ProfileModel profile);
  Future<String> uploadAvatar(File image);
  Future<void> changePassword(String current, String newPassword);
  Future<void> logout();
  Future<void> deleteAccount();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl(this.dio);
  final Dio dio;

  Future<Map<String, dynamic>> _loadMockData() async {
    final String response =
        await rootBundle.loadString('assets/mock_api/profile_mock.json');
    return await json.decode(response) as Map<String, dynamic>;
  }

  @override
  Future<ProfileModel> getProfile() async {
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      final mockData = await _loadMockData();
      final data = mockData['get_profile'] as Map<String, dynamic>;
      return ProfileModel.fromJson(data['data'] as Map<String, dynamic>);
    } catch (e) {
      throw ServerException('Failed to load profile mock data');
    }
  }

  @override
  Future<ProfileModel> updateProfile(ProfileModel profile) async {
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      final mockData = await _loadMockData();
      final data = mockData['update_profile'] as Map<String, dynamic>;

      // Merge realistic updates
      final parsedProfile =
          ProfileModel.fromJson(data['data'] as Map<String, dynamic>);
      return ProfileModel(
        id: parsedProfile.id,
        name: profile.name,
        email: profile.email,
        phone: profile.phone ?? parsedProfile.phone,
        address: profile.address ?? parsedProfile.address,
        avatarUrl: profile.avatarUrl ?? parsedProfile.avatarUrl,
        createdAt: parsedProfile.createdAt,
      );
    } catch (e) {
      throw ServerException('Failed to update profile mock data');
    }
  }

  @override
  Future<String> uploadAvatar(File image) async {
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      // final mockData = await _loadMockData();
      // final data = mockData['upload_avatar'] as Map<String, dynamic>;
      // final uploadResponse =
      //     UploadResponseModel.fromJson(data['data'] as Map<String, dynamic>);
      // return uploadResponse.avatarUrl;
      // MOCK logic: Return the device's local path rather than a parsed generic http mock string
      return image.path;
    } catch (e) {
      throw ServerException('Failed to upload avatar mock data');
    }
  }

  @override
  Future<void> changePassword(String current, String newPassword) async {
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      // In mock, let's assume valid password is 'password' for testing error states,
      // but if current is 'password' we succeed, else we can simulate success anyway.
    } catch (e) {
      throw ServerException('Failed to change password mock data');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      throw ServerException('Failed to logout mock data');
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      throw ServerException('Failed to delete account mock data');
    }
  }
}
