# Простой Makefile для Windows
CXX = g++
CXXFLAGS = -Wall -Wextra -O2 -std=c++11
TARGET = ferma-test.exe
SRCDIR = src
INCDIR = include
OBJDIR = obj

# Все исходные файлы
SOURCES = $(wildcard $(SRCDIR)/*.cpp)
OBJECTS = $(SOURCES:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)

# Цель по умолчанию
all: $(TARGET)

# Создание директории obj
$(OBJDIR):
	mkdir -p $(OBJDIR)

# Сборка исполняемого файла
$(TARGET): $(OBJDIR) $(OBJECTS)
	$(CXX) $(OBJECTS) -o $(TARGET)
	@echo "Build complete: $(TARGET)"

# Компиляция .cpp в .o
$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
	$(CXX) $(CXXFLAGS) -I$(INCDIR) -c $< -o $@

# Запуск программы
run: $(TARGET)
	./$(TARGET)

# Запуск с тестовыми числами
run-test: $(TARGET)
	@echo "Testing number 17:"
	./$(TARGET) 17
	@echo ""
	@echo "Testing number 97:"
	./$(TARGET) 97
	@echo ""
	@echo "Testing number 100:"
	./$(TARGET) 100

# Очистка
clean:
	rm -f $(TARGET)
	rm -rf $(OBJDIR)

# Полная пересборка
rebuild: clean all

.PHONY: all run run-test clean rebuild