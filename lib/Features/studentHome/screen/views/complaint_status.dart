import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insecure/Features/studentHome/controller/coplaint_status_contoller.dart';
import 'package:insecure/core/class/handlingdataview.dart';
import 'package:insecure/core/constant/color.dart';
import 'package:intl/intl.dart';

class ComplaintStatusScreen extends StatelessWidget {
  const ComplaintStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ComplaintStatusController());
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
      body: GetBuilder<ComplaintStatusController>(
        builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: controller.complaints.length,
              itemBuilder: (context, index) {
                final complaint = controller.complaints[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: AppColor.black, width: 2)),
                  elevation: 0,
                  color: AppColor.white,
                  margin: EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(text: 'subject | '),
                              TextSpan(
                                text: complaint.complaintTitle,
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                            'Date | ${DateFormat.yMd().format(DateTime.parse(complaint.complaintDate.toString()))}    Time | ${DateFormat.Hm().format(DateTime.parse(complaint.complaintDate.toString()))} AM',
                            style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 8),
                        Text('Type | ${complaint.typeName}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Status | ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Colors.black, // اللون الأسود دائمًا
                                    ),
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
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.black,
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                      color: Colors.black, width: 1.5),
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'View complaint content',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.close,
                                                    color: Colors.red),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                          Divider(),
                                          SizedBox(height: 10),
                                          Text(
                                            complaint.complaintContent
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                          SizedBox(height: 20),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColor.primaryColor,
                                                foregroundColor: Colors.white,
                                              ),
                                              icon: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                              ),
                                              label: Text('تم'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Complaint content',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
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
