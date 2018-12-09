import 'package:flutter/material.dart';

const by = 'gok 18 hours ago [-]';
const comment =
    "As I understand it, there were basically two bug classes. s that characteristics of branch prediction within the same process can reveal information about the branch path not taken, even if that branch is itself a bounds check or other security check.The first attack isn't relevant to designs that don't use hardware isolation, but the second one absolutely is. If your virtual bytecode (wasm, JVM, Lua, whatever) is allowed access to a portion of memory, and inside the same hardware address space is other memory it shouldn't read (e.g., because there are two software-isolated processes in the same hardware address space), and a supervisor or JIT is guarding its memory accesses with branches, the second attack will let the software-isolated process execute cache timing attacks against the data on the wrong side of the branch. (I believe the names are more-or-less that Meltdown is the first bug class and Spectre is the second, but the Spectre versions are rather different in characteristics - in particular I believe that Spectre v1 affects software-isolation-only systems and Spectre v2 less so. But the names confuse me.) reply";

class DisplayComments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Comments',
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Comment(by, comment),
          Comment(by, comment),
          Comment(by, comment),
          Comment(by, comment),
          Comment(by, comment),
          Comment(by, comment),
          Comment(by, comment),
          Comment(by, comment),
        ],
      ),
    );
  }
}

class Comment extends StatefulWidget {
  final String _by;
  final String _comment;

  Comment(this._by, this._comment);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final int _commentPreviewMaxLength = 200;

  String _commentPreview;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();

    if (widget._comment.length > _commentPreviewMaxLength) {
      _commentPreview =
          widget._comment.substring(0, _commentPreviewMaxLength - 1) + ' ...';
    } else {
      _commentPreview = widget._comment;
    }
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        //width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 5.0),
              child: Text(
                widget._by,
                style: TextStyle(
                    color: Colors.grey.shade700, fontSize: 11.0, height: 1.3),
              ),
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    //constraints:  BoxConstraints.expand(height: 100.0),
                    height: 64,
                    width: 1.0,
                    color: Colors.black,
                    margin: const EdgeInsets.only(left: 0.0, right: 6.0),
                  ),
                  Flexible(
                    child: _isExpanded
                        ? Text(widget._comment)
                        : Text(
                            _commentPreview,
                            overflow: TextOverflow.clip,
                          ),
                  ),
                ]),
            ListView(
              shrinkWrap: true,
              children:  _isExpanded
                  ? <Widget>[Text('balab'), Text('blabla2')]
                  : <Widget>[]
            ),
          ],
        ),
      ),
    );
  }
}
