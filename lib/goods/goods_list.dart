

import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/app_navigator.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/menu_reveal.dart';
import 'package:flutter_deer/widgets/state_layout.dart';

import 'goods_edit_page.dart';

class GoodsList extends StatefulWidget {
  
  const GoodsList({
    Key key,
    @required this.index
  }): super(key: key);
  
  final int index;
  
  @override
  _GoodsListState createState() => _GoodsListState();
}

class _GoodsListState extends State<GoodsList> with AutomaticKeepAliveClientMixin<GoodsList>, SingleTickerProviderStateMixin {
  
  int _selectIndex = -1;
  Animation<double> _animation;
  AnimationController _controller;
  List list = [];

  @override
  void initState() {
    super.initState();
    // 初始化动画控制
    _controller = new AnimationController(duration: const Duration(milliseconds: 450), vsync: this);
    // 动画曲线
    CurvedAnimation _curvedAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOutSine);
    _animation = new Tween(begin: 0.0, end: 1.1).animate(_curvedAnimation);

    //Item数量
    int count = widget.index == 0 ? 3 : (widget.index == 1 ? 15 : 26);
    list.clear();
    for(int i = 0; i < count; i++){
      list.add("");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return list.isEmpty ? StateLayout(type: StateType.goods,) : ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, index){
        return Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border(
                      bottom: Divider.createBorderSide(context, color: Colours.line, width: 0.8),
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Image.asset(Utils.getImgPath("goods/icon_goods"), width: 72.0, height: 72.0),
                      ),
                      Gaps.hGap8,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                "八月十五中秋月饼礼盒",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.textDark14
                            ),
                            Gaps.vGap4,
                            Row(
                              children: <Widget>[
                                Offstage(
                                  // 类似于gone
                                  offstage: index % 3 != 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    margin: const EdgeInsets.only(right: 4.0),
                                    decoration: BoxDecoration(
                                      color: Colours.text_red,
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                    height: 16.0,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "立减",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Dimens.font_sp10
                                      ),
                                    ),
                                  ),
                                ),
                                Opacity(
                                  // 修改透明度实现隐藏，类似于invisible
                                  opacity: index % 2 != 0 ? 0.0 : 1.0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF4688FA),
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                    height: 16.0,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "社区币抵扣",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Dimens.font_sp10
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Gaps.vGap16,
                            Text(
                              "¥20.00",
                              style: TextStyles.textDark14,
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                                width: 24.0,
                                height: 24.0,
                                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                                child: Image.asset(Utils.getImgPath("goods/ellipsis"))
                            ),
                            onTap: (){
                              // 开始执行动画
                              _controller.forward(from: 0.0);
                              setState(() {
                                _selectIndex = index;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Text(
                              "特产美味",
                              style: TextStyles.textGray12,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Offstage(
                offstage: _selectIndex != index,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder:(_, child){
                    return MenuReveal(
                      revealPercent: _animation.value,
                      child: InkWell(
                        onTap: (){
                          _controller.reverse(from: 1.1);
                          _selectIndex = -1;
                        },
                        child: Container(
                          color: Color(0x4D000000),
                          child: Theme( // 修改button默认的最小宽度与padding
                            data: Theme.of(context).copyWith(
                              buttonTheme: ButtonThemeData(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                minWidth: 56.0,
                                height: 56.0,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 距顶部距离为0
                                shape:RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                              textTheme: TextTheme(
                                  button: TextStyle(
                                    fontSize: Dimens.font_sp16,
                                  )
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Gaps.hGap15,
                                FlatButton(
                                  textColor: Colors.white,
                                  color: Colours.app_main,
                                  child: Text("编辑"),
                                  onPressed: (){
                                    setState(() {
                                      _selectIndex = -1;
                                    });
                                    AppNavigator.push(context, GoodsEdit(isAdd: false));
                                  },
                                ),
                                FlatButton(
                                  color: Colors.white,
                                  child: Text("下架"),
                                  onPressed: (){
                                    Toast.show("下架");
                                  },
                                ),
                                FlatButton(
                                  color: Colors.white,
                                  child: Text("删除"),
                                  onPressed: (){
                                    _controller.reverse(from: 1.1);
                                    _selectIndex = -1;
                                    _showDeleteBottomSheet(index);
                                  },
                                ),
                                Gaps.hGap15,
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),
            )
          ],
        );
      }
    );
  }

  @override
  bool get wantKeepAlive => true;

  _showDeleteBottomSheet(int index){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Material(
          color: Colors.white,
          child: SafeArea(
            child: Container(
              height: 161.2,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 52.0,
                    child: Text(
                      "是否确认删除，防止错误操作",
                      style: TextStyles.textDark16,
                    ),
                  ),
                  Gaps.line,
                  Container(
                    height: 54.0,
                    width: double.infinity,
                    child: FlatButton(
                      textColor: Colours.text_red,
                      child: Text("确认删除", style: TextStyle(fontSize: Dimens.font_sp18)),
                      onPressed: (){
                        setState(() {
                          list.removeAt(index);
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Gaps.line,
                  Container(
                    height: 54.0,
                    width: double.infinity,
                    child: FlatButton(
                      textColor: Colours.text_gray,
                      child: Text("取消", style: TextStyle(fontSize: Dimens.font_sp18)),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              )
            ),
          ),
        );
      },
    );
  }
}