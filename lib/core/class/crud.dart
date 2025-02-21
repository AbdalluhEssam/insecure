import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:insecure/core/class/statusrequest.dart';
import 'package:path/path.dart';

import '../functions/checkinterner.dart';

class Crud {
  Future<Either<StatusRequest, dynamic>> postData(String linkUrl, Map data,
      {Map<String, String>? headers}) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(
          Uri.parse(linkUrl),
          body: data,
          headers: headers,
        );

        log("====================================== ${response.statusCode.toString()}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          dynamic responseBody =
              jsonDecode(response.body); // Response could be List or Map

          if (responseBody is List) {
            log("Received List: ${responseBody.toString()}");
            return Right(responseBody); // Return List<dynamic> as response
          } else if (responseBody is Map) {
            log("Received Map: ${responseBody.toString()}");
            return Right(
                responseBody); // Return Map<String, dynamic> as response
          } else {
            log("Unexpected data format: ${responseBody.toString()}");
            return const Left(StatusRequest.serverFailure);
          }
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      log("Error: $e");
      return const Left(StatusRequest.serverFailure);
    }
  }

 

  Future<Either<StatusRequest, dynamic>> getData(String linkUrl, Map data,
      {Map<String, String>? headers}) async {
    try {
      if (await checkInternet()) {
        var response = await http.get(Uri.parse(linkUrl), headers: headers);

        log("Response status: ${response.statusCode}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          dynamic responseBody =
              jsonDecode(response.body); // Decode the JSON response
          log("Response body: ${responseBody.toString()}");

          if (responseBody is List) {
            log("Received List: ${responseBody.length} items");
            return Right(responseBody);
          } else if (responseBody is Map) {
            log("Received Map: ${responseBody.toString()}");
            return Right(responseBody);
          } else {
            log("Unexpected data format: ${responseBody.toString()}");
            return const Left(StatusRequest.serverFailure);
          }
        } else {
          log("Server error: ${response.statusCode}");
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        log("No internet connection.");
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      log("Error: $e");
      return const Left(StatusRequest.serverFailure);
    }
  }



  postRequestWithFiles(String url, Map data, File file, String filename) async {
    Map<String, String> headers = {"apikey": "K83400380388957"};

    var request = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile(filename, stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);
    request.headers.addAll(headers);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myRequest = await request.send();

    var response = await http.Response.fromStream(myRequest);
    if (myRequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      log("Error${myRequest.statusCode}");
    }
  }

  postRequestWithImage(String url, Map data, File file, String filename) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile(filename, stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myRequest = await request.send();

    var response = await http.Response.fromStream(myRequest);
    if (myRequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      log("Error${myRequest.statusCode}");
    }
  }
}
