import 'package:flutter/material.dart';
import 'package:meme_creator/model/meme_data.dart';
import 'package:meme_creator/services/meme_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Meme creator',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
          useMaterial3: true,
        ),
        home: const Homepage());
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String imageUrl = '';
  Widget loadingWidget = const Text('Press on the Button to get new Meme');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: imageUrl.isEmpty ? loadingWidget : Image.network(imageUrl),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          getANewMeme(context);
          loadingWidget = const CircularProgressIndicator();
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black87, borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(
            'Create New Meme',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  void getANewMeme(BuildContext context) async {
    try {
      MemeData memeData = await MemeApi().generateMeme();
      if (memeData.runtimeType == MemeData) {
        imageUrl = memeData.url;
        setState(() {});
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Something went wrong')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
