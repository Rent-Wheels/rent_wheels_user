import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

import 'package:rent_wheels/core/secrets/secrets.dart' as secret;
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
  final placesKey = secret.mapsKey;
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

  Future<void> handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: placesKey,
      language: "en",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "gh")],
      types: [],
      strictbounds: false,
    );
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: placesKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail =
        await places.getDetailsByPlaceId(p?.placeId ?? "");

    setState(() {
      residence.text =
          '${detail.result.name}, ${detail.result.formattedAddress}';
    });
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
          // buildLocationTextfield(
          //     location: residence.text, onTap: handlePressButton),
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
