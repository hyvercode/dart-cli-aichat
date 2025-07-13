APP_NAME = dart_cli_chatai
ENTRY = bin/dart_cli_chatai.dart
BUILD_DIR = build

.PHONY: build run clean

build:
	@mkdir -p $(BUILD_DIR)
	dart compile exe $(ENTRY) -o $(BUILD_DIR)/$(APP_NAME)

run:
	dart run $(ENTRY)

run-exe: build
	./$(BUILD_DIR)/$(APP_NAME)

clean:
	rm -rf $(BUILD_DIR)