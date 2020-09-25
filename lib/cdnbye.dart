import 'dart:async';

import 'package:flutter/services.dart';

typedef CdnByeInfoListener = void Function(Map);

extension NextMonth on DateTime {
  DateTime nextMonth(int step) {
    return DateTime(
      year,
      month + step,
      day,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }
}

class Cdnbye {
  static const MethodChannel _channel = const MethodChannel('cdnbye');

  // The version of SDK. SDK的版本号
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  // Create a new instance with token and the specified config.
  static Future<int> init(
    token, {
    P2pConfig config,
    CdnByeInfoListener infoListener,
  }) async {
    final int success = await _channel.invokeMethod('init', {
      'token': token,
      'config': config.toMap,
    });
    if (infoListener != null) {
      await _channel.invokeMethod('startListen');
      _channel.setMethodCallHandler((call) async {
        if (call.method == 'info') {
          infoListener(call.arguments);
        }
      });
    }
    return success;
  }

  // Get parsed local stream url by passing the original stream url(m3u8) to CBP2pEngine instance.
  static Future<String> parseStreamURL(String sourceUrl) async {
    final String url = await _channel.invokeMethod('parseStreamURL', {
      'url': sourceUrl,
    });
    return url;
  }

  // Get the connection state of p2p engine. 获取P2P Engine的连接状态
  static Future<bool> isConnected() => _channel.invokeMethod('isConnected');

  // Restart p2p engine.
  static Future restartP2p() => _channel.invokeMethod('restartP2p');

  // Stop p2p and free used resources.
  static Future stopP2p() => _channel.invokeMethod('stopP2p');

  // Get the peer ID of p2p engine. 获取P2P Engine的peer ID
  static Future<String> getPeerId() => _channel.invokeMethod('getPeerId');
}

// Print log level.
enum P2pLogLevel {
  none,
  debug,
  info,
  warn,
  error,
}

// The configuration of p2p engine.
class P2pConfig {
  final P2pLogLevel logLevel;
  final Map webRTCConfig;
  final String wsSignalerAddr;
  final String announce;
  final int diskCacheLimit;
  final int memoryCacheLimit;
  final bool p2pEnabled;
  final Duration downloadTimeout;
  final Duration dcDownloadTimeout;
  final String tag;
  final int localPort;
  final int maxPeerConnections;
  final bool useHttpRange;
  final String channelIdPrefix;

  P2pConfig({
    this.logLevel: P2pLogLevel.warn,
    this.webRTCConfig: const {}, // TODO: 默认值缺少
    this.wsSignalerAddr: 'wss://signal.cdnbye.com',
    this.announce: 'https://tracker.cdnbye.com/v1',
    this.diskCacheLimit: 1024 * 1024 * 1024,
    this.memoryCacheLimit: 60 * 1024 * 1024,
    this.p2pEnabled: true,
    this.downloadTimeout: const Duration(seconds: 10),
    this.dcDownloadTimeout: const Duration(seconds: 4),
    this.tag: "flutter",
    this.localPort: 52019,
    this.maxPeerConnections: 10,
    this.useHttpRange: true,
    this.channelIdPrefix,
  });

  P2pConfig.byDefault() : this();

  Map get toMap => {
        'logLevel': logLevel.index,
        'webRTCConfig': webRTCConfig,
        'wsSignalerAddr': wsSignalerAddr,
        'announce': announce,
        'diskCacheLimit': diskCacheLimit,
        'memoryCacheLimit': memoryCacheLimit,
        'p2pEnabled': p2pEnabled,
        'downloadTimeout': downloadTimeout.inSeconds,
        'dcDownloadTimeout': dcDownloadTimeout.inSeconds,
        'tag': tag,
        'localPort': localPort,
        'maxPeerConnections': maxPeerConnections,
        'useHttpRange': useHttpRange,
        'channelIdPrefix': channelIdPrefix,
      };
}
