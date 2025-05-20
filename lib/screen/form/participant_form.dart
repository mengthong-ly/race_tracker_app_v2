import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker_app/model/enum.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/provider/participant_provider.dart';
import 'package:race_tracker_app/screen/form/custom_text_form_field.dart';
import 'package:race_tracker_app/theme/r_color.dart';
import 'package:race_tracker_app/theme/r_text.dart';
import 'package:race_tracker_app/theme/t_constant.dart';
import 'package:uuid/uuid.dart';

class ParticipantFormView extends StatefulWidget {
  const ParticipantFormView({
    super.key,
    this.isEdit = false,
    this.participant,
  });

  final bool isEdit;
  final Participant? participant;

  @override
  State<ParticipantFormView> createState() => _ParticipantFormViewState();
}

class _ParticipantFormViewState extends State<ParticipantFormView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String id;
  late String bib;
  late int age;
  late String name;
  late String? email;
  late String phone;
  late Nation nation;
  late Gender gender;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.participant != null) {
      final p = widget.participant!;
      id = p.id;
      bib = p.bib;
      age = p.age;
      name = p.name;
      email = p.email;
      phone = p.phone;
      nation = p.nation;
      gender = p.gender ?? Gender.male;
    } else {
      id = const Uuid().v4();
      bib = context.read<ParticipantProvider>().nextBib.toString();
      age = 12;
      name = '';
      email = '';
      phone = '';
      gender = Gender.male;
      nation = Nation.kh;
    }
  }

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      late Participant newParticipant;
      setState(() {
        _isLoading = true;
      });
      try {
        newParticipant = Participant(
          id: id,
          name: name,
          bib: bib,
          age: age,
          email: email,
          phone: phone,
          nation: nation,
          createdAt: DateTime.now(),
          gender: gender,
        );

        if (!widget.isEdit) {
          await context
              .read<ParticipantProvider>()
              .addParticipant(newParticipant);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: RColor.primary,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              duration: const Duration(seconds: 2),
              content: const Text('Done'),
            ),
          );
        } else {
          await context
              .read<ParticipantProvider>()
              .updateParticipant(newParticipant);
        }
        // Set loading to false BEFORE popping
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        Navigator.pop<Participant>(context, newParticipant);
      } catch (e) {
        Logger().d('error $e');
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        return;
      }
    }
  }

  // void onSubmit() async {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     late Participant newParticipant;
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     try {
  //       newParticipant = Participant(
  //         id: id,
  //         name: name,
  //         bib: bib,
  //         age: age,
  //         email: email,
  //         phone: phone,
  //         nation: nation,
  //         createdAt: DateTime.now(),
  //         gender: gender,
  //       );

  //       if (!widget.isEdit) {
  //         await context
  //             .read<ParticipantProvider>()
  //             .addParticipant(newParticipant);
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             backgroundColor: RColor.primary,
  //             behavior: SnackBarBehavior.floating,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(12),
  //             ),
  //             margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  //             duration: const Duration(seconds: 2),
  //             content: const Text('Done'),
  //           ),
  //         );
  //       } else {
  //         await context
  //             .read<ParticipantProvider>()
  //             .updateParticipant(newParticipant);
  //       }
  //       Navigator.pop<Participant>(context, newParticipant);
  //     } catch (e) {
  //       Logger().d('error $e');
  //       return;
  //     } finally {
  //       if (mounted) {
  //         setState(() {
  //           _isLoading = false;
  //         });
  //       }
  //     }
  //   }
  // }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  void onSavedName(String? value) {
    if (value != null && value.isNotEmpty) {
      name = value;
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  void onSavedEmail(String? value) {
    email = value;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    if (!RegExp(r'^[0-9]{8,}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  void onSavedPhone(String? value) {
    phone = value ?? '';
  }

  Widget buildBottomSheet(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 20),
      decoration: BoxDecoration(
        color: RColor.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: RColor.primary,
        ),
        onPressed: onSubmit,
        child: const Text("Save"),
      ),
    );
  }

  Widget buildLoading(Widget child) {
    return _isLoading
        ? Scaffold(
            body: Container(
              color: Colors.black.withOpacity(0.2),
              child: const Center(
                child: CircularProgressIndicator(
                  color: RColor.primary,
                ),
              ),
            ),
          )
        : child;
  }

  @override
  Widget build(BuildContext context) {
    return buildLoading(Scaffold(
      bottomSheet: buildBottomSheet(context),
      appBar: AppBar(
        title: Text(
          widget.isEdit ? 'Edit' : 'Add Participant',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                initialvalue: name,
                hintText: 'Enter Name: ',
                label: 'Name',
                validator: validateName,
                onSaved: onSavedName,
              ),
              CustomTextFormField(
                initialvalue: email,
                hintText: 'Enter Email: ',
                label: 'Email',
                validator: validateEmail,
                onSaved: onSavedEmail,
              ),
              CustomTextFormField(
                initialvalue: phone,
                hintText: 'Enter Phone: ',
                label: 'Phone',
                validator: validatePhone,
                onSaved: onSavedPhone,
              ),
              // CustomTextFormField(
              //   initialvalue: emergencyContact,
              //   hintText: 'Enter Emergency Contact: ',
              //   label: 'Contact',
              //   validator: validateEmergencyContact,
              //   onSaved: onSavedEmergencyContact,
              // ),
              buildAgePicker(),
              buildGenderPicker(),
              buildNationPicker(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildAgePicker() {
    int ageValue = age;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Age:',
            style: TTextTheme.darkTextTheme.bodyMedium,
          ),
          const SizedBox(width: 16),
          NumberPicker(
            value: ageValue,
            minValue: 12,
            maxValue: 99,
            itemHeight: 36,
            axis: Axis.horizontal,
            onChanged: (value) {
              setState(() {
                age = value;
              });
            },
            selectedTextStyle: TTextTheme.darkTextTheme.bodyLarge!
                .copyWith(color: RColor.primary, fontWeight: FontWeight.bold),
            textStyle: TTextTheme.darkTextTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget buildGenderPicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TVerticalSpacing.l,
          Text(
            'Gender:',
            style: TTextTheme.darkTextTheme.bodySmall!
                .copyWith(color: RColor.black),
          ),
          DropdownButtonFormField(
            focusColor: RColor.primary,
            decoration: const InputDecoration(
              filled: true,
              focusColor: RColor.primary,
              fillColor: RColor.white,
            ),
            dropdownColor: RColor.white,
            value: gender,
            iconEnabledColor: RColor.primary,
            items: [
              DropdownMenuItem(
                value: Gender.male,
                child: Text(
                  'Male',
                  style: TTextTheme.darkTextTheme.bodySmall!
                      .copyWith(color: RColor.black),
                ),
              ),
              DropdownMenuItem(
                value: Gender.female,
                child: Text(
                  'Female',
                  style: TTextTheme.darkTextTheme.bodySmall!
                      .copyWith(color: RColor.black),
                ),
              ),
            ],
            onChanged: (value) {
              gender = value!;
            },
          ),
        ],
      ),
    );
  }

  Widget buildNationPicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TVerticalSpacing.l,
          Text(
            'Nation:',
            style: TTextTheme.darkTextTheme.bodySmall!
                .copyWith(color: RColor.black),
          ),
          DropdownButtonFormField<Nation>(
            value: nation,
            decoration: const InputDecoration(
              filled: true,
              focusColor: RColor.primary,
              fillColor: RColor.white,
            ),
            dropdownColor: RColor.white,
            iconEnabledColor: RColor.primary,
            items: Nation.values.map((n) {
              return DropdownMenuItem(
                value: n,
                child: Text(
                  n.name.toUpperCase(),
                  style: TTextTheme.darkTextTheme.bodySmall!
                      .copyWith(color: RColor.black),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                nation = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  // Widget buildBottomSheet(BuildContext context) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     padding: const EdgeInsets.symmetric(
  //       horizontal: 15,
  //       vertical: 40,
  //     ),
  //     decoration: const BoxDecoration(
  //       color: RColor.darkCanvas,
  //       // borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: ElevatedButton(
  //       onPressed: onSubmit,
  //       child: const Text("Save"),
  //     ),
  //   );
  // }
}
