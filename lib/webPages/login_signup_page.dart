import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../defaultColors/DefaultColors.dart';
class LoginSignupPage extends StatefulWidget {
  const LoginSignupPage({super.key});

  @override
  State<LoginSignupPage> createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  bool userWantToSignUp=true;
  bool errorPicture=false;
  bool errorInName=false;
  bool errorInEmail=false;
  bool errorInPwd=false;
  Uint8List? selectedImage;
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController pwdController=TextEditingController();
  bool loadingOn=false;



  choosePicture()async{
   FilePickerResult? chosenImageFile = await FilePicker.platform.pickFiles(type: FileType.image);
   if(chosenImageFile!=null){
     selectedImage=chosenImageFile.files.first.bytes;
     setState(() {
       errorPicture=false;
     });
   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login Signup Page'),
      // ),
      body: Container(
        color: DefaultColors.backgroundColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
                child:
                Container(
                  color: DefaultColors.primaryColor,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.5,

            )),
            Center(
              child: SingleChildScrollView(

                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),

                    ),
                    child: Container(
                      padding: EdgeInsets.all(40),
                      width: 500,
                      child: Column(
                        children: [
                          //profile image
                          Visibility(
                              visible: userWantToSignUp,
                              child: ClipOval(
                                child: selectedImage!=null?
                                Image.memory(selectedImage!,width: 124,height: 124, fit: BoxFit.cover,)
                                    :
                                Image.asset("assets/avatar-profile.jpg",width: 124,height: 124, fit: BoxFit.cover,)
                              )),
                          // Outline choose
                          Visibility(
                              visible: userWantToSignUp,
                              child: OutlinedButton(
                                  onPressed: (){
                                    choosePicture();
                                  },

                                  style: errorPicture?
                                      OutlinedButton.styleFrom(
                                        side: BorderSide(width: 3, color: Colors.red)
                                      )
                                      :null,
                                  child: Text("Choose Picture"),
                              )),
                          SizedBox(height: 22,),
                          //name Filed
                          Visibility(
                              visible: userWantToSignUp,
                              child:TextField(
                                keyboardType: TextInputType.text,
                                controller: nameController,
                                decoration: InputDecoration(
                                  hintText: "Write valid name",
                                  labelText: "Name",
                                  suffixIcon: const Icon(Icons.person),
                                  enabledBorder: errorInName? const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3,
                                        color: Colors.red
                                    )
                                  )
                                      : null
                                  ),

                                ),
                              ),
                          //email Filed
                          TextField(
                            keyboardType: TextInputType.text,
                            controller: emailController,
                            decoration: InputDecoration(
                                hintText: "Write valid name",
                                labelText: "Email",
                                suffixIcon: const Icon(Icons.email_outlined),
                                enabledBorder: errorInEmail? const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3,
                                        color: Colors.red
                                    )
                                )
                                    : null
                            ),

                          ),
                          //email Filed
                          TextField(
                            keyboardType: TextInputType.text,
                            controller: pwdController,
                            decoration: InputDecoration(
                                hintText: userWantToSignUp?
                                  "Must be at least 8 characters"
                                : "Write valid password",
                                labelText: "Password",
                                suffixIcon: const Icon(Icons.lock_outline),
                                enabledBorder: errorInPwd? const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3,
                                        color: Colors.red
                                    )
                                )
                                    : null
                            ),

                          ),

                          SizedBox(height: 22,),
                          //login signup button
                          SizedBox(
                            width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: DefaultColors.primaryColor,

                                  ),
                                  onPressed: (){},
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: loadingOn?
                                      SizedBox(
                                        width: 19,
                                        height: 19,
                                        child: Center(child: CircularProgressIndicator(color: Colors.white ,)),
                                      ):
                                      Text(
                                        userWantToSignUp?"SignUp":"Login",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white
                                          ),
                                      )),
                          )),

                          //toggle button
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Text("Login"),
                               Switch(
                                   value: userWantToSignUp,
                                   onChanged: (bool value){


                                  setState(() { userWantToSignUp=value; });
                                   }),

                               Text("SignUp"),
                            ])

                        ],
                      ),
                    ),
                  )
                )
              ),
            )
          ],
        ),
    ));
  }
}
