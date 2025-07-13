#!/bin/bash

APP_NAME="dart_cli_chatai"
ENTRY="bin/dart_cli_chatai.dart"
BUILD_DIR="build"

echo "🔨 Building $APP_NAME..."
mkdir -p $BUILD_DIR
dart compile exe $ENTRY -o $BUILD_DIR/$APP_NAME

if [ $? -eq 0 ]; then
  echo "✅ Build success! Run with:"
  echo "./$BUILD_DIR/$APP_NAME"
else
  echo "❌ Build failed."
fi
