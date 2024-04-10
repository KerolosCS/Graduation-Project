import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/widgets/word_view_body.dart';
import 'cubits/cubit/getvideo_cubit.dart';
import 'package:chewie/chewie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetvideoCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Homeview(),
      ),
    );
  }
}

class Homeview extends StatelessWidget {
  const Homeview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetvideoCubit, GetvideoState>(
        listener: (context, state) {
      if (state is GetvideoSucces) {
        // make a snackbar

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Done'),
            backgroundColor: Colors.green,
          ),
        );
      } else if (state is GetvideoFail) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please try again'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }, builder: (context, state) {
      // if (state is GetvideoFail) {
      // return Scaffold(
      //   appBar: AppBar(),
      //   floatingActionButton: FloatingActionButton(
      //     onPressed: () async {
      //       showCupertinoModalPopup(
      //         context: context,
      //         builder: (context) => CupertinoActionSheet(
      //           actions: [
      //             CupertinoActionSheetAction(
      //               child: const Text('Video Gallery'),
      //               onPressed: () {
      //                 Navigator.of(context).pop();

      //                 BlocProvider.of<GetvideoCubit>(context)
      //                     .getVideoFromGallery();
      //               },
      //             ),
      //             CupertinoActionSheetAction(
      //               child: const Text('Camera Video caputure one second'),
      //               onPressed: () {
      //                 Navigator.of(context).pop();

      //                 BlocProvider.of<GetvideoCubit>(context)
      //                     .getVideoFromCameraOneSecond();
      //               },
      //             ),
      //             CupertinoActionSheetAction(
      //               child: const Text('Camera Video caputure Two second'),
      //               onPressed: () {
      //                 Navigator.of(context).pop();

      //                 BlocProvider.of<GetvideoCubit>(context)
      //                     .getVideoFromCameraTwoSecond();
      //               },
      //             ),
      //           ],
      //         ),
      //       );
      //     },
      //     child: const Icon(Icons.camera_alt_rounded),
      //   ),
      // );
      // } else {
      return Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => const CupertinoActionSheet(
                actions: [
                  SheetAction(text: 'Video Gallery', s: 0),
                  SheetAction(text: 'Camera Video caputure One second', s: 1),
                  SheetAction(text: 'Camera Video caputure Two second', s: 2),
                ],
              ),
            );
          },
          child: const Icon(Icons.camera_alt_rounded),
        ),
        body: (state is GetvideoSucces)
            ? Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    height: 300,
                    width: double.infinity,
                    child: Center(
                      child: Chewie(
                        controller: ChewieController(
                          videoPlayerController:
                              BlocProvider.of<GetvideoCubit>(context)
                                  .controller!,
                          autoPlay: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      context.read<GetvideoCubit>().justState();
                    },
                    child: const Text("Done , Please Predict"),
                  ),
                ],
              )
            : const WordsViewBody(),
      );
    }
        // },
        );
  }
}

class SheetAction extends StatelessWidget {
  const SheetAction({
    super.key,
    required this.text,
    required this.s,
  });
  // String text = 'Camera Video caputure Two second';
  final String text;
  final int s;
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheetAction(
      child: Text(text),
      onPressed: () {
        Navigator.of(context).pop();

        if (s == 1) {
          BlocProvider.of<GetvideoCubit>(context).getVideoFromCameraOneSecond();
        } else if (s == 2) {
          BlocProvider.of<GetvideoCubit>(context).getVideoFromCameraTwoSecond();
        } else {
          BlocProvider.of<GetvideoCubit>(context).getVideoFromGallery();
        }
      },
    );
  }
}
