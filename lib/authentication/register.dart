  import '../home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _emailController2 = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: 


    SingleChildScrollView(

            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                SizedBox(height: 5.0),

                Icon(Icons.person, size: 48.0), // Add the person icon

                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.0),
_Checkbox(),
                      ElevatedButton(
                        onPressed: () async {
                          await login(context);
                        },
                        child: Text(
                          'Login   ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue[900]!),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.0), // Add space between the columns
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                SizedBox(width: 160.0), // Add space between the two icons
                Icon(Icons.person, size: 48.0), // Add the person icon

                      TextField(
                        controller: _emailController2,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _passwordController2,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 65.0),

                      ElevatedButton(
                        onPressed: () async {
                          await register(context);
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue[900]!),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero, // Make it rectangular
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                ),
              ],
            ),
          


      ),
    );
  }
  Future<void> register(BuildContext context) async {
List<TextEditingController> controllers = [_emailController2, _passwordController2];
    try {

    if (_emailController2.text.isEmpty || _passwordController2.text.isEmpty) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("The fields can not be empty"),
          ),
        );
      } else {
        final existingUser = await FirebaseAuth.instance.fetchSignInMethodsForEmail(_emailController2.text);

        if (existingUser.isNotEmpty) {
          // Email is already registered, show a message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Email already exists. Please use another!"),
            ),
          );
        } else {
          // Email is not registered, create a new user
          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController2.text,
            password: _passwordController2.text,
          );


controllers.forEach((controller) => controller.dispose());


          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'An unexpected error occurred.'),
        ),
      );
    }
  }


  Future<void> login(BuildContext context) async {
try {
    if (_emailController.text.isEmpty || _Checkbox.getPasswordControllerText().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("The fields can not be empty"),
        ),
      );
    } else {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _Checkbox.getPasswordControllerText(),
      );

      // If sign-in is successful, navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
   }
} on FirebaseAuthException catch (e) {
  print('Failed with error code: ${e.code}');
  print(e.message);
  
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(e.message ?? 'An unexpected error occurred.'),
    ),
  );
}
}
}

class _Checkbox extends StatefulWidget {
  _Checkbox._();
  static _Checkbox? _instance;
  factory _Checkbox() {
    // Create the instance if it doesn't exist
    _instance ??= _Checkbox._();
    return _instance!;
  }

  static TextEditingController? passwordController = TextEditingController(); // Initialize 
  // Getter method to retrieve the text from the TextEditingController
static  String getPasswordControllerText() {

    return passwordController!.text;

  }



  @override
  __CheckboxState createState() => __CheckboxState();
}

class __CheckboxState extends State<_Checkbox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _Checkbox.passwordController,
          obscureText: !_isChecked,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.password),
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Checkbox(
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value ?? false;
                });
              },
checkColor: Colors.red,
            ),
            Text(
              'Show password',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}