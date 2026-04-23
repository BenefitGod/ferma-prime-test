CXX = g++
CXXFLAGS = -Wall -O2 -std=c++11
INCLUDES = -Iinclude
SRC_DIR = src
OBJ_DIR = obj
TARGET = ferma-test

# Найти все .cpp файлы в src
SOURCES = $(wildcard $(SRC_DIR)/*.cpp)
OBJECTS = $(SOURCES:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

.PHONY: all clean test

# Сборка
all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CXX) $(CXXFLAGS) -o $@ $^

# Компиляция .cpp в .o
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

# Очистка
clean:
	rm -rf $(OBJ_DIR) $(TARGET)

# Тесты (если есть)
test: $(TARGET)
	@echo "Running tests..."
	@if [ -d "tests" ]; then \
		for test in tests/*.cpp; do \
			echo "Compiling $$test..."; \
			g++ $(CXXFLAGS) $(INCLUDES) $$test -o test_runner; \
			./test_runner; \
		done \
	fi