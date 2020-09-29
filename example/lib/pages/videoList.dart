import 'package:cdnbye_example/model/videoResource.dart';
import 'package:cdnbye_example/pages/videoPage.dart';
import 'package:cdnbye_example/views/tapped.dart';
import 'package:flutter/material.dart';

class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  List<VideoResource> get _list => [
        VideoResource(
          title: '豹子头林冲之山神庙',
          image: 'http://cn2.3days.cc/1580551147538598.jpeg',
          description:
              '山神庙，林冲抚摸着冰冷冷的长枪，现在只有倚靠这个伙伴了，陆谦已经追到跟前，长枪对单刀，昔日较场两人交手的情景出现在眼前，同样的一招，这次陆谦却永远倒在林冲枪下。所有恩怨都了结于刀枪下，林冲一杆长枪在肩挑着酒葫芦如孤云野鹤般走在白雪的旷野中，朔风紧起，又见雪花纷纷扬扬……',
          url:
              'http://cn6.qxreader.com/hls/20200201/e987a0e00e1a8431ac408032ba023958/1580550680/index.m3u8',
        ),
        // VideoResource(
        //   title: '豹子头林冲之山神庙',
        // image: 'http://cn2.3days.cc/1580551147538598.jpeg',
        // description:
        //     '山神庙，林冲抚摸着冰冷冷的长枪，现在只有倚靠这个伙伴了，陆谦已经追到跟前，长枪对单刀，昔日较场两人交手的情景出现在眼前，同样的一招，这次陆谦却永远倒在林冲枪下。所有恩怨都了结于刀枪下，林冲一杆长枪在肩挑着酒葫芦如孤云野鹤般走在白雪的旷野中，朔风紧起，又见雪花纷纷扬扬……',
        //   url:
        //       'http://hdtv.ubdata.info/ublive/38983779f7ef436c9883b10f8d7ccdef/index.m3u8',
        // ),
        // VideoResource(
        //   title: '哥斯拉2：怪兽之王',
        //   image: 'http://ty.download05.com/1559637248977096.jpeg',
        //   description:
        //       '随着《哥斯拉》和《金刚：骷髅岛》在全球范围内取得成功，传奇影业和华纳兄弟影业联手开启了怪兽宇宙系列电影的新篇章—一部史诗级动作冒险巨制。在这部电影中，哥斯拉将和众多大家在流行文化中所熟知的怪兽展开较量。全新故事中，研究神秘动物学的机构“帝王组织”将勇敢直面巨型怪兽，其中强大的哥斯拉也将和魔斯拉、拉顿和它的死对头——三头王者基多拉展开激烈对抗。当这些只存在于传说里的超级生物再度崛起时，它们将展开王者争霸，人类的命运岌岌可危……',
        //   url:
        //       'http://cn4.download05.com/hls/20190727/0248d8f0033b991444d671fea2a42c57/1564205511/index.m3u8',
        // ),
        // VideoResource(
        //   title: '宝贝计划',
        //   image: 'http://ty.download05.com/1565608988136038.jpeg',
        //   description:
        //       '故事围绕一个刚出生的宝宝开始。人字拖（成龙 饰）虽有不凡的身手，可是终日沉迷赌博毫无人生目标，便与包租公（许冠文 饰）、八达通（古天乐 饰）一起爆窃，干着偷偷摸摸的犯罪事。城中女富豪（余安安 饰）唯一的孙子出生后，包租公受不了金钱的诱惑，答应把宝宝偷给黑帮老大，以证明BB是否自 己死去的儿子与前女友的孩子。 　　成功偷得孩子后，一连串发生的事情，使人字拖及八达通改变了自己的人生观念。人字拖开始关心家人，八达通也看到了自己老婆（蔡卓妍 饰）的不易，开始重新做人。 在包租公及黑势利的威胁下，他们还是要把偷来的BB交出来，到底又会发生些什么事，故事有会否大团圆结局呢？',
        //   url:
        //       'http://cn5.download05.com/hls/20190812/359ffef3ec383b63ec806d20d1ed09a5/1565605515/index.m3u8',
        // ),
        // VideoResource(
        //   title: '鹤峰综合',
        //   image:
        //       'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3005597700,3138816002&fm=26&gp=0.jpg',
        //   description: '新闻直播',
        //   url: 'http://hefeng.live.tempsource.cjyun.org/videotmp/s10100-hftv.m3u8',
        // ),
      ];

  _toCustomVideoPage() async {
    String url = await showDialog(
      context: context,
      builder: (context) => _InputDialog(),
    );
    if (url == null) {
      return;
    }
    if (!url.endsWith('.m3u8')) {
      var res = await showDialog(
        context: context,
        builder: (context) => _AlertUrlErrorDialog(url: url),
      );
      if (res != true) {
        return;
      }
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return VideoPage(
        resource: VideoResource(
          title: url.split('/').last,
          image: '',
          description: '自定视频',
          url: url,
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    var customUrlButton = Tapped(
      child: Container(
        height: 44,
        color: Color(0xfff5f5f4),
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.video_library,
              size: 16,
            ),
            Container(width: 4),
            Expanded(child: Text('使用自定义地址播放')),
            Icon(
              Icons.arrow_forward_ios,
              size: 12,
            ),
          ],
        ),
      ),
      onTap: _toCustomVideoPage,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('列表'),
      ),
      body: Column(
        children: <Widget>[
          customUrlButton,
          Expanded(
            child: ListView.builder(
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int index) {
                return VideoResourceRow(resource: _list[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertUrlErrorDialog extends StatelessWidget {
  const _AlertUrlErrorDialog({
    Key key,
    @required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('地址$url 可能不能使用p2p加速'),
      actions: <Widget>[
        Tapped(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              '取消',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          onTap: () {
            Navigator.of(context).pop(false);
          },
        ),
        Tapped(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              '仍然继续',
              style: TextStyle(color: Colors.red),
            ),
          ),
          onTap: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}

class _InputDialog extends StatefulWidget {
  const _InputDialog({
    Key key,
  }) : super(key: key);

  @override
  __InputDialogState createState() => __InputDialogState();
}

class __InputDialogState extends State<_InputDialog> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('输入自定义地址'),
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      children: <Widget>[
        TextField(
          controller: _controller,
          onSubmitted: (text) {
            Navigator.of(context).pop(_controller.text);
          },
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Tapped(
            child: Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                '确认',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop(_controller.text);
            },
          ),
        )
      ],
    );
  }
}

class VideoResourceRow extends StatelessWidget {
  final VideoResource resource;
  const VideoResourceRow({
    Key key,
    this.resource,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // 标题与梗概
    Widget info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          resource.title,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xff4a4a4a),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            resource.description,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xff9b9b9b),
            ),
          ),
        ),
      ],
    );
    return Tapped(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 12),
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Container(
              width: 66,
              constraints: BoxConstraints(
                minWidth: 66,
                minHeight: 88,
              ),
              margin: EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Image.network(resource.image),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xfff5f5f4))),
                ),
                child: info,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return VideoPage(
            resource: resource,
          );
        }));
      },
    );
  }
}
