import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

import 'dart:developer' as developer;

class VideoListService {
  // Load spreadsheet list from wwx server

}

class VideoModel {
  String title;
  String url;
  String posterFrame;
  String poster;
  String videoId;
  String sheetId;
  String genre;
  String year;
  String length;
  String storyline;

  VideoModel({
    this.videoId,
    this.title,
    this.url,
    this.posterFrame,
    this.sheetId,
    this.genre,
    this.year,
    this.length,
    this.storyline
  });

  factory VideoModel.fromJson(Map<String, dynamic> item) {
    VideoModel video = VideoModel();

    video.videoId = item['videoid'];
    video.title = item['title'];
    video.url = item['url'];
    video.posterFrame = item['posterframe'];
    video.poster = item['poster'];
    video.sheetId = item['overlaysheetid'];
    video.genre = item['genre'];
    video.year = item['year'];
    video.length = item['length'];
    video.storyline = item['storyline'];
    return video;
  }
}
