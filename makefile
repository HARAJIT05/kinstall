SCRIPT_NAME = kinstall.sh
INSTALL_DIR = /usr/local/bin
TARGET = kinstall

.PHONY: install uninstall

install:
	@echo "Installing $(SCRIPT_NAME) script..."
	@sudo cp $(SCRIPT_NAME) $(INSTALL_DIR)/$(TARGET)
	@sudo chmod +x $(INSTALL_DIR)/$(TARGET)
	@echo "$(TARGET) script installed successfully."

uninstall:
	@echo "Uninstalling $(TARGET) script..."
	@sudo rm -f $(INSTALL_DIR)/$(TARGET)
	@echo "$(TARGET) script uninstalled successfully."
