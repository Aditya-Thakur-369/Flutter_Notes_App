import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OpenAI extends StatelessWidget {
  const OpenAI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Search Notes",
          style: GoogleFonts.lato(fontSize: 25.0, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search_outlined,
                        size: 25,
                        color: Colors.grey,
                      ),
                      contentPadding: EdgeInsets.only(left: 15),
                      labelText: "Search ... ",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(),
            ],
          ),
        ),
      ),
    );
  }
}
