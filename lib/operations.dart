import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/data.dart';
import 'database/database_manager.dart';
import 'home_page.dart';
class Operations extends StatelessWidget {
DatabaseManager db = new DatabaseManager();  
@override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Operations'),
      ),
      body: Consumer<DataProvider>(
        builder: (context, dataProvider, _) {
          // Access the variablesfrom the data provider
          String? api = dataProvider.api;


          String? description = dataProvider.description;

return ListView.builder(
  itemCount: 1, 
  itemBuilder: (context, index) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(api ?? 'No api available',
            style: TextStyle(fontSize: 15, color: Colors.white),

          ),
          Text(description ?? 'No description available',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
edit(context, api, description);
              },
              icon: Icon(
                Icons.edit,
                color: Colors.blueAccent,
              ),
  tooltip: 'Edit', // Tooltip text
            ),
          ),
          SizedBox(
            width: 15,
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
db.deleteRow(api);        
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
  tooltip: 'Delete',
            ),
          ),
        ],
      ),
      // Other ListTile properties...
    );
  },
);
        },
      ),
    );
  }

void edit(BuildContext context, String? api, String? description) {
  // Controllers for text fields
  TextEditingController textEditingController1 = TextEditingController(text: api);
  TextEditingController textEditingController2 = TextEditingController(text: description);

 final String? specific = api;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Enter new Data"),
        content: Container(
          height: 150,
          child: Column(
            children: [
              TextFormField(
                controller: textEditingController1,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                ),
              ),
              TextFormField(
                controller: textEditingController2,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                ),
              ),
            ],
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.blue,
            child: Text("Cancel"),
          ),
          MaterialButton(
            onPressed: () {

db.updateData(specific, textEditingController1.text, textEditingController2.text);             
context.read<DataProvider>().modify(textEditingController1.text, textEditingController2.text);
              Navigator.of(context).pop();
 },
            child: Text("Save"),
            color: Colors.blue,
          ),
        ],
      );
    },
  );
}

}
