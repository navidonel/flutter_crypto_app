import 'package:edu/providers/sing_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../network/respnse_model.dart';
import 'main_wrapper.dart';

class SingeUpScreen extends StatefulWidget {
  const SingeUpScreen({super.key});

  @override
  State<SingeUpScreen> createState() => _SingeUpScreenState();
}

class _SingeUpScreenState extends State<SingeUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late SingUpProvider singUpProvider;

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    singUpProvider = Provider.of<SingUpProvider>(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return Row(
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RotatedBox(
                            quarterTurns: 3,
                            child: Lottie.asset('images/bitcointouch.json',
                                fit: BoxFit.fill)),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const SizedBox(height: 30,),
                          // Lottie.asset('images/bitcointouch.json',height: height * 0.3,fit: BoxFit.fill),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text('Sign Up',
                                style: GoogleFonts.ubuntu(
                                    fontSize: height * 0.035,
                                    color:
                                        Theme.of(context).unselectedWidgetColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text('Create Account',
                                style: GoogleFonts.ubuntu(
                                    fontSize: height * 0.03,
                                    color: Theme.of(context)
                                        .unselectedWidgetColor)),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20, bottom: 20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      hintText: 'Username',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                    controller: nameController,
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter username';
                                      } else if (value.length < 4) {
                                        return 'at least enter 4 characters';
                                      } else if (value.length > 13) {
                                        return 'maximum character is 13';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  TextFormField(
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.email_rounded),
                                      hintText: 'gmail',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter gmail';
                                      } else if (!value
                                          .endsWith('@gmail.com')) {
                                        return 'please enter valid gmail';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  TextFormField(
                                    controller: passwordController,
                                    obscureText: _isObscure,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.lock_open),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isObscure
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        },
                                      ),
                                      hintText: 'Password',
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      } else if (value.length < 7) {
                                        return 'at least enter 6 characters';
                                      } else if (value.length > 13) {
                                        return 'maximum character is 13';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Text(
                                    'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                                    style: GoogleFonts.ubuntu(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        height: 1.5),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Consumer<SingUpProvider>(builder:
                                      (context, userDataProvider, child) {
                                    switch (userDataProvider
                                        .registerStatus?.status) {
                                      case SStatus.LOADING:
                                        return CircularProgressIndicator();
                                      case SStatus.COMPLETED:
                                        // savedLogin(userDataProvider.registerStatus?.data);
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((timeStamp) =>
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MainWrapper())));
                                        return signupBtn();
                                      case SStatus.ERROR:
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            signupBtn(),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.error,
                                                  color: Colors.redAccent,
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Text(
                                                  userDataProvider
                                                      .registerStatus!.message,
                                                  style: GoogleFonts.ubuntu(
                                                      color: Colors.redAccent,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      default:
                                        return signupBtn();
                                    }
                                  }),
                                ],
                              ),
                            ),
                          ),
                          const Align(
                              alignment: Alignment.center,
                              child: Text('Already have an account?')),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.blue, width: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                onPressed: () {
                                  // Navigator.push(context, MaterialPageRoute(builder:  (context) => const LoginScreen()));
                                },
                                child: const Text('Login'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Lottie.asset('images/waveloop.json',
                      height: height * 0.2,
                      width: double.infinity,
                      fit: BoxFit.fill),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text('Sign Up',
                        style: GoogleFonts.ubuntu(
                            fontSize: height * 0.035,
                            color: Theme.of(context).unselectedWidgetColor,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text('create Account',
                        style: GoogleFonts.ubuntu(
                            fontSize: height * 0.035,
                            color: Theme.of(context).unselectedWidgetColor,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Username',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            controller: nameController,
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter username';
                              } else if (value.length < 4) {
                                return 'at least enter 4 characters';
                              } else if (value.length > 13) {
                                return 'maximum character is 13';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email_rounded),
                              hintText: 'gmail',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter gmail';
                              } else if (!value.endsWith('@gmail.com')) {
                                return 'please enter valid gmail';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: singUpProvider.isObscure,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_open),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  singUpProvider.isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  singUpProvider.changeIsObscure();
                                },
                              ),
                              hintText: 'Password',
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              } else if (value.length < 7) {
                                return 'at least enter 6 characters';
                              } else if (value.length > 13) {
                                return 'maximum character is 13';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Text(
                            'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                            style: GoogleFonts.ubuntu(
                                fontSize: 15, color: Colors.grey, height: 1.5),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Consumer<SingUpProvider>(
                            builder: (context, singUpProvider, child) {
                              switch (singUpProvider.registerStatus?.status) {
                                case SStatus.LOADING:
                                  return CircularProgressIndicator();
                                case SStatus.COMPLETED:
                                  // savedLogin(userDataProvider.registerStatus?.data);
                                  WidgetsBinding.instance.addPostFrameCallback(
                                      (timeStamp) => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MainWrapper())));
                                  return signupBtn();
                                case SStatus.ERROR:
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      signupBtn(),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.error,
                                            color: Colors.redAccent,
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            singUpProvider
                                                .registerStatus!.message,
                                            style: GoogleFonts.ubuntu(
                                                color: Colors.redAccent,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                default:
                                  return signupBtn();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ));
  }

  Widget signupBtn() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            singUpProvider.callRegisterApi(nameController.text,
                emailController.text, passwordController.text);
          }
        },
        child: Text("Sing up"),
      ),
    );
  }
}
