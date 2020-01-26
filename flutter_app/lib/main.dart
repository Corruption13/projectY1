import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';


void main() => runApp(MyApp());
final databaseReference = Firestore.instance;

TextEditingController room = new TextEditingController();
TextEditingController data = new TextEditingController();
TextEditingController mobile = new TextEditingController();

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ystack Samdee',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ystack Sandeep', style: TextStyle(fontSize: 15)), centerTitle: true,),
      body: Scrollbar(
        child:
          SingleChildScrollView(
            child:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height:20),
                  Text("Enter Room No:", style: TextStyle(fontSize: 20)),
                  SizedBox(height:10),
                  Container(
                    color: Colors.green[100],
                    padding: EdgeInsets.all(10.0),

                  child: TextField(
                    controller: room,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Room No'
                    ),
                  )
                  ),
                  SizedBox(height:10),
                  Text("Enter Input:", style: TextStyle(fontSize: 20)),
                  SizedBox(height:10),
                  Container(
                      color: Colors.red[50],
                      padding: EdgeInsets.all(20.0),

                      child: TextField(
                        controller: data,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Input here'
                        ),
                      )
                  ),
                  SizedBox(height:10),
                  Text("Enter Mobile Number:", style: TextStyle(fontSize: 20)),
                  SizedBox(height:10),
                  Container(
                      color: Colors.blue[50],
                      padding: EdgeInsets.all(10.0),

                      child: TextField(
                        controller: mobile,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Mobile Number'
                        ),
                      )
                  ),
                  SizedBox(height:20),
                  Divider(color: Colors.black, thickness: 2),
                  SizedBox(height:30),
                  Text("Data:", style: TextStyle(fontSize: 42)),
                  Container(
                    padding: EdgeInsets.fromLTRB(24, 50, 24, 2),
                    child: _buildBody(context),
                  ),
                  SizedBox(height:100),
                ],
            )
            )
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            String room_val = room.text;
            String data_val = data.text;
            String mobile_val = mobile.text;
            if(room_val != "" && data_val != "" && mobile_val!= "") {
              databaseReference.collection("rooms")
                  .document(room_val)
                  .setData({
                'mobile_data': data_val,
                'mobile_num': mobile_val,
                'output': 'O/P not recieved',
                'room': room_val,
              });
              print("Ok");
            }
            else {
              print("Invalid Input");
            }

          },
          child: Text("Submit"),
        ),
    );


  }

  Future outputNotification(String output) async {
    showDialog(

      builder: (_) {
        return new AlertDialog(
          title: Text("Output recieved"),
          content: Text("output : $output"),
        );
      },
    );
  }



  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('rooms').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Column(
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    String room_val = record.room;
    String output_val = record.output;

    return Padding(
      key: ValueKey(record.mobile_data),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(2, 15, 2, 15),

        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text("Room: " + room_val),
          trailing: Text("Mobile Input: "+ record.mobile_data + "\nMobile No: " + record.mobile_num + "\nFinal Output: " + output_val),
            onTap: () {

              print("\n<<Values>>\nRoom: " + record.room + "\nData: " + record.mobile_data + "\nNumber: " + record.mobile_num + "\nOutput: " + record.output);
              AlertDialog(title: Text("Sample Alert Dialog")) ;
            }
        ),
      ),
    );
  }
}

class Record {
  final String mobile_data;
  final String mobile_num;
  final String output;
  final String room;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['mobile_data'] != null),
        assert(map['mobile_num'] != null),
        assert(map['output'] != null),

        mobile_data = map['mobile_data'],
        room = map['room'],
        mobile_num = map['mobile_num'],
        output = map['output'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$mobile_data:$mobile_num>";
}


