import 'package:rpg_story/Bloc/Authentication_bloc/authentication_bloc.dart';
import 'package:rpg_story/Bloc/Authentication_bloc/authentication_repository.dart';
import 'package:rpg_story/Bloc/Discussion_bloc/discussion_bloc.dart';
import 'package:rpg_story/Bloc/Discussion_bloc/discussion_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_story/Bloc/Event_bloc/event_bloc.dart';
import 'package:rpg_story/Bloc/Event_bloc/event_repository.dart';

import 'package:rpg_story/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://pewczeqmmoaeivdbyuak.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBld2N6ZXFtbW9hZWl2ZGJ5dWFrIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODc4NzA0OTYsImV4cCI6MjAwMzQ0NjQ5Nn0.a9v155u26RDWZaBz1g84XPSs-asLpAlnQglKkWpNe-M',
  );
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (BuildContext context) => AuthenticationRepository(),
        ),
        RepositoryProvider<EventBlocRepository>(
          create: (BuildContext context) => EventBlocRepository(),
        ),
        RepositoryProvider<DiscussionRepository>(
          create: (BuildContext context) => DiscussionRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => AuthenticationBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            ),
          ),
          BlocProvider<EventBlocBloc>(
            create: (BuildContext context) => EventBlocBloc(
              eventBlocRepository:
                  RepositoryProvider.of<EventBlocRepository>(context),
            ),
          ),
          BlocProvider<DiscussionBloc>(
            create: (BuildContext context) => DiscussionBloc(
              discussionRepository:
                  RepositoryProvider.of<DiscussionRepository>(context),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return const App();
      },
    );
  }
}
