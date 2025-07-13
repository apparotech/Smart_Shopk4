
import 'package:flutter/material.dart';
import 'package:smart_shopk4/services/follow_service.dart';

class FollowViewModel extends ChangeNotifier {

  final FollowService _followService = FollowService();

  bool _isFollowing = false;
  bool  get isFollowing => _isFollowing;

  int _followerCount = 0;
  int _followingCount =0;

  int get followerCount => _followerCount;
  int get followingCount => _followingCount;



  // check if current user follows [userId]
Future<void> checkFollowStatus(String userId) async {
  _isFollowing = await _followService.isFollowing(userId);
  notifyListeners();
}

// Toggle follow/unfollow
Future<void> toggleFollow(String userId) async {
  if(_isFollowing) {
    await _followService.unfollowUser(userId);
    _isFollowing = false;
    _followerCount = (_followerCount -1).clamp(0, double.infinity ).toInt();
  } else {
    await _followService.followUser(userId);
    _isFollowing = true;
    _followerCount +=1;
  }
  notifyListeners();
}

// Load follow/follower counts

  Future<void> loadCounts(String userId) async {
    final data = await _followService.getFollowerAndFollowingCount(userId);
    _followerCount = data['followers'] ?? 0;
    _followingCount = data['following']?? 0;
    notifyListeners();
  }
}