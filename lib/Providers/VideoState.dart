import 'package:flutter/material.dart';
import '../Service/VideoListService.dart';
import 'dart:developer' as developer;

class VideoState with ChangeNotifier {

  String _sheetId = '';
  VideoModel _video;
  double _fps = 23.98;
  dynamic _overlayData;
  double _videoLength = 110;

  /// Active hotspot
  bool _isOnHotspotPage = false;
  String _activeOverlayId;
  String posterURL = "";

  // Playback State
  double _aspectRatio = 1.78;
  double _currentFrame = 0.0;
  int _currentTime = 0;
  VideoModel get video => _video;
  double get fps => _fps;
  double get aspectRatio => _aspectRatio;
  double get currentFrame => _currentFrame;
  int get currentTime => _currentTime;
  dynamic get overlayData => _overlayData;
  String get activeOverlayId => _activeOverlayId;
  double get videoLength => _videoLength;


  set activeOverlayId(String id) {
    _activeOverlayId = id;
    notifyListeners();
  }

  set fps(double newFps) {
    _fps = newFps;
    notifyListeners();
  }

  set aspectRatio(double ratio) {
    _aspectRatio = ratio;
    notifyListeners();
  }

  set currentFrame(double frame) {
    _currentFrame = frame;
    notifyListeners();
  }

  set currentTime(int time) {
    _currentTime = time;
    notifyListeners();
  }

  set videoLength(double length) {
    _videoLength = length;
    notifyListeners();
  }

}