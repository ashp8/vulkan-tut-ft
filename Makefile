# Compiler and flags
CFLAGS = -std=c++17 -O2
LDFLAGS = -lglfw -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi -lvulkan -lglm

# Directories
SRC_DIR = src
INC_DIR = include
BUILD_DIR = build

# Vulkan SDK paths
INC = -I${VULKAN_SDK}/include -I$(INC_DIR)
LIB = -L${VULKAN_SDK}/lib/
# Source and object files
SRCS = $(wildcard $(SRC_DIR)/*.cpp)
OBJS = $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(SRCS))

# Target executable
TARGET = VulkanTest

# Build the target
$(TARGET): $(OBJS)
	g++ $(CFLAGS) -o $@ $(OBJS) $(LIB) $(LDFLAGS)

# Rule to compile source files into object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	mkdir -p $(BUILD_DIR)
	g++ $(CFLAGS) $(INC) -c $< -o $@

# Phony targets
.PHONY: test clean

# Test target
test: $(TARGET)
	./$(TARGET)

# Clean target
clean:
	rm -f $(BUILD_DIR)/*.o $(TARGET)
