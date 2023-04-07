import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rivrpod_api/state/post_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('RIVERPOD_API')),
        body: Center(
          child: Consumer(
            builder: (context, ref, child) {
              PostsState state = ref.watch(postProvider);
              if (state is InitialPostsState) {
                return Text('CLICK ADD TO FETCH DATA');
              }
              if (state is LoadingPostsState) {
                return CircularProgressIndicator();
              }
              if (state is ErrorPostsState) {
                return Text(state.message);
              }
              if (state is LoadedPostsState) {
                return ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Text(state.posts[index].id.toString()),
                      title: Text(state.posts[index].title.toString()),
                    );
                  },
                );
              }
              return Text('None');
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.read(postProvider.notifier).fetchPosts();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
