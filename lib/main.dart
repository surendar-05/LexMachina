import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:lexmachina/src/authentication/sign_in_screen.dart';
import 'package:lexmachina/src/chat_ui/chat_screen.dart';

import '/src/blog/blog_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
// import '/src/dashboard/dashboard.dart';
import '/src/authentication/sign_up_screen.dart';
import 'src/onboarding/onboarding_screen.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    List<Message> messageList = [
      Message(
        id: '1',
        message: "Hi",
        createdAt: DateTime.now(),
        sentBy: 'user1',
      ),
      Message(
        id: '2',
        message: "Hello",
        createdAt: DateTime.now(),
        sentBy: 'user2',
      ),
    ];

    final chatController = ChatController(
      initialMessageList: messageList,
      scrollController: ScrollController(),
      currentUser: ChatUser(id: '1', name: 'Flutter'),
      otherUsers: [ChatUser(id: '2', name: 'Simform')],
    );

    // Define your GoRouter here
    final GoRouter _router = GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const OnboardScreen(),
        ),
        // GoRoute(
        //   path: '/dashboard',
        //   builder: (context, state) => const Dashboard(),
        // ),
        GoRoute(
          path: '/signIn',
          builder: (context, state) => const SignIn(),
        ),
        GoRoute(
          path: '/signUp',
          builder: (context, state) => const SignUp(),
        ),
        GoRoute(
          path: '/blog',
          builder: (context, state) => BlogPage(),
        ),
        GoRoute(
          path: '/chatScreen',
          builder: (context, state) => ChatScreen(),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'LexMachina',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme), // Apply the Inter font
        // TODO: Apply the Inter font offline
      ),
      routerConfig: _router, // Use router instead of routes
    );
  }
}
