import 'package:flutter/material.dart';
import 'package:test/internal/constatns.dart';
import 'package:test/presentation/widgets/CustomTextFormField.dart';
import 'package:test/services/Api_services.dart';

class FormScreen extends StatefulWidget {
  FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final textEditingControllerName = TextEditingController();

  final textEditingControllerEmail = TextEditingController();

  final textEditingControllerMessange = TextEditingController();

  bool isloading = false;

  String result = '';

  final formKeyEmail = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            )),
        title: const Text(
          'Contacts us',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: formKeyEmail,
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: backOrange,
                  child: Icon(
                    Icons.lock_open_sharp,
                    color: iconColor,
                  ),
                ),
                SizedBox(
                  width: 350,
                  child: CustomTextFormField(
                    labelText: 'Name',
                    textEditingController: textEditingControllerName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'No correct Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: backOrange,
                  child: Icon(
                    Icons.lock_open_sharp,
                    color: iconColor,
                  ),
                ),
                SizedBox(
                  width: 350,
                  child: CustomTextFormField(
                    labelText: 'Email',
                    textEditingController: textEditingControllerEmail,
                    validator: (value) {
                      if (value!.isEmpty ||
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return null;
                      } else {
                        return 'No correct email';
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: backOrange,
                  child: Icon(
                    Icons.lock_open_sharp,
                    color: iconColor,
                  ),
                ),
                SizedBox(
                  width: 350,
                  child: CustomTextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'No correct Message';
                      } else {
                        return null;
                      }
                    },
                    labelText: 'Message',
                    textEditingController: textEditingControllerMessange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 140),
            ValueListenableBuilder(
              valueListenable: textEditingControllerName,
              builder: (BuildContext context, TextEditingValue value,
                  Widget? child) {
                return ValueListenableBuilder(
                    valueListenable: textEditingControllerEmail,
                    builder: (BuildContext context, TextEditingValue value,
                        Widget? child) {
                      return ValueListenableBuilder<TextEditingValue>(
                          valueListenable: textEditingControllerMessange,
                          builder: (context, value, child) {
                            return ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(primaryColor),
                                  fixedSize: MaterialStateProperty.all(
                                      const Size(400, 60))),
                              onPressed: (textEditingControllerName
                                          .text.isNotEmpty &&
                                      textEditingControllerEmail
                                          .text.isNotEmpty &&
                                      textEditingControllerMessange
                                          .text.isNotEmpty &&
                                      !isloading)
                                  ? () async {
                                      if (formKeyEmail.currentState!
                                          .validate()) {
                                        setState(() {
                                          isloading = true;
                                        });
                                        var statusCode = await ApiServices()
                                            .createPost(
                                                textEditingControllerName
                                                    .text
                                                    .trim(),
                                                textEditingControllerEmail.text
                                                    .trim(),
                                                textEditingControllerMessange
                                                    .text
                                                    .trim());
                                        if (statusCode == 201) {
                                          setState(() {
                                            result = successfully;
                                          });
                                        } else {
                                          setState(() {
                                            result = "Ошибка $statusCode";
                                          });
                                        }
                                        setState(() {
                                          isloading = !isloading;
                                        });
                                      }
                                    }
                                  : null,
                              child: isloading
                                  ? const Text(
                                      'please wait',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )
                                  : const Text(
                                      'Send',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                            );
                          });
                    });
              },
            ),
            const SizedBox(height: 40),
            Center(
                child: Text(
              result,
              style: TextStyle(
                  fontSize: 24,
                  color: result == successfully ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold),
            ))
          ],
        ),
      ),
    );
  }
}
