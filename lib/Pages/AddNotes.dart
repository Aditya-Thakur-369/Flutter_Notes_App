// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crudapp/Modal/Response.dart';
import 'package:flutter/material.dart';
import '../Modal/Operation.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({
    Key? key,
    required this.sKey,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> sKey;

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> processData() async {
    if (formKey.currentState!.validate()) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      Response r = await Notes.addnote(title.text, body.text);
      ScaffoldMessenger.of(widget.sKey.currentState!.context).showSnackBar(SnackBar(content: Text("${r.msg}")));
      // log(r);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 275,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: title,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  label: Text("Title"),
                ),
                validator: (value) {
                  if (value == null) {
                    return "Please enter a title";
                  } else if (value.length < 3) {
                    return "Title should be greater then one word";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: body,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  label: Text("Body Of The Note"),
                ),
                validator: (value) {
                  if (value == null) {
                    return "Body Can Not Be Empty";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () => processData(),
                  child: Text(
                    "Add Note",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}


class UpdateNotes extends StatefulWidget {
  const UpdateNotes({
    super.key,
    required this.title,
    required this.body,
    required this.docID,
    required this.sKey,
  });

  final GlobalKey<State<StatefulWidget>> sKey;
  final String title;
  final String body;
  final String docID;
  @override
  State<UpdateNotes> createState() => _UpdateNotesState();
}

class _UpdateNotesState extends State<UpdateNotes> {
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController(text: widget.title);
    TextEditingController body = TextEditingController(text: widget.body);
    Future<void> processData() async {
      if (formkey.currentState!.validate()) {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Response r = await Notes.UpdateData(title.text, body.text,widget.docID);
        ScaffoldMessenger.of(widget.sKey.currentState!.context).showSnackBar(SnackBar(content: Text("${r.msg}")),
        );
      }
    }

    return AlertDialog(
      title: Text("Update"),
      content: SizedBox(
        height: 275,
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: title,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    label: Text("Title"),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Title Can Not Be Empty";
                    } else if (value.length < 3) {
                      return "Title Can Not Be Less Then 3 Digits";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: body,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    label: Text("Body Of Note"),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Please Enter Content of Body";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      processData();
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.only(left: 50, right: 50)),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
