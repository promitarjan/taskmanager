// ignore: file_names
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:taskmanager/Style/Style.dart';
import 'package:http/http.dart' as http;

import '../utility/utility.dart';

var BaseURL = "http://35.73.30.144:2005/api/v1";

var RequestHeader = {"Content-Type": "application/json"};

Future<bool> LoginRequest(FormValues) async {
  var URL = Uri.parse("$BaseURL/login");
  var PostBody = json.encode(FormValues);
  var response = await http.post(URL, headers: RequestHeader, body: PostBody);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);
  if (ResultCode == 200 && ResultBody['status'] == "success") {
    SuccessToast("Request Success");
    await WriteUserData(ResultBody);
    return true;
  } else {
    ErrorToast("Request fail ! try again");
    return false;
  }
}

Future<bool> RegistrationRequest(FormValues) async {
  var URL = Uri.parse("$BaseURL/Registration");
  var PostBody = json.encode(FormValues);
  var response = await http.post(URL, headers: RequestHeader, body: PostBody);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);
  if (ResultCode == 200 && ResultBody['status'] == "success") {
    SuccessToast("Request Success");
    return true;
  } else {
    ErrorToast("Request fail ! try again");
    return false;
  }
}

Future<bool> VerifyEmailRequest(Email) async {
  var URL = Uri.parse("$BaseURL/RecoverVerifyEmail/$Email");
  var response = await http.get(URL, headers: RequestHeader);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);
  if (ResultCode == 200 && ResultBody['status'] == "success") {
    await WriteEmailVerification(Email);
    SuccessToast("Request Success");
    return true;
  } else {
    ErrorToast("Request fail ! try again");
    return false;
  }
}

Future<bool> VerifyOTPRequest(Email, OTP) async {
  var URL = Uri.parse("$BaseURL/RecoverVerifyOtp/$Email/$OTP");
  var response = await http.get(URL, headers: RequestHeader);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);
  if (ResultCode == 200 && ResultBody['status'] == "success") {
    await WriteOTPVerification(OTP);
    SuccessToast("Request Success");
    return true;
  } else {
    ErrorToast("Request fail ! try again");
    return false;
  }
}

Future<bool> SetPasswordRequest(FormValues) async {
  var URL = Uri.parse("$BaseURL/RecoverResetPassword");
  var PostBody = json.encode(FormValues);

  var response = await http.post(URL, headers: RequestHeader, body: PostBody);

  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if (ResultCode == 200 && ResultBody['status'] == "success") {
    SuccessToast("Request Success");
    return true;
  } else {
    ErrorToast("Request fail ! try again");
    return false;
  }
}

Future<List> TaskListRequest(Status) async {
  var URL = Uri.parse("$BaseURL/listTaskByStatus/$Status");
  String? token = await ReadUserData("token");
  var RequestHeaderWithToken = {
    "Content-Type": "application/json",
    "token": '$token'
  };
  var response = await http.get(URL, headers: RequestHeaderWithToken);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);
  if (ResultCode == 200 && ResultBody['status'] == "success") {
    SuccessToast("Request Success");
    return ResultBody['data'];
  } else {
    ErrorToast("Request fail ! try again");
    return [];
  }
}

Future<bool> TaskCreateRequest(FormValues) async {
  var URL = Uri.parse("$BaseURL/createTask");
  String? token = await ReadUserData("token");
  var RequestHeaderWithToken = {
    "Content-Type": "application/json",
    "token": '$token'
  };

  var PostBody = json.encode(FormValues);

  var response =
      await http.post(URL, headers: RequestHeaderWithToken, body: PostBody);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);
  if (ResultCode == 200 && ResultBody['status'] == "success") {
    SuccessToast("Request Success");
    return true;
  } else {
    ErrorToast("Request fail ! try again");
    return false;
  }
}

Future<bool> TaskDeleteRequest(id) async {
  var URL = Uri.parse("$BaseURL/deleteTask/$id");
  String? token = await ReadUserData("token");
  var RequestHeaderWithToken = {
    "Content-Type": "application/json",
    "token": '$token'
  };
  var response = await http.get(URL, headers: RequestHeaderWithToken);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);
  if (ResultCode == 200 && ResultBody['status'] == "success") {
    SuccessToast("Request Success");
    return true;
  } else {
    ErrorToast("Request fail ! try again");
    return false;
  }
}

Future<bool> TaskUpdateRequest(id, status) async {
  var URL = Uri.parse("$BaseURL/updateTaskStatus/$id/$status");
  String? token = await ReadUserData("token");
  var RequestHeaderWithToken = {
    "Content-Type": "application/json",
    "token": '$token'
  };
  var response = await http.get(URL, headers: RequestHeaderWithToken);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);
  if (ResultCode == 200 && ResultBody['status'] == "success") {
    SuccessToast("Request Success");
    return true;
  } else {
    ErrorToast("Request fail ! try again");
    return false;
  }
}
