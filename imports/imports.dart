import 'dart:ui';
import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/services.dart';

import 'package:flame/flame.dart';
import 'package:flame/text_config.dart';
import 'package:flame/animation.dart' as animation;
import 'package:flame/images.dart';
import 'package:flame/position.dart'; 
import 'package:flame/game.dart';
import 'package:flame/components/tiled_component.dart';
import 'package:tiled/tiled.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_admob/firebase_admob.dart';


