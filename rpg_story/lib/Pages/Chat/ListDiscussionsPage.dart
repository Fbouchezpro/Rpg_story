import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_story/Bloc/Discussion_bloc/discussion_bloc.dart';
import 'package:rpg_story/Models/Discussion.dart';
import 'package:rpg_story/Models/Profile.dart';
import 'package:rpg_story/Pages/Chat/ChatPage.dart';
import 'package:rpg_story/Pages/Chat/ListUsersPage.dart';
import 'package:rpg_story/Utils/Constants.dart';
import 'package:rpg_story/Utils/DateUtils.dart';
import 'package:rpg_story/Widgets/CustomLoadingWidget.dart';
import 'package:rpg_story/main.dart';

class DiscussionListPage extends StatefulWidget {
  const DiscussionListPage({Key? key}) : super(key: key);

  @override
  DiscussionListPageState createState() => DiscussionListPageState();
}

class DiscussionListPageState extends State<DiscussionListPage> {
  final List<Discussion> _discussions = [];
  bool _isLoading = false;
  bool isRefreshing = false;

  Future<Profile> getLoggedInUserProfile() async {
    final user = supabase.auth.currentUser;

    final response =
        await supabase.from('profiles').select('*').eq('id', user!.id).single();

    return Profile.fromMap(response);
  }

  Future<void> refreshData() async {
    setState(() {
      isRefreshing = true;
    });
    Profile currentUser = await getLoggedInUserProfile();
    BlocProvider.of<DiscussionBloc>(context)
        .add(RequestingDiscussionsEvent(profile: currentUser));

    setState(() {
      isRefreshing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    Profile currentUser = await getLoggedInUserProfile();

    BlocProvider.of<DiscussionBloc>(context).add(
      RequestingDiscussionsEvent(profile: currentUser),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discussions'),
        actions: [
          IconButton(
            onPressed: isRefreshing ? null : refreshData,
            icon: isRefreshing
                ? const CircularProgressIndicator()
                : const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocConsumer<DiscussionBloc, DiscussionState>(
        listener: (context, listener) {
          if (listener is ListDiscussionsLoading) {
            setState(() {
              _isLoading = true;
            });
          }
          if (listener is ListDiscussionsDone) {
            setState(() {
              _isLoading = false;
              _discussions.clear();
              _discussions.addAll(listener.listDiscussions);
            });
          }
        },
        builder: (context, state) {
          if (state is ListDiscussionsFailure) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text('Failed to load Discussions'),
                ),
              ],
            );
          } else {
            return _isLoading
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CustomLoadingWidget(),
                        GAP_H_16,
                        Text('Loading your discussions...')
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _discussions.length,
                    itemBuilder: (context, index) {
                      final discussion = _discussions[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 20,
                          child: ListTile(
                            title: Text('Discussion with ${discussion.title}'),
                            subtitle: Text(
                              'Since ${displayDayMonth(date: discussion.createdDate)}',
                            ),
                            trailing:
                                const Icon(Icons.arrow_circle_right_outlined),
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChatPage(discussionId: discussion.id),
                                ),
                              );
                            }),
                          ),
                        ),
                      );
                    },
                  );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UserListPage(),
            ),
          );
        },
        child: const Icon(Icons.add_box_outlined),
      ),
    );
  }
}
