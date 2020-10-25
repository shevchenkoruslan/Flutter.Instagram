import 'package:Fluttegram/util/utility.dart';

import 'package:flutter/material.dart';

import 'hero_photo_post.dart';

class Post extends StatefulWidget {
  final String username;
  final String userImagePath;
  final String contentImagePath;
  final String description;
  final String postedTime;
  final String tag;

  int nLikes = 0;

  Post(
      [this.username = "ruslan",
      this.userImagePath = "assets/images/avatar.jpg",
      this.contentImagePath = "assets/images/post.jpg",
      this.description = " Have a nice day :)",
      this.postedTime = "1 hour ago"])
      : this.tag = Utility.getRandomTag(9);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        child: Column(
          children: <Widget>[
            buildPostHeader(),
            buildContent(),
            buildSubtitle(),
            buildSeeAllComments(),
            buildPostedTime()
          ],
        ));
  }

  Widget buildPostHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(backgroundImage: AssetImage(widget.userImagePath)),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  widget.username,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.linear_scale,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  void doLikeFunction(int nLikes) {
    setState(() {
      widget.nLikes += nLikes;
    });
  }

  Widget buildContent() {
    return Column(
      children: <Widget>[
        Container(
          child: Hero(
              tag: widget.tag,
              child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HeroPhotoPage(
                              widget.username,
                              widget.tag,
                              Image.asset(widget.contentImagePath),
                              widget.description,
                              widget.nLikes,
                              doLikeFunction))),
                  child: Image.asset(widget.contentImagePath))),
        ),
        buildInteractionRow()
      ],
    );
  }

  Widget buildInteractionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: widget.nLikes == 0 ? Colors.white : Colors.red,
              ),
              onPressed: () {
                doLikeFunction(1);
              },
            ),
            Text(
              'Likes: ${widget.nLikes}',
              style: TextStyle(color: widget.nLikes == 0 ? Colors.white : Colors.red),
            ),
            IconButton(
              icon: Icon(
                Icons.mode_comment,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.send,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.bookmark_border,
            color: Colors.white,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  Widget buildSubtitle() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Text(
            widget.username,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Text(
              widget.description,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSeeAllComments() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        'All comments',
        style: TextStyle(color: Colors.grey[700]),
      ),
    );
  }

  Widget buildPostedTime() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        widget.postedTime,
        style: TextStyle(
          fontSize: 8,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}
