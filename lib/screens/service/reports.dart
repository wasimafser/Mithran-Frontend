
import 'package:flutter/material.dart';
import 'package:mithran/data/report.dart';
import 'package:mithran/data/service.dart';
import 'package:mithran/tools/api.dart';
import 'package:mithran/tools/screen_size.dart';
import 'package:mithran/user.dart';
import 'package:mithran/widgets/navigation_drawer.dart';

class ReportsPage extends StatefulWidget {
  // const ReportsPage({Key: key}) : super(key: key);

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List reports = [];

  getReports() async{
    var responses = await API().get_reports();
    for (var response in responses){
      reports.add(Report.fromMap(response));
    }
    this.setState(() {
      reports = reports;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReports();
  }


  @override
  Widget build(BuildContext context) {
    if (reports.isNotEmpty){
      return Scaffold(
        appBar: AppBar(
          title: Text("Services Reports"),
        ),
        drawer: NavigationDrawer(),
        body: Card(
          margin: ScreenSize.isSmallScreen(context) ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: 200, vertical: 20),
          child: ListView.separated(
            separatorBuilder: (context, index){
              return SizedBox(
                height: 10,
                );
              },
            itemCount: reports.length,
            itemBuilder: (context, index){
              return ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Text("Name : ${reports[index].fullName}"),
                subtitle: Text("Total Services : ${reports[index].totalServices}"),
                trailing: Text("Total Work Hours : ${reports[index].totalWorkTime}"),
                onTap: () async{
                  var results = await API().getUserReports(reports[index].userId);
                  List user_reports = [];
                  for (var result in results){
                    user_reports.add(Service.fromMap(result));
                  }
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return UserReportPopup(reports: user_reports);
                      }
                  );
                },
              );
            }
          )
        )
      );
    }else{
      return Text("LOADING");
    }
  }
}

class UserReportPopup extends StatelessWidget {
  UserReportPopup({this.reports});

  List reports = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: Text(widget.title),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: <Widget>[
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      content: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Divider(),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: reports.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                            contentPadding: EdgeInsets.all(10),
                            title: Text("Requested By : ${reports[index].requestedBy.user.fullName}"),
                            subtitle: Text("Requested On : ${reports[index].requestedOn.toString()}"),
                            // trailing:
                            ),
                            Flex(
                              direction: Axis.vertical,
                              children: [
                                Text("Assigned on : ${reports[index].assignedOn}"),
                                Text("Started on : ${reports[index].startedOn}"),
                                Text("Completed on : ${reports[index].completedOn}"),
                                Text("Total Work Hours : ${reports[index].totalWorkTime}"),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}