///
//  Generated code. Do not modify.
//  source: security_bear_connections.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'security_bear_connections.pb.dart' as $0;
export 'security_bear_connections.pb.dart';

class SecurityBearClient extends $grpc.Client {
  static final _$setWiFiInformation =
      $grpc.ClientMethod<$0.SecurityBearSetup, $0.SBCommendStatus>(
          '/SecurityBearConnections.SecurityBear/SetWiFiInformation',
          ($0.SecurityBearSetup value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SBCommendStatus.fromBuffer(value));
  static final _$setFirebaseAccountAndSecurityBearSetup = $grpc.ClientMethod<
          $0.SBFirebaseAccountAndSecurityBearSetup, $0.SBCommendStatus>(
      '/SecurityBearConnections.SecurityBear/SetFirebaseAccountAndSecurityBearSetup',
      ($0.SBFirebaseAccountAndSecurityBearSetup value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SBCommendStatus.fromBuffer(value));

  SecurityBearClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.SBCommendStatus> setWiFiInformation(
      $0.SecurityBearSetup request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setWiFiInformation, request, options: options);
  }

  $grpc.ResponseFuture<$0.SBCommendStatus>
      setFirebaseAccountAndSecurityBearSetup(
          $0.SBFirebaseAccountAndSecurityBearSetup request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setFirebaseAccountAndSecurityBearSetup, request,
        options: options);
  }
}

abstract class SecurityBearServiceBase extends $grpc.Service {
  $core.String get $name => 'SecurityBearConnections.SecurityBear';

  SecurityBearServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SecurityBearSetup, $0.SBCommendStatus>(
        'SetWiFiInformation',
        setWiFiInformation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SecurityBearSetup.fromBuffer(value),
        ($0.SBCommendStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SBFirebaseAccountAndSecurityBearSetup,
            $0.SBCommendStatus>(
        'SetFirebaseAccountAndSecurityBearSetup',
        setFirebaseAccountAndSecurityBearSetup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SBFirebaseAccountAndSecurityBearSetup.fromBuffer(value),
        ($0.SBCommendStatus value) => value.writeToBuffer()));
  }

  $async.Future<$0.SBCommendStatus> setWiFiInformation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SecurityBearSetup> request) async {
    return setWiFiInformation(call, await request);
  }

  $async.Future<$0.SBCommendStatus> setFirebaseAccountAndSecurityBearSetup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SBFirebaseAccountAndSecurityBearSetup> request) async {
    return setFirebaseAccountAndSecurityBearSetup(call, await request);
  }

  $async.Future<$0.SBCommendStatus> setWiFiInformation(
      $grpc.ServiceCall call, $0.SecurityBearSetup request);
  $async.Future<$0.SBCommendStatus> setFirebaseAccountAndSecurityBearSetup(
      $grpc.ServiceCall call, $0.SBFirebaseAccountAndSecurityBearSetup request);
}
