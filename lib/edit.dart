import 'package:flutter/material.dart';
import 'package:resumemaker/database.dart';
import 'package:resumemaker/model.dart';
import 'package:resumemaker/widgets/formwidget.dart';

class AddEditcvPage extends StatefulWidget {
  final cv? cvs;

  const AddEditcvPage({
    Key? key,
    this.cvs,
  }) : super(key: key);
  @override
  _AddEditcvPageState createState() => _AddEditcvPageState();
}

class _AddEditcvPageState extends State<AddEditcvPage> {
  final _formKey = GlobalKey<FormState>();
  late bool liked;
  late int mnumber;
  late String title;
  late String fullname;
  late String address;
  late String skills;
  late String edu;
  @override
  void initState() {
    super.initState();

    liked = widget.cvs?.liked ?? false;
    mnumber = widget.cvs?.mnumber ?? 0;
    title = widget.cvs?.title ?? '';
    fullname = widget.cvs?.fullname ?? '';
    address = widget.cvs?.address ?? '';
    skills = widget.cvs?.skills ?? '';
    edu = widget.cvs?.edu ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade100,
          title: Text('Edit your cv'),
          centerTitle: true,
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: cvFormWidget(
            liked: liked,
            mnumber: mnumber,
            title: title,
            fullname: fullname,
            address: address,
            onChangedLiked: (liked) =>
                setState(() => this.liked = liked),
            onChangedMnumber: (mnumber) => setState(() => this.mnumber = mnumber),
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedFullname: (fullname) => setState(() => this.fullname = fullname),
            onChangedSkills: (skills) => setState(() => this.skills = skills),
            onChangedEdu: (edu) => setState(() => this.edu = edu),
            onChangedAddress: (address) =>
                setState(() => this.address = address),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && address.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdatecvs,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdatecvs() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.cvs != null;

      if (isUpdating) {
        await updatecv();
      } else {
        await addcv();
      }

      Navigator.of(context).pop();
    }
  }

  Future updatecv() async {
    final cvs = widget.cvs!.copy(
      liked: liked,
      mnumber: mnumber,
      title: title,
      fullname: fullname,
      address: address,
      skills: skills,

    );

    await cvsDatabase.instance.update(cvs);
  }

  Future addcv() async {
    final cvs = cv(
      title: title,
      fullname: fullname,
      liked: true,
      mnumber: mnumber,
      address: address,
      skills: skills,
      edu: edu,
      createdTime: DateTime.now(),
    );

    await cvsDatabase.instance.create(cvs);
  }
}
