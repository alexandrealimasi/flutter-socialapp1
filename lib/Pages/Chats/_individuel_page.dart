import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app1/models/models_export.dart';

import 'package:social_app1/screens/screens_export.dart';
import 'package:social_app1/services/http/http_helper.dart';
import 'package:social_app1/utils/_shared_preferences.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;
import 'dart:developer' as dev;
import 'package:socket_io_client/socket_io_client.dart';

import '_receve_message_card.dart';
import '_send_message_card.dart';

class IndividuelPage extends StatefulWidget {
  static const String individuelPageId = "IndividuelPage";
  final ConversationModel? conversationModel;
  final User? user;
  final bool? isfirst;

  const IndividuelPage(
      {Key? key, this.conversationModel, this.user, this.isfirst})
      : super(key: key);
  @override
  _IndividuelPageState createState() => _IndividuelPageState();
}

class _IndividuelPageState extends State<IndividuelPage> {
  @override
  void initState() {
    super.initState();
    if (!widget.isfirst!) {
      getmessages();
      circle = true;
    } else {
      circle = false;
    }
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    // connect();
  }

  FocusNode focusNode = FocusNode();
  bool show = false;
  io.Socket? socket;
  bool sendButton = false;
  bool iconColor = false;

  TextEditingController msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  setMessage(String message) {
    MessageModel messageModel = MessageModel(
        message: message,
        sender: widget.isfirst!
            ? User(id: UserPreferences.uuid)
            : widget.conversationModel?.sender,
        createdAt: DateTime.now().toString());
    dev.log(messageList.toString());
    setState(() {
      circle = false;
      messageList.add(messageModel);
    });
  }

  //connected() {
  //_scrollController.animateTo(_scrollController.position.maxScrollExtent,
  // duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  //}

  bool circle = true;

  void connect() {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = io.io(HttpHelper.baseUrl, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket?.connect();
    socket?.emit("signin", sourceMessage?.conversationId);
    socket?.onConnect((data) {
      dev.log("Connected");
      socket?.on("message", (msg) {
        dev.log("message");
        dev.log(msg);
      });
    });
    dev.log("${socket?.connected}");
  }

  List<MessageModel> messageList = [];
  MessageModel? sourceMessage;
  HttpHelper httpHelper = HttpHelper();
  getmessages() async {
    var response = await httpHelper.get(
        "/message/get/${widget.conversationModel?.id}?Authorization=Bearer ${UserPreferences.token}");
    dev.log(response.toString());
    if (response["messages"] != null) {
      var listData = response['messages'];
      listData.forEach((item) {
        return messageList.add(MessageModel.fromjson(item));
      });
      setState(() {
        circle = false;
      });
    }
  }

  addmessage() async {
    Map<String, String> data = {"message": msgController.text};

    var response = await httpHelper.post(
        "/message/add/${widget.conversationModel?.id}?Authorization=Bearer ${UserPreferences.token}",
        data);
    if (response.statusCode == 200) {
      Map<String, dynamic> output = json.decode(response.body);
      dev.log(output.toString());
      setState(() {
        circle = false;
      });
    }
    if (response.statusCode == 401) {
      dev.log("not message");
    }
  }

  createNewMessage() async {
    Map<String, String> data = {
      "receverId": "${widget.user?.id}",
      "message": msgController.text
    };
    var response = await httpHelper.post(
        "/message/create?Authorization=Bearer ${UserPreferences.token}", data);
    if (response.statusCode == 200) {
      Map<String, dynamic> output = json.decode(response.body);
      dev.log(output.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
        backgroundColor: Colors.teal,
        centerTitle: true,
        titleSpacing: 0,
        title: InkWell(
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${widget.isfirst! ? widget.user?.username:widget.conversationModel?.receiver.username}"),
              Text(
                "Lat tody at 07:12",
                style: GoogleFonts.lato(fontSize: 14),
              )
            ],
          ),
        ),
        leadingWidth: 0.3,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const CircleAvatar(
            radius: 30,
            // child: SvgPicture.asset(
            //   "assets/images/${widget.chatModel.icone}",
            //   height: 25,
            //   width: 25,
            //   color: Colors.white,
            // ),
            backgroundColor: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        color: Colors.blueGrey,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WillPopScope(
          onWillPop: () {
            if (show) {
              setState(() {
                show = false;
              });
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
          child: Column(
            children: [
              Expanded(
                  // height: MediaQuery.of(context).size.height - 150,
                  child: circle
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: messageList.length,
                          itemBuilder: (context, index) {
                            if (messageList[index].isMe) {
                              return SendeMessageCard(
                                messageModel: messageList[index],
                              );
                            } else {
                              return ReceverMessage(
                                  messageModel: messageList[index]);
                            }
                          })),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 60,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: TextFormField(
                              controller: msgController,
                              focusNode: focusNode,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    sendButton = true;
                                  });
                                } else {
                                  setState(() {
                                    sendButton = false;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type a message",
                                hintStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: IconButton(
                                  icon: Icon(
                                    show
                                        ? Icons.keyboard
                                        : Icons.emoji_emotions_outlined,
                                  ),
                                  onPressed: () {
                                    if (!show) {
                                      focusNode.unfocus();
                                      focusNode.canRequestFocus = false;
                                    }
                                    setState(() {
                                      show = !show;
                                    });
                                  },
                                ),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.attach_file),
                                      onPressed: () {
                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (builder) => butonshet());
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.camera_alt),
                                      onPressed: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (builder) =>
                                        //             CameraApp()));
                                      },
                                    ),
                                  ],
                                ),
                                contentPadding: const EdgeInsets.all(5),
                              ),
                            ),
                            margin: const EdgeInsets.only(
                                left: 2, right: 2, bottom: 8),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8,
                            right: 2,
                            left: 2,
                          ),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: const Color(0xFF128C7E),
                            child: IconButton(
                              icon: Icon(
                                sendButton ? Icons.send : Icons.mic,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                circle = true;
                                if (msgController.text.isNotEmpty) {
                                  if (sendButton) {
                                    _scrollController.animateTo(
                                        _scrollController
                                            .position.maxScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeOut);
                                    setMessage(msgController.text);
                                    widget.isfirst!
                                        ? createNewMessage()
                                        : addmessage();
                                    msgController.clear();
                                    setState(() {
                                      sendButton = false;
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    // emojiPicker()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget emojiPicker() {
  //   return EmojiPicker2(
  //     rows: 4,
  //     columns: 7,
  //     onEmojiSelected: (emoji, Category) {
  //       dev.log("$emoji");
  //     },
  //   );
  // }
  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Icon(
              icon,
              size: 25,
            ),
            radius: 30,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: GoogleFonts.lato(fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget butonshet() {
    return SizedBox(
      height: 279,
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Documment"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camere"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact")
                ],
              ),
            ),
          ],
        ),
        margin: const EdgeInsets.all(18),
      ),
    );
  }
}
