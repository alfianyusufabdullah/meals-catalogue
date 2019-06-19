#!/usr/bin/env bash

flutter test
flutter driver --flavor stage_release --target=test_driver/app.dart