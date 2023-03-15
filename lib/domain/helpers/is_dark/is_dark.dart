import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

bool isDarkHelper() =>
    SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
