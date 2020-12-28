import 'package:flutter/material.dart';
//import 'package:clime/weatherapp.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
         /* Navigator.push(
            context, MaterialPageRoute(builder: (context)=>WeatherApp()),
          );*/
        }),
        title: Text("Clime"),
        actions: <Widget>[

        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        height: double.infinity,
        width: double.infinity,
      constraints: BoxConstraints.expand(),
    decoration: BoxDecoration(
    image: DecorationImage(
    image: NetworkImage(
    "https://i.imgur.com/kxUyuPUh.png"),
    fit: BoxFit.cover)
    ),
       child : Column(
      children: <Widget>[
        SizedBox(height: 80),
        new Icon(Icons.cloud_circle,size: 50,color: Colors.white,),

        SizedBox(height: 150),
        Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                //         color:Colors.blue[50],
                child: ListTile(
                  leading: Icon(Icons.wb_sunny,color: Colors.black),
                  title: Text('Dark Mode',textScaleFactor: 1.5,),
                  subtitle: Text('Enable the dark mode'),
                  trailing:  Switch(
                    value: isSwitched,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      print("VALUE : $value");
                      /*setState(() {
      isSwitched = value;
    }
    );*/
                    },
                  ),

                ),
              )
          ),
          Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
         //       color:Colors.blue[50],
                child: ListTile(
                  leading: Icon(Icons.timer,color: Colors.black),
                  title: Text('Time',textScaleFactor: 1.5,),
                  subtitle: Text('Enable the 12/24 hrs'),
                  trailing:  Switch(
                    value: isSwitched,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      print("VALUE : $value");
                      /*setState(() {
      isSwitched = value;
    }
    );*/
                    },
                  ),
                ),
              )
          ),
          Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
         //       color:Colors.blue[50],
                child: ListTile(
                  leading: Icon(Icons.notification_important,color: Colors.black),
                  title: Text('Notification',textScaleFactor: 1.5,),
                  subtitle: Text('Enable the notification'),
                  trailing:  Switch(
                    value: isSwitched,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      print("VALUE : $value");
                      /*setState(() {
      isSwitched = value;
    }
    );*/
                    },
                  ),

                ),
              )
          ),

        ],
      ),
    ),
    );
  }
}


