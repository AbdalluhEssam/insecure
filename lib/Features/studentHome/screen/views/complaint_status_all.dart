import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insecure/Features/studentHome/controller/coplaint_status_all_contoller.dart';
import 'package:insecure/core/class/handlingdataview.dart';
import 'package:insecure/core/constant/color.dart';
import 'package:insecure/core/helper/spacing.dart';
import 'package:insecure/likeapi.dart';
import 'package:intl/intl.dart';

class ComplaintStatusAllScreen extends StatelessWidget {
  const ComplaintStatusAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ComplaintStatusAllController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Status',
            style: TextStyle(
              color: AppColor.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.primaryColor,
          ),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: GetBuilder<ComplaintStatusAllController>(
        builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: controller.complaints.length,
              itemBuilder: (context, index) {
                final complaint = controller.complaints[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: AppColor.black, width: 1.5),
                  ),
                  elevation: 3,
                  color: complaint.status != 1
                      ? AppColor.secondColor
                      : AppColor.white,
                  margin: EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: CachedNetworkImageProvider(
                                "${AppLink.imageUserStatic}/${complaint.image.toString()}",
                              ),
                            ),
                            horizontalSpace(12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  complaint.name.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  complaint.studentCode.toString(),
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ],
                        ),
                        verticalSpace(12),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: 'Subject | ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: complaint.complaintTitle),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Date | ${DateFormat.yMd().format(DateTime.parse(complaint.complaintDate.toString()))}   Time | ${DateFormat.Hm().format(DateTime.parse(complaint.complaintDate.toString()))}',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Type | ${complaint.typeName}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),

                        /// نص الشكوى
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Complaint Content | ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: complaint.complaintContent),
                            ],
                          ),
                        ),

                        /// صورة الشكوى (إذا كانت موجودة)
                        if (complaint.complaintImage != null &&
                            complaint.complaintImage.toString().isNotEmpty) ...[
                          SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "${AppLink.imageComplaintStatic}/${complaint.complaintImage.toString()}",
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: 40),
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                        SizedBox(height: 12),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 16),
                            children: [
                              TextSpan(
                                text: 'Status | ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: complaint.status == 1
                                    ? 'Under Review'
                                    : 'Replied',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: complaint.status == 1
                                      ? AppColor.primaryColor
                                      : Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        if (complaint.status == 1)
                          Align(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16)),
                                  ),
                                  builder: (context) => Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Form(
                                      key: controller.formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Reply to Complaint',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Divider(),
                                          SizedBox(height: 10),
                                          TextFormField(
                                            maxLines: 3,
                                            controller:
                                                controller.complaintReply,
                                            decoration: InputDecoration(
                                              hintText: 'Write your reply...',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                controller.replayComplaints(
                                                    complaint.complaintId
                                                        .toString());
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                foregroundColor: Colors.white,
                                              ),
                                              icon: Icon(Icons.send,
                                                  color: Colors.white),
                                              label: Text('Send Reply'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.reply, color: Colors.white),
                              label: Text(
                                'Reply to Complaint',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        if (complaint.status != 1)
                          RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 16),
                              children: [
                                TextSpan(
                                  text: 'Replied | ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                TextSpan(
                                  text: complaint.complaintReply,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
