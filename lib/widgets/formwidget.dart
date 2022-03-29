import 'package:flutter/material.dart';

class cvFormWidget extends StatelessWidget {
  final bool? liked;
  final int? mnumber;
  final String? title;
  final String? fullname;
  final String? address;
  final String? skills;
  final String? edu;
  final ValueChanged<bool> onChangedLiked;
  final ValueChanged<int> onChangedMnumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedFullname;
  final ValueChanged<String> onChangedAddress;
  final ValueChanged<String> onChangedSkills;
  final ValueChanged<String> onChangedEdu;

  const cvFormWidget({
    Key? key,
    this.liked = false,
    this.mnumber = 0,
    this.title = '',
    this.fullname = '',
    this.address = '',
    this.skills = '',
    this.edu = '',
    required this.onChangedLiked,
    required this.onChangedMnumber,
    required this.onChangedTitle,
    required this.onChangedFullname,
    required this.onChangedAddress,
    required this.onChangedSkills,
    required this.onChangedEdu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              SizedBox(height: 8),
              buildFullname(),
              SizedBox(height: 8),
              buildAddress(),
              SizedBox(height: 16),
              buildEdu(),
              SizedBox(height: 16),
              buildSkills(),
              SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.black),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );
  Widget buildFullname() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'fullname',
          hintStyle: TextStyle(color: Colors.black),
        ),
        validator: (fullname) => fullname != null && fullname.isEmpty
            ? 'The fullname cannot be empty'
            : null,
        onChanged: onChangedTitle,
      );
  Widget buildAddress() => TextFormField(
        maxLines: 5,
        initialValue: address,
        style: TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
          hintText: 'address',
          hintStyle: TextStyle(color: Colors.black),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedAddress,
      );

  Widget buildSkills() => TextFormField(
        maxLines: 5,
        initialValue: skills,
        style: TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
          hintText: 'skills',
          hintStyle: TextStyle(color: Colors.black),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedSkills,
      );
  Widget buildEdu() => TextFormField(
        maxLines: 5,
        initialValue: edu.toString(),
        style: TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
          hintText: 'Education',
          hintStyle: TextStyle(color: Colors.black),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The Education cannot be empty'
            : null,
        onChanged: onChangedEdu,
      );
}
