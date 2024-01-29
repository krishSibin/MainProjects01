import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/auth_widgets.dart';
import '../widgets/snackBar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CustomerRegester extends StatefulWidget {
  const CustomerRegester({super.key});

  @override
  State<CustomerRegester> createState() => _CustomerRegesterState();
}

class _CustomerRegesterState extends State<CustomerRegester> {
  late String name;
  late String email;
  late String password;
  late String profileImage;
  late String _uid;
  bool passwordVisible = true;
  final ImagePicker _picker = ImagePicker();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  XFile? _imageFile;
  dynamic _pickedImageError;
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  void _pickImageFromCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 95,
        maxHeight: 300,
        maxWidth: 300,
      );
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void _pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 95,
        maxHeight: 300,
        maxWidth: 300,
      );
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      if (_imageFile != null) {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);

          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref('Customer-image/$email.jpg');
          await ref.putFile(File(_imageFile!.path));
          profileImage = await ref.getDownloadURL();

          _uid = FirebaseAuth.instance.currentUser!.uid;
          await customers.doc(_uid).set({
            'name': name,
            'email': email,
            'profileimage': profileImage,
            'phone': '',
            'address': '',
            'cid': _uid,
          });

          _formKey.currentState!.reset();
          setState(
            () {
              _imageFile = null;
            },
          );

          Navigator.pushReplacementNamed(context, '/Customer_home');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            MyMessageHandler.showSnackBar(_scaffoldKey, "Password is too weak");
          } else if (e.code == 'email-already-in-use') {
            MyMessageHandler.showSnackBar(
                _scaffoldKey, "Account already exists");
          }
        }
      } else {
        MyMessageHandler.showSnackBar(_scaffoldKey, 'please pick an image');
      }
    } else {
      MyMessageHandler.showSnackBar(_scaffoldKey, 'please fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const AuthHeaderLabel(headerLabel: 'Sign_Up'),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 40,
                            ),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.purple,
                              foregroundImage: _imageFile == null
                                  ? null
                                  : FileImage(File(_imageFile!.path)),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _pickImageFromCamera();
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.pinkAccent,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.photo,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _pickImageFromGallery();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Name';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            name = value;
                          },
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Full Name',
                            hintText: 'Enter Your Full Name',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Email Address';
                            } else if (!value.isValidEmail()) {
                              return 'Invalid email';
                            } else {
                              // The email is valid.
                              return null;
                            }
                          },
                          onChanged: (value) {
                            email = value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Email Address',
                            hintText: 'Enter Your Email Address',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Password';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            password = value;
                          },
                          obscureText: passwordVisible,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Password',
                            hintText: 'Enter Your Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                              icon: passwordVisible
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                            ),
                          ),
                        ),
                      ),
                      HaveAccount(
                        haveAccount: 'already have an account?',
                        actionLabel: 'Log In',
                        onPressed: () {},
                      ),
                      AuthMainButton(
                        mainButtonLabel: 'Sign_up',
                        onPressed: () {
                          signUp();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
