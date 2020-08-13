import 'package:flutter/material.dart';

/// 右侧展示内容
class UserRightDrag extends StatefulWidget {
  UserRightDrag({Key key, this.data}) : super(key: key);
  final Map data;

  @override
  _UserRightDragState createState() => _UserRightDragState();
}

class _UserRightDragState extends State<UserRightDrag> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, containers) {
      return Drawer(
          child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: UserAccountsDrawerHeader(
                accountName: Text('warren',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                accountEmail: Text(
                  '1322xx61@qq.com',
                  style: TextStyle(color: Colors.white),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://t8.baidu.com/it/u=3571592872,3353494284&fm=79&app=86&size=h300&n=0&g=4n&f=jpeg?sec=1595916477&t=8e4719073e6c066e0c785f07ccb322a4'),
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://t8.baidu.com/it/u=3571592872,3353494284&fm=79&app=86&size=h300&n=0&g=4n&f=jpeg?sec=1595916477&t=8e4719073e6c066e0c785f07ccb322a4'),
                        fit: BoxFit.cover)),
              ))
            ],
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  title: Text('ListTile1'),
                  subtitle: Text(
                    'ListSubtitle1',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: CircleAvatar(child: Text("1")),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Divider(), //分割线
                ListTile(
                  title: Text('ListTile2'),
                  subtitle: Text(
                    'ListSubtitle2',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: CircleAvatar(child: Text("2")),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Divider(), //分割线
                ListTile(
                  title: Text('ListTile3'),
                  subtitle: Text(
                    'ListSubtitle3',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: CircleAvatar(child: Text("3")),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ));
    });
  }
}

/// 左侧展示内容
class UserLeftDraw extends StatelessWidget {
  const UserLeftDraw({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
