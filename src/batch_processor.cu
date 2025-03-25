#include <opencv2/opencv.hpp>
#include <cuda_runtime.h>
#include <stdio.h>
#include <filesystem>

namespace fs = std::filesystem;

#define THREADS_PER_BLOCK 256

// CUDA kernel simple: invertir colores
__global__ void invertColors(unsigned char* d_img, int size) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < size) {
        d_img[idx] = 255 - d_img[idx];
    }
}

void processImage(const std::string& input_path, const std::string& output_path) {
cv::Mat img = cv::imread(input_path, cv::IMREAD_COLOR);
    if (img.empty()) {
        printf("No se pudo leer la imagen %s\n", input_path.c_str());
        return;
    }

    int size = img.rows * img.cols;
    unsigned char* d_img;

    cudaMalloc(&d_img, size);
    cudaMemcpy(d_img, img.data, size, cudaMemcpyHostToDevice);

    int blocks = (size + THREADS_PER_BLOCK - 1) / THREADS_PER_BLOCK;
    invertColors<<<blocks, THREADS_PER_BLOCK>>>(d_img, size);
    cudaMemcpy(img.data, d_img, size, cudaMemcpyDeviceToHost);

    cudaFree(d_img);

    cv::imwrite(output_path, img);
    printf("Procesada: %s -> %s\n", input_path.c_str(), output_path.c_str());
}

int main() {
    std::string input_dir = "data/";
    std::string output_dir = "output/";

    for (const auto& entry : fs::directory_iterator(input_dir)) {
        if (entry.is_regular_file()) {
            std::string filename = entry.path().filename().string();
            std::string input_path = input_dir + filename;
            
            // Convertir salida a PNG
            std::string output_name = entry.path().stem().string() + ".png";
            std::string output_path = output_dir + output_name;
            
            processImage(input_path, output_path);
        }
    }

    return 0;
}

