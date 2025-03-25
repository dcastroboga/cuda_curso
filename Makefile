TARGET = batch_processor
SRC = src/batch_processor.cu

all:
	nvcc -o $(TARGET) $(SRC) `pkg-config --cflags --libs opencv4` -std=c++17

clean:
	rm -f $(TARGET)
