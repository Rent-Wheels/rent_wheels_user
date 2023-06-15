import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels/core/auth/auth_service.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/src/verify/presentation/verify_email.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  File? avatar;
  DateTime? dob;
  final picker = ImagePicker();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController residence = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1950),
      lastDate: DateTime(2006),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        dob = pickedDate;
      });
    });
  }

  openImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        avatar = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: openImage,
            child: Container(
              height: 100,
              width: 100,
              color: Colors.grey,
              child: avatar == null
                  ? const Text('Tap here to choose an image')
                  : Image.file(
                      avatar!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          TextField(
            controller: name,
            decoration: const InputDecoration(hintText: 'Name'),
          ),
          TextField(
            controller: email,
            decoration: const InputDecoration(hintText: 'Email'),
          ),
          TextField(
            controller: password,
            decoration: const InputDecoration(hintText: 'Password'),
          ),
          TextField(
            controller: phoneNumber,
            decoration: const InputDecoration(hintText: 'PhoneNumber'),
          ),
          TextField(
            controller: residence,
            decoration: const InputDecoration(hintText: 'Residence'),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  dob != null
                      ? 'Picked Date: ${DateFormat.yMd().format(dob!)}'
                      : 'No Date Chosen!',
                ),
              ),
              buildGenericButtonWidget(
                buttonName: 'Choose Date',
                onPressed: presentDatePicker,
              )
            ],
          ),
          buildGenericButtonWidget(
            buttonName: 'Sign Up',
            onPressed: () async {
              UserCredential userCredential =
                  await AuthService.firebase().createUserWithEmailAndPassword(
                avatar: avatar!.path,
                name: name.text,
                phoneNumber: phoneNumber.text,
                email: email.text,
                password: password.text,
                dob: dob!,
                residence: residence.text,
              );

              global.setGlobals(currentUser: userCredential.user!);

              if (!mounted) return;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const VerifyEmail(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
