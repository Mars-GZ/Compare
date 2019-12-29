import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'constant.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Compare',
    home: new MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final SystemUiOverlayStyle _style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
//    debugPaintSizeEnabled = true;
    SystemChrome.setSystemUIOverlayStyle(_style);
    // TODO: implement build
    return MaterialApp(
      title: AppConstant.APP_NAME,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: AppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            elevation: 0,
            actions: <Widget>[
              Image(
                image: AssetImage("images/homepage_btn_more.png"),
                width: 55,
                height: 55,
              )
            ],
          ),
          preferredSize: Size.fromHeight(55)),
      body: new ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(top: 38),
                child: new ConstrainedBox(
                  constraints:
                      BoxConstraints(minWidth: double.infinity, minHeight: 214),
                  child: new Stack(
                    children: <Widget>[
                      new Positioned(
                        child: new Image(
                          image: AssetImage("images/homepage_pic_logo.png"),
                          width: 128,
                          height: 128,
                        ),
                      ),
                      new Container(
                        decoration: new BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Color(0x09000000),
                              offset: Offset(0, 2.0),
                              blurRadius: 24.0),
                        ]
//                            image: DecorationImage(
//                                image: AssetImage(
//                                    "images/homepage_bg_search.png"))
                            ),
                        margin: EdgeInsets.only(top: 114),
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: new HomePageSearchBox(),
                      )
                    ],
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              new SearchHistoryBoxTitle(),
              new SearchHistoryBoxList(),
            ],
          )),
    );
  }
}

class HomePageSearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ConstrainedBox(
      constraints: BoxConstraints(minWidth: double.infinity, minHeight: 100),
      child: new Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new SizedBox(
              height: 48,
              child: new DecoratedBox(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Image.asset("images/searchbar_icon_search.png"),
                    ),
                    new Text(AppConstant.SEARCH_BAR_HINT,
                        style: new TextStyle(
                            fontSize: 16, color: Color(0xff999999)))
                  ],
                ),
              ),
            ),
            flex: 1,
          ),
          new SizedBox(
            width: 76,
            height: 48,
            child: new DecoratedBox(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(colors: [
                    const Color(0xffff8723),
                    const Color(0xffff4f0f)
                  ]),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: new Center(
                child: new Text(
                  AppConstant.APP_NAME,
                  style: new TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SearchHistoryBoxTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      height: 42,
      margin: EdgeInsets.only(left: 25, right: 25),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text(
            AppConstant.HISTORY_RECORD,
            style: new TextStyle(color: Color(0xff333333), fontSize: 18),
          ),
          new Align(
            alignment: Alignment.centerRight,
            child: new Image.asset("images/history_btn_delete.png"),
          )
        ],
      ),
    );
  }
}

class SearchHistoryBoxList extends StatefulWidget {
  List _words = <String>[
    "望京小腰",
    "眉州东坡酒楼",
    "德克士",
    "马路边边串串香",
    "supreme 极境·轻奢烘焙",
    "CoCo都可",
    "巴依老爷新疆美食",
    "三十六味匠猪蹄",
    "星巴克",
    "局气"
  ];

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchHistoryBoxListState(words: _words);
  }
}

typedef void SET_SEARCH_PAGE(int page, Map pageMap);

class _SearchHistoryBoxListState extends State<SearchHistoryBoxList> {
  List words;
  bool isInit = true;
  int maxPage;
  Map pageMap;
  final PageController _pageController = new PageController();

  _SearchHistoryBoxListState({@required this.words});

  void setPage(int maxPage, Map pageMap) {
//    setState(() {
//      isInit = false;
//      this.pageMap = pageMap;
//      this.maxPage = maxPage;
//    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
        height: 186,
        child: PageView.builder(
          controller: _pageController,
          itemBuilder: (context, index) {
            return new ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Flow(
                delegate: isInit
                    ? _SearchMeasureHistoryFlowDelegate(
                        margin: EdgeInsets.only(
                            left: 0, top: 5, right: 5, bottom: 0),
                        set_search_page: setPage)
                    : index >= maxPage
                        ? null
                        : _SearchHistoryFlowDelegate(
                            margin: EdgeInsets.only(
                                left: 0, top: 5, right: 5, bottom: 0)),
                children: isInit
                    ? words.map((words) {
                        return new SearchHistoryBoxItem(keyword: words);
                      }).toList()
                    : null,
              ),
            );
          },
        ));
  }

  List<Widget> createSearchBoxList(int index) {
    int startCount = index == 0 ? 0 : pageMap[index - 1] + 1;
    int endCount = pageMap[index];
    List<Widget> widgets = [];
    for (int i = startCount; i <= endCount; i++) {
      widgets.add(new SearchHistoryBoxItem(keyword: words[i]));
    }
    return widgets;
  }
}

class _SearchHistoryFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  _SearchHistoryFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    // TODO: implement paintChildren
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }
}

class _SearchMeasureHistoryFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;
  int maxLine = 3;
  SET_SEARCH_PAGE set_search_page;

  _SearchMeasureHistoryFlowDelegate(
      {this.margin, this.maxLine, @required this.set_search_page});

  @override
  void paintChildren(FlowPaintingContext context) {
    // TODO: implement paintChildren
    var x = 0.0;
    var y = 0.0;
    int page = 0;
    int line = 0;
    var pageMap = {};
    print(context.childCount);
    for (int i = 0; i < context.childCount; i++) {
      double childWidth = context.getChildSize(i).width;
      var w = context.getChildSize(i).width + x + margin.right;
      print("size : $childWidth");
      print("i : $i");
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        if (line == maxLine) {
          pageMap[page] = i;
          page++;
          line = 0;
          y = 0.0;
        } else {
          line++;
          y += context.getChildSize(i).height + margin.top + margin.bottom;
        }
        x = 0.0;
        //绘制子widget(有优化)
        print("x : $x");
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
    pageMap[page] = context.childCount;
    set_search_page(page, pageMap);
    print(page);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }
}

class SearchHistoryBoxItem extends StatelessWidget {
  final String keyword;

  SearchHistoryBoxItem({@required this.keyword});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
        height: 39,
        child: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                  color: Color(0xfff7f7f7),
                  borderRadius: BorderRadius.circular(16)),
              child: new Text(keyword,
                  style: new TextStyle(fontSize: 14, color: Color(0xff545454))),
              padding: EdgeInsets.only(top: 6, bottom: 6, left: 14, right: 14),
              margin: EdgeInsets.only(top: 7, right: 7),
            )
          ],
        ));
  }
}

//TODO 第一次用透明的flowdelegate算出所有的单词所占页数后，刷新布局，然后每页分配。
