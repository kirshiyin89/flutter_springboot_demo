import 'package:flutter/material.dart';
import 'package:myapp/serverinfo.dart';
import 'package:myapp/serviceinfo.dart';
import 'package:myapp/utils.dart';

class StartPage extends StatelessWidget {
  StartPage({Key key, this.title, this.serverInfo}) : super(key: key);

  final String title;
  final Future<List<ServerInfo>> serverInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
            child: FutureBuilder<List<ServerInfo>>(
                future: this.serverInfo,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      else
                        return _buildGridView(context, snapshot.data);
                  }
                })));
  }

  Widget _buildGridView(BuildContext context, List<ServerInfo> serverInfo) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(1.5),
      crossAxisCount: determineCrossAxisCount(context),
      childAspectRatio: 1.2,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: _prepareServerInfoCards(serverInfo), //new Cards()
      shrinkWrap: true,
    );
  }

  List<Widget> _prepareServerInfoCards(List<ServerInfo> serverInfo) {
    List<Widget> serverInfoCells = [];
    // we can call the rest service here?
    for (ServerInfo category in serverInfo) {
      serverInfoCells.add(_getServerInfoCard(category));
    }

    return serverInfoCells;
  }

  Color _getColorByServerStatus(ServerInfo info) {
    if (info.running()) {
      return Colors.teal[600];
    } else {
      return Colors.red[200];
    }
  }

  Container _getServerInfoCard(ServerInfo serverInfo) {
    return new Container(
        width: 200.0,
        height: 300.0,
        child: Card(
          elevation: 2.0,
          color: _getColorByServerStatus(serverInfo),
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: _prepareStatusText(serverInfo)),
        ));
  }

  List<Widget> _prepareStatusText(ServerInfo serverInfo) {
    final TextStyle textStyle =
        TextStyle(fontWeight: FontWeight.bold, height: 3);
    return <Widget>[
      new Center(
        child: new Text(serverInfo.name.toUpperCase(), style: textStyle),
      ),
      new Center(
        child: _createStatusTable(serverInfo),
      ),
    ];
  }

  Widget _createStatusTable(ServerInfo serverInfo) {
    if (serverInfo.notAvailable()) {
      return new Text('Server unreachable');
    }
    return Table(
        border: TableBorder.all(
            color: Colors.black26, width: 1, style: BorderStyle.none),
        children: _createStatusCells(serverInfo.services));
  }

  List<TableCell> _prepareHeader() {
    final TextStyle textStyle = TextStyle(fontWeight: FontWeight.bold);
    return [
      TableCell(
          child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("SERVICE", style: textStyle))),
      TableCell(child: Center(child: Text("STATUS", style: textStyle)))
    ];
  }

  List<TableRow> _createStatusCells(List<ServiceInfo> serviceInfo) {
    List<TableRow> rows = [];
    // prepare header
    rows.add(TableRow(children: _prepareHeader()));
    // prepare data
    for (ServiceInfo info in serviceInfo) {
      rows.add(TableRow(children: [
        TableCell(
            child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(info.name, textAlign: TextAlign.left))),
        TableCell(
            child: Center(
                child: Text(info.status(),
                    style: _getStyleByServiceStatus(info.running))))
      ]));
    }
    return rows;
  }

  TextStyle _getStyleByServiceStatus(bool running) {
    if (!running) {
      return TextStyle(fontStyle: FontStyle.italic);
    }
    return TextStyle();
  }
}
