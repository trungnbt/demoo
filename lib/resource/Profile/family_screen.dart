import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:webspc/Api_service/user_infor_service.dart';
import 'package:webspc/DTO/section.dart';
import 'package:webspc/DTO/user.dart';
import 'package:webspc/styles/button.dart';

class FamilyScreen extends StatefulWidget {
  static const routerName = 'FamilyScreen';
  final BuildContext? context;

  const FamilyScreen(this.context, {Key? key}) : super(key: key);

  @override
  _FamilyScreenState createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  String? textfieldEmail;
  TextEditingController emailController = TextEditingController();
  final RoundedLoadingButtonController _btnSave =
      RoundedLoadingButtonController();
  BuildContext? dialogContext;
  bool isLoading = true;
  List<Users> listUserInFamily = [];
  Users? UserInFamilyDetail;

  @override
  void initState() {
    super.initState();
    getListFamily();
  }

  void getListFamily() {
    isLoading = false;
    UserInforService.Userinforfamily(familyID: Session.loggedInUser.familyId!)
        .then((response) => setState(() {
              listUserInFamily = response;
              if (listUserInFamily.isNotEmpty) {
                UserInFamilyDetail = listUserInFamily.first;
              }
              print(UserInFamilyDetail?.userId);
            }));
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/bga1png.png'),
            fit: BoxFit.cover,
          )),
          // padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: Text(
                  "Your Family",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Expanded(
                  flex: 10,
                  child: ListView.builder(
                      itemCount: listUserInFamily.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            background: Container(
                              color: Color.fromARGB(255, 244, 79, 67),
                              child: Icon(Icons.delete_forever_sharp),
                            ),
                            direction: listUserInFamily[index].roleUser == true
                                ? DismissDirection.none
                                : DismissDirection.horizontal,
                            key: ValueKey<Users>(listUserInFamily[index]),
                            confirmDismiss: (direction) async {
                              if (Session.loggedInUser.roleUser == true) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text(
                                        'Do you want to REMOVE ${listUserInFamily[index].fullname!} from your family?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Users user = Users(
                                              userId: listUserInFamily[index]
                                                  .userId,
                                              email:
                                                  listUserInFamily[index].email,
                                              pass:
                                                  listUserInFamily[index].pass,
                                              phoneNumber:
                                                  listUserInFamily[index]
                                                      .phoneNumber,
                                              fullname: listUserInFamily[index]
                                                  .fullname,
                                              identitiCard:
                                                  listUserInFamily[index]
                                                      .identitiCard,
                                              wallet: listUserInFamily[index]
                                                  .wallet,
                                              familyId: null,
                                              familyVerify: false,
                                              roleUser: false);
                                          UserInforService.updateUser(
                                                  user,
                                                  listUserInFamily[index]
                                                      .userId!)
                                              .then((value) => getListFamily());
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                _showMyDialog(
                                    context, "Error", "You are not the host!");
                              }
                              return;
                            },
                            child: Card(
                              elevation: 10,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 30, bottom: 30, left: 10, right: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        listUserInFamily[index].roleUser == true
                                            ? Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.house_rounded,
                                                  ),
                                                  SizedBox(
                                                    width: 45,
                                                  ),
                                                  Text(
                                                      '${listUserInFamily[index].fullname}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18)),
                                                ],
                                              )
                                            : Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                    Text(
                                                      "Name:    ${listUserInFamily[index].fullname}",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ]),
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                            ));
                      })),
              Session.loggedInUser.roleUser == true
                  ? Expanded(
                      child: ElevatedButton(
                        style: buttonPrimary,
                        onPressed: () {
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: SizedBox(
                                  height: 300,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const Text(
                                            'Input your email of parent',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.email,
                                                    size: 24,
                                                    weight: 24,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        left: BorderSide.none,
                                                        top: BorderSide.none,
                                                        right: BorderSide.none,
                                                        bottom: BorderSide(
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    child: TextField(
                                                      onChanged: (value) {
                                                        setState(() {
                                                          textfieldEmail =
                                                              value;
                                                        });
                                                      },
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText: 'Email',
                                                        border:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                          horizontal: 16,
                                                          vertical: 14,
                                                        ),
                                                      ),
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 60, right: 60),
                                            child: RoundedLoadingButton(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.055,
                                              color: const Color.fromRGBO(
                                                  20, 160, 240, 1.0),
                                              controller: _btnSave,
                                              onPressed: () async {
                                                bool check =
                                                    await UserInforService
                                                        .CheckEmail(
                                                            email: textfieldEmail
                                                                .toString());
                                                if (check) {
                                                  _btnSave.success();
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                      title: Text(
                                                          'Do you want to add ${Session.FamilyInUser.fullname} to your family?'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            Session.FamilyInUser =
                                                                Users(
                                                                    userId:
                                                                        "0");
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Text('No'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Users user = Users(
                                                                userId: Session
                                                                    .FamilyInUser
                                                                    .userId,
                                                                email: Session
                                                                    .FamilyInUser
                                                                    .email,
                                                                pass: Session
                                                                    .FamilyInUser
                                                                    .pass,
                                                                phoneNumber: Session
                                                                    .FamilyInUser
                                                                    .phoneNumber,
                                                                fullname: Session
                                                                    .FamilyInUser
                                                                    .fullname,
                                                                identitiCard: Session
                                                                    .FamilyInUser
                                                                    .identitiCard,
                                                                wallet: Session
                                                                    .FamilyInUser
                                                                    .wallet,
                                                                familyId: Session
                                                                    .loggedInUser
                                                                    .familyId,
                                                                familyVerify:
                                                                    true,
                                                                roleUser:
                                                                    false);
                                                            UserInforService.updateUser(
                                                                    user,
                                                                    Session
                                                                        .FamilyInUser
                                                                        .userId!)
                                                                .then((value) =>
                                                                    getListFamily());
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                            textfieldEmail = "";
                                                          },
                                                          child:
                                                              const Text('Yes'),
                                                        ),
                                                      ],
                                                    ),
                                                  );

                                                  _btnSave.stop();
                                                } else {
                                                  _showMyDialog(
                                                      context,
                                                      "Error",
                                                      "Your input email have been in a Family or incorrect gmail please try again later");
                                                  _btnSave.stop();
                                                }
                                              },
                                              child: Text("Save"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          "ADD new menber",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Text(
                        "",
                      ),
                    )
            ],
          ));
    }
  }

  Future _showMyDialog(
      BuildContext context, String title, String description) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
