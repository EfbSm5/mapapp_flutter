import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode _focusNode = FocusNode(); // 用于监听焦点变化
  final TextEditingController _controller = TextEditingController(); // 获取输入内容
  bool _isSearchActive = false; // 控制 TextField 的位置
  List<String> _searchResults = []; // 存储搜索结果

  void _onSearch(String query) {
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _isSearchActive = true; // 点击 TextField 后移动到顶部
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("搜索页面")),
      body: Stack(
        children: [
        // 顶部的 ConstrainedBox，用于显示自定义内容
        Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 200),
          child: Container(
            constraints: const BoxConstraints.expand(),
            child: SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: map,
            ),
          ),
        ),
        Positioned(
          top: _isSearchActive ? 200 : MediaQuery
              .of(context)
              .size
              .height,
          left: 0,
          right: 0,
          bottom: 0,
          child: _searchResults.isEmpty
              ? Center(child: Text("没有找到匹配结果"))
              : ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_searchResults[index]),
              );
            },
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom:
          _isSearchActive ? MediaQuery
              .of(context)
              .size
              .height - 260 : 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: "输入搜索内容",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _onSearch, // 用户输入时触发搜索
            ),
          ),
        ),
        ],
      ),
    );
  }
}
