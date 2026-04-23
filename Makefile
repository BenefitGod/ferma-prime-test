# Компилятор и флаги
CXX = g++
CXXFLAGS = -Wall -Wextra -O2 -std=c++11 -g
LDFLAGS = 
TARGET = ferma-test
SRCDIR = src
INCDIR = include
TESTDIR = tests
OBJDIR = obj

# Исходные файлы
SOURCES = $(wildcard $(SRCDIR)/*.cpp)
MAIN_SRC = $(SRCDIR)/main.cpp
LIB_SOURCES = $(filter-out $(MAIN_SRC), $(SOURCES))

# Объектные файлы
ALL_OBJECTS = $(SOURCES:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)
LIB_OBJECTS = $(LIB_SOURCES:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)

# Тестовые файлы
TEST_SOURCES = $(wildcard $(TESTDIR)/*.cpp)
TEST_OBJECTS = $(TEST_SOURCES:$(TESTDIR)/%.cpp=$(OBJDIR)/%.o)
TEST_TARGET = run-tests

# Определение ОС
ifeq ($(OS),Windows_NT)
    RM = rm -f
    TARGET := $(TARGET).exe
    TEST_TARGET := $(TEST_TARGET).exe
    MKDIR = mkdir -p $(OBJDIR)
    RMDIR = rm -rf $(OBJDIR)
else
    RM = rm -f
    MKDIR = mkdir -p $(OBJDIR)
    RMDIR = rm -rf $(OBJDIR)
endif

# Цель по умолчанию
all: $(OBJDIR) $(TARGET)

# Создание директории для объектных файлов
$(OBJDIR):
	$(MKDIR)

# Сборка исполняемого файла
$(TARGET): $(ALL_OBJECTS)
	$(CXX) $(ALL_OBJECTS) -o $(TARGET) $(LDFLAGS)
	@echo "Build complete: $(TARGET)"

# Компиляция .cpp в .o
$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
	$(CXX) $(CXXFLAGS) -I$(INCDIR) -MMD -MP -c $< -o $@

# Компиляция тестовых файлов
$(OBJDIR)/%.o: $(TESTDIR)/%.cpp
	$(CXX) $(CXXFLAGS) -I$(INCDIR) -c $< -o $@

# Сборка тестов
tests: $(OBJDIR) $(TEST_TARGET)

$(TEST_TARGET): $(LIB_OBJECTS) $(TEST_OBJECTS)
	$(CXX) $(LIB_OBJECTS) $(TEST_OBJECTS) -o $(TEST_TARGET) $(LDFLAGS)
	@echo "Tests build complete: $(TEST_TARGET)"

# Запуск тестов
test: tests
	./$(TEST_TARGET)

# Запуск программы
run: $(TARGET)
	./$(TARGET)

# Запуск с аргументом
run-test: $(TARGET)
	./$(TARGET) 17
	./$(TARGET) 97
	./$(TARGET) 100

# Проверка кода
check:
	$(CXX) $(CXXFLAGS) -I$(INCDIR) -fsyntax-only $(SRCDIR)/*.cpp
	$(CXX) $(CXXFLAGS) -I$(INCDIR) -fsyntax-only $(TESTDIR)/*.cpp

# Очистка
clean:
	$(RM) $(TARGET)
	$(RM) $(TEST_TARGET)
	$(RMDIR)

# Полная пересборка
rebuild: clean all

# Помощь
help:
	@echo "Available targets:"
	@echo "  all       - Build the program (default)"
	@echo "  tests     - Build tests"
	@echo "  test      - Build and run tests"
	@echo "  clean     - Remove built files"
	@echo "  rebuild   - Clean and rebuild"
	@echo "  run       - Build and run the program"
	@echo "  run-test  - Run with test numbers"
	@echo "  check     - Check syntax only"
	@echo "  help      - Show this help"

.PHONY: all clean rebuild run run-test test tests check help