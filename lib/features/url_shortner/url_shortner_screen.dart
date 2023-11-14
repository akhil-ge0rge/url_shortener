import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controller/shortner_controller.dart';

class UrlShortnerScreen extends ConsumerStatefulWidget {
  const UrlShortnerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UrlShortnerScreenState();
}

class _UrlShortnerScreenState extends ConsumerState<UrlShortnerScreen> {
  @override
  final urlController = TextEditingController();
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.sizeOf(context).width;
    double scrHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          ref
              .read(urlShortnerControllerProvider.notifier)
              .shortenUrl(urlController.text.trim());
        },
        child: Container(
          width: scrWidth * 0.8,
          height: scrHeight * 0.05,
          child: Center(
            child: Text(
              "Get URL",
              style:
                  GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Short URL",
                style: GoogleFonts.roboto(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            Container(
              width: scrWidth * 0.8,
              height: scrHeight * 0.3,
              child: Column(
                children: [
                  TextField(
                    controller: urlController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.purple.shade50,
                          style: BorderStyle.none,
                          width: 0,
                        ),
                      ),
                      fillColor: Colors.purple.shade50,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: scrHeight * 0.02),
                  GestureDetector(
                      onLongPress: () {
                        Clipboard.setData(ClipboardData(
                                text: ref.watch(urlShortnerControllerProvider)))
                            .whenComplete(() => Fluttertoast.showToast(
                                msg: "Copied to Clipboard"));
                      },
                      child: Text(ref.watch(urlShortnerControllerProvider))),
                ],
              ),
            ),
            Spacer(),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
