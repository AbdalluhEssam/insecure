import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insecure/Features/studentHome/controller/coplaint_status_contoller.dart';
import 'package:insecure/core/class/handlingdataview.dart';

class ComplaintStatusScreen extends StatelessWidget {
  const ComplaintStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ComplaintStatusController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Status'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
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
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
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
                            'Date | ${complaint.complaintDate}    Time | ${complaint.complaintDate}',
                            style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 8),
                        Text('Type | ${complaint.typeName}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Status | ${complaint.status}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: complaint.status == 'replied'
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {},
                              child: Text('Reply'),
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
