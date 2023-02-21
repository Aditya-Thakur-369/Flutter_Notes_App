// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../BackEnd/models.dart';
import '../Modal/Operation.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({
    Key? key,
    required this.sKey,
    required this.data,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> sKey;
  final UserModel data;

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

      Map<String, dynamic> d = {'title': title.text, 'body': body.text};
      widget.data.notes ??= [];
      widget.data.notes!.add(d);

      bool res = await Notes.setData(widget.data.toMap());
      String msg = "";
      if (res) {
        msg = "Note added!!";
      } else {
        msg = "Something went wrong!!";
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(msg)));
        Navigator.pop(context);
        Navigator.of(context, rootNavigator: true).pop();
      }

      // Response r = await Notes.addnote(title.text, body.text);
      // ScaffoldMessenger.of(widget.sKey.currentState!.context)
      //     .showSnackBar(SnackBar(content: Text("${r.msg}")));
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
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  label: const Text("Body Of The Note"),
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
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      shape: MaterialStateProperty.all(const StadiumBorder()),
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          left: 55, right: 55, top: 10, bottom: 10))),
                  child: const Text(
                    "Add Note",
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
    required this.sKey,
    required this.data,
    required this.d,
    required this.index,
    // required this.title,
    // required this.body,
    // required this.docID,
    // required this.sKey,
  });

  final GlobalKey<State<StatefulWidget>> sKey;
  // final String title;
  // final String body;
  // final String docID;

  final UserModel data;
  final Map<String, dynamic> d;
  final int index;
  @override
  State<UpdateNotes> createState() => _UpdateNotesState();
}

class _UpdateNotesState extends State<UpdateNotes> {
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController title =
        TextEditingController(text: widget.d['title']);
    TextEditingController body = TextEditingController(text: widget.d['body']);
    Future<void> processData() async {
      if (formkey.currentState!.validate()) {
        widget.d['title'] = title.text;
        widget.d['body'] = body.text;

        widget.data.notes![widget.index] = widget.d;

        String msg = "";
        bool res = await Notes.setData(widget.data.toMap());
        if (res) {
          msg = "Updated!!";
        } else {
          msg = "Some thing went wrong";
        }

        if (context.mounted) {
          ScaffoldMessenger.of(widget.sKey.currentState!.context).showSnackBar(
            SnackBar(content: Text(msg)),
          );
          Navigator.of(context, rootNavigator: true).pop('dialog');
        }

        // Response r =
        //     await Notes.UpdateData(title.text, body.text, widget.docID);
        // ScaffoldMessenger.of(widget.sKey.currentState!.context).showSnackBar(
        //   SnackBar(content: Text("${r.msg}")),
        // );
      }
    }

    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      title: const Text(
        "Update",
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 275,
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: title,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(20.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
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
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  controller: body,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    label: const Text("Body Of Note"),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Please Enter Content of Body";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      processData();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const StadiumBorder()),
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          left: 50, right: 50, top: 10, bottom: 10)),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    child: const Text(
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
