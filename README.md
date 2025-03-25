

## Project Description

This project demonstrates efficient batch image processing using **CUDA** and **OpenCV**. The main objective is to process a large number of images (hundreds of small images or dozens of large ones) by leveraging GPU parallelism.

**Key functionality:**

- Loads multiple images from a specified directory (`data/`).
- Applies a simple CUDA kernel to invert the pixel values (color inversion) of each image.
- Saves processed images into an output directory (`output/`).
- All processing is performed inside a **Docker container** with **NVIDIA GPU acceleration**.

---

## Repository Structure

```
├── Dockerfile                 # Docker environment setup
├── Makefile                   # Build instructions using NVCC
├── run.ps1                    # PowerShell script for Windows users to execute the container
├── src/
│   └── batch_processor.cu     # CUDA C++ source code
├── data/                      # Input image folder (TIFF, PNG, JPG supported)
├── output/                    # Output processed images
└── README.md                  # This documentation
```

---

## Technologies & Libraries Used

- **CUDA 12.x**
- **OpenCV 4.x**
- **C++17 Standard**
- **Docker (NVIDIA runtime)**
- **Windows PowerShell for execution convenience**

---

## Instructions for Building & Running

###  Build Docker Image:

```bash
docker build -t cuda-npp-project .
```

---

###  Run Processing (Windows PowerShell):

```powershell
docker run --rm -it --gpus all -v ${PWD}\data:/workspace/data -v ${PWD}\output:/workspace/output cuda-npp-project
./batch_processor
```

This command automatically mounts local `data/` and `output/` directories into the container, making input/output handling seamless and bi-directional.

---

## How It Works

1. **Reads all images** from `/data/` folder using **OpenCV**.
2. Transfers each image to **GPU memory**.
3. Applies a CUDA kernel to **invert the colors**:
    ```
    pixel = 255 - pixel
    ```
4. Saves processed images to `/output/`.

---

## Dataset Examples

To test the project, you can use images from:

- [USC SIPI Image Database](https://sipi.usc.edu/database/database.php)
- [UCI Machine Learning Repository](https://archive-beta.ics.uci.edu)

Place downloaded images in the `/data/` directory.

---

## Proof of Execution

Included in the repository:

- Sample input images in `/data/`.
- Processed output images in `/output/`.
- Terminal logs demonstrating successful execution inside Docker with GPU support.

---

## Possible Extensions

- Implement additional CUDA kernels (e.g., Gaussian blur, edge detection).
- Add support for other signal types (e.g., audio CSVs).
- Optimize by using CUDA streams for concurrent execution.

---

## License

This project is for educational purposes and aligns with the course requirements.

---

