import 'package:flutter/material.dart';

void main() {
  runApp(const RegisterApp());
}

class RegisterApp extends StatelessWidget {
  const RegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register Acount',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final List<String> years = [
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
  ];
  final List<String> months = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
  ];
  final List<String> days = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
  ];

// Controllers
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Håller koll på det valda värdet
  String? selectedYear;
  String? selectedMonth;
  String? selectedDay;

// Key
  final _formKey = GlobalKey<FormState>();

// Bools
  bool isChecked = false;
  bool isCheckedValidation = true;

// För password
  late String password;
  double passwordStrength = 0;
  String displayPasswordText = '';
  String? passwordError;

  bool isCheckedLetter = false;
  bool isCheckedNum = false;
  bool isCheckedChar = false;

// Dold password
  var isObscured;

// Checkar mailen
  String? validateEmail(String? value) {
    const validePattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    final regexp = RegExp(validePattern);

    return value!.isNotEmpty && !regexp.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

// Checkar password strength
  void checkPasswordStrength(String password) {
    // Regex för att matcha bokstäver, siffror och specialtecken
    final letterReg = RegExp(r'[A-Za-z]');
    final numReg = RegExp(r'[0-9]');
    final specCarReg = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    int letterCount = RegExp(r'[a-zA-Z]').allMatches(password).length;

    if (password.isEmpty) {
      setState(() {
        isCheckedLetter = false;
        isCheckedNum = false;
        isCheckedChar = false;
        passwordStrength = 0;
        displayPasswordText = '';
      });
    } else if (password.length < 9) {
      if (numReg.hasMatch(password) && specCarReg.hasMatch(password)) {
        setState(() {
          isCheckedNum = true;
          isCheckedChar = true;
          passwordStrength = 1 / 4;
          displayPasswordText = 'Your password is too short';
        });
      } else if (specCarReg.hasMatch(password)) {
        setState(() {
          isCheckedChar = true;
          passwordStrength = 1 / 4;
          displayPasswordText = 'Your password is too short';
        });
      } else if (numReg.hasMatch(password)) {
        setState(() {
          isCheckedNum = true;
          passwordStrength = 1 / 4;
          displayPasswordText = 'Your password is too short';
        });
      } else if (letterReg.hasMatch(password) && password.length == 8) {
        setState(() {
          isCheckedLetter = true;
          passwordStrength = 2 / 4;
          displayPasswordText = 'Your password is accepteble';
        });
      } else {
        setState(() {
          isCheckedLetter = false;
          isCheckedNum = false;
          isCheckedChar = false;
          passwordStrength = 1 / 4;
          displayPasswordText = 'Your password is too short';
        });
      }
    } else if (letterReg.hasMatch(password) &&
        numReg.hasMatch(password) &&
        specCarReg.hasMatch(password)) {
      if (letterCount >= 8) {
        setState(() {
          isCheckedLetter = true;
          isCheckedChar = true;
          isCheckedNum = true;
          passwordStrength = 1;
          displayPasswordText = 'Your password is super strong';
        });
      } else {
        setState(() {
          isCheckedLetter = false;
          isCheckedChar = true;
          isCheckedNum = true;
          passwordStrength = 3 / 4;
          displayPasswordText = 'Your password is strong';
        });
      }
    } else if (numReg.hasMatch(password)) {
      setState(() {
        isCheckedNum = true;
        passwordStrength = 3 / 4;
        displayPasswordText = 'Your password is strong';
      });
    } else if (specCarReg.hasMatch(password)) {
      setState(() {
        isCheckedChar = true;
        passwordStrength = 3 / 4;
        displayPasswordText = 'Your password is strong';
      });
    } else {
      setState(() {
        passwordStrength = 3 / 4;
        displayPasswordText = 'Your password is strong';
      });
    }
  }

// Password match with confirm password
  void checkPasswordMatch() {
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        passwordError = 'Password do not match';
      });
    } else {
      setState(() {
        passwordError = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isObscured = true;
    _confirmPasswordController.addListener(checkPasswordMatch);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: 400,
            height: 900,
            child: Card(
              elevation: 20,
              color: const Color.fromARGB(255, 251, 251, 250),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20.0, left: 80.0),
                      child: Text(
                        'Create an Account',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 88, 110, 110),
                              width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'FULL NAME',
                        suffixIcon: const Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 88, 110, 110),
                                width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: 'USERNAME',
                          suffixIcon:
                              const Icon(Icons.account_circle_outlined)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      validator: validateEmail,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 88, 110, 110),
                              width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'EMAIL',
                        suffixIcon: const Icon(Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // ---------------------------------------- PASSWORD-------------------------
                    TextFormField(
                      controller: _passwordController,
                      onChanged: (value) => checkPasswordStrength(value),
                      obscureText: isObscured,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscured = !isObscured;
                                });
                              },
                              icon: isObscured
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 88, 110, 110),
                                width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: 'PASSWORD',
                          helperStyle: const TextStyle(
                            fontSize: 8,
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      displayPasswordText,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),

                    LinearProgressIndicator(
                      value: passwordStrength,
                      backgroundColor: Colors.grey,
                      color: passwordStrength <= 1 / 4
                          ? Colors.red
                          : passwordStrength == 2 / 4
                              ? Colors.yellow
                              : passwordStrength == 3 / 4
                                  ? Colors.orange
                                  : Colors.green,
                    ),
                    const SizedBox(height: 10),
                    Row(children: <Widget>[
                      Icon(
                        isCheckedLetter ? Icons.check : Icons.close,
                      ),
                      const Text('At least 8 letters'),
                    ]),

                    const SizedBox(height: 10),
                    Row(children: <Widget>[
                      Icon(
                        isCheckedNum ? Icons.check : Icons.close,
                      ),
                      const Text('At least 1 number'),
                    ]),

                    const SizedBox(height: 10),
                    Row(children: <Widget>[
                      Icon(
                        isCheckedChar ? Icons.check : Icons.close,
                      ),
                      const Text('At least 1 special character'),
                    ]),

                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: isObscured,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 88, 110, 110),
                              width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'CONFIRM PASSWORD',
                        errorText: passwordError,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password again';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),
                    const Text(
                      "   DATE OF BIRTH",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 90,
                          height: 50,
                          child: DropdownButton<String>(
                            value: selectedMonth,
                            hint: const Text('MM'),
                            items: months.map((String month) {
                              return DropdownMenuItem<String>(
                                value: month,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(month),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedMonth = newValue;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 90,
                          height: 50,
                          child: DropdownButton<String>(
                            value: selectedDay,
                            hint: const Text('DD'),
                            items: days.map((String day) {
                              return DropdownMenuItem<String>(
                                value: day,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(day),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedDay = newValue;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          height: 50,
                          child: DropdownButton<String>(
                            value: selectedYear,
                            hint: const Text('YYYY'),
                            items: years.map((String year) {
                              return DropdownMenuItem<String>(
                                value: year,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Text(year),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedYear = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                  isCheckedValidation = true;
                                });
                              },
                            ),
                            RichText(
                              text: const TextSpan(
                                text: 'I agree to the ',
                                children: [
                                  TextSpan(
                                    text: 'terms and conditions',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 33, 33, 251),
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                          child: isCheckedValidation
                              ? const SizedBox() // Om valideringen är korrekt, visa en tom SizedBox
                              : const Text(
                                  '  Please agree to the terms and conditions.',
                                  style: TextStyle(color: Colors.red),
                                ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                isChecked &&
                                passwordStrength > 1 / 4 &&
                                passwordError == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainPage()));
                            }
                            if (!isChecked) {
                              setState(() {
                                isCheckedValidation = false;
                              });
                            }
                          },
                          child: const Text('Create account'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: const Text("Go to Create Account"),
            ),
          ],
        ),
      ),
    );
  }
}
