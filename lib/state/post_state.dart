import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rivrpod_api/services/dio_get_service.dart';

import '../models/model.dart';

final postProvider =
    StateNotifierProvider<PostsNotifier, PostsState>((ref) => PostsNotifier());

@immutable
abstract class PostsState {}

class InitialPostsState extends PostsState {}

class LoadingPostsState extends PostsState {}

class LoadedPostsState extends PostsState {
  final List<Model> posts;
  LoadedPostsState({required this.posts});
}

class ErrorPostsState extends PostsState {
  final String message;
  ErrorPostsState({required this.message});
}

class PostsNotifier extends StateNotifier<PostsState> {
  PostsNotifier() : super(InitialPostsState());
  final DioGetPost _getPost = DioGetPost();
  void fetchPosts() async {
    try {
      state = LoadingPostsState();
      List<Model> posts = await _getPost.GetPosts();
      state = LoadedPostsState(posts: posts);
    } catch (e) {
      state = ErrorPostsState(message: e.toString());
    }
  }
}
