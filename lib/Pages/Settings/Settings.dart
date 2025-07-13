import 'package:flutter/material.dart';
import 'package:smart_shopk4/Pages/HelperFunction/Navigation_Helper.dart';
import 'package:smart_shopk4/Pages/SignUp_page/Sign_up.dart';
import 'package:smart_shopk4/utils/firebase.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: Text('Settings'),

        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },

          child: Icon(Icons.keyboard_backspace),

        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            InkWell(
              onTap: () async {
                final shouldLogout = await showDialog<bool>
                  (context: context,
                    builder: (_) =>AlertDialog(
                      title: Text('Confirm Logout'),
                      content: Text('Are you sure want to log out?'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
                        TextButton(onPressed: ()=>  Navigator.pop(context, true), child: Text('Log Out'))
                      ],
                    )
                );

                if(shouldLogout == true) {
                  await firebaseAuth.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                    MaterialPageRoute(builder: (_) => SignUp()),
                        (route) => false,
                     );
                }
              },
              child: ListTile(
                title: Text(
                  'Log out',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold

                  ),
                ),
              ),
            ),
            Divider(),
            ListTile(
              title: Text('About',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,

                ),

              ),
              subtitle: Text(
                  'A Fully Functional Social Media Application Made by Raj mahto'),
            )
          ],
        ),
      ),
    );
  }
}
