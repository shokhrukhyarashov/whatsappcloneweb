import 'package:archive/models/user_model.dart';
import 'package:archive/routes_web_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  signUpOrLogin(){
    setState(() {
      loadingOn=true;
      errorInPwd=false;
      errorInEmail=false;
      errorInName=false;
      errorPicture=false;
    });
    String nameInput=nameController.text.trim();
    String emailInput=emailController.text.trim();
    String pwdInput=pwdController.text.trim();

    if(emailInput.isNotEmpty && emailInput.contains("@")){
      if(pwdInput.isNotEmpty && pwdInput.length>=8) {
        if (userWantToSignUp) {
          if(nameInput.isNotEmpty && nameInput.length>=3){
          signUpUserNow(nameInput, emailInput, pwdInput);
          }else{
            var snakbar = SnackBar(content: Text("Invalid Name please"),backgroundColor: DefaultColors.primaryColor);
            ScaffoldMessenger.of(context).showSnackBar(snakbar,);
          }

        }else{
          signInUserNow(emailInput, pwdInput);
        }

      }else{
        var snakbar = SnackBar(content: Text("Invalid Password"),backgroundColor: DefaultColors.primaryColor);
        ScaffoldMessenger.of(context).showSnackBar(snakbar,);
      }

    }else{
      var snakbar = SnackBar(content: Text("Invalid Email"),backgroundColor: DefaultColors.primaryColor);
      ScaffoldMessenger.of(context).showSnackBar(snakbar);

      setState(() {
        loadingOn=false;

      });

    }
  }
  void signInUserNow(String emailInput, String pwdInput) {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: emailInput, password: pwdInput)
        .then((e){
      setState(() {
        loadingOn=false;
      });
      Navigator.pushReplacementNamed(context, RoutesForWebPages.homePage);
    }).onError((error, stackTrace){
    });
  }

  signUpUserNow(nameInput, emailInput, pwdInput)async{
    final userCreate = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailInput,
        password: pwdInput);
    if(userCreate.user!=null){
      var usermodel=UserModel(
          uid: userCreate.user!.uid,
          name: nameInput,
          email: emailInput,
          password: pwdInput);
      uploadImageToStorage(usermodel);
    }

  }
  void uploadImageToStorage(UserModel usermodel) {
    if(selectedImage!=null){
    // Reference imgeRef= FirebaseStorage.instance.ref("ProfileImages/${usermodel.uid}.jpg");
    // UploadTask task = imgeRef.putData(selectedImage!);
    // task.whenComplete(()async{
    //  var urlImage= await task.snapshot.ref.getDownloadURL();
    //  usermodel.image=urlImage;
    //
    //  //save data on firestore
    //   await FirebaseAuth.instance.currentUser!.updatePhotoURL(usermodel.name);
    //   await FirebaseAuth.instance.currentUser!.updatePhotoURL(urlImage);

      // final userReference= await FirebaseFirestore.instance.collection('users');
      // userReference
      //     .doc(usermodel.uid)
      //     .set(usermodel.toMap(),)
      //     .then((value){
      //       setState(() {
      //         loadingOn=false;
      //       });
            Navigator.pushReplacementNamed(context, RoutesForWebPages.homePage);
      // });

    // });
    }else{
      var snakbar = SnackBar(content: Text("please choose image first"),backgroundColor: DefaultColors.primaryColor);
      ScaffoldMessenger.of(context).showSnackBar(snakbar,);
    }
  }
  formValidation(){

      setState(() {
        loadingOn=true;
        errorInPwd=false;
        errorInEmail=false;
        errorInName=false;
        errorPicture=false;
      });

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
                          //password Filed
                          TextField(
                            obscureText: true,
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
                                  onPressed: (){
                                    signUpOrLogin();
                                  },
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


