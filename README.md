# GameCube/Wii Docker Development Environment

Docker images for GameCube/Wii homebrew development. These images are based on the official [devkitpro/devkitppc](https://hub.docker.com/r/devkitpro/devkitppc) image with additional tools and optimizations.

## Available Images

- **`webhdx/devkitppc`** - Based on devkitpro/devkitppc, adds ccache support for faster project builds
- **`webhdx/devkitppc-libogc2`** - Additionally installs libogc2 (recommended image for new homebrew projects)
- **`webhdx/swiss-gc`** - Contains additional tools required for building Swiss

## Image Versioning

Images are automatically built every week on Monday.

- **`latest`** - Always points to the most recent build
- **CalVer tags** - Date-based versioning using format `YYYYMMDD` (e.g., `20250531`)

## Building Images

```bash
docker build -f Dockerfile.devkitppc -t webhdx/devkitppc:latest .
docker build -f Dockerfile.devkitppc-libogc2 -t webhdx/devkitppc-libogc2:latest .
docker build -f Dockerfile.swiss-gc -t webhdx/devkitppc-swiss-gc:latest .
```

## Usage

### Shell Aliases (Recommended)

Add these aliases to your shell configuration for convenient usage:

```bash
# For libogc development
alias mmake='docker run --rm -it -v "$(pwd):/src" webhdx/devkitppc'

# For libogc2 development
alias mmake='docker run --rm -it -v "$(pwd):/src" webhdx/devkitppc-libogc2'

# For Swiss development
alias swissmake='docker run --rm -it -v "$(pwd):/src" webhdx/devkitppc-libogc2'
```

### Basic Usage

Inside your project directory (where `Makefile` is located), run command alias:

```bash
mmake       # makes default target
mmake clean # makes target named "clean" 
```

### Direct Docker Usage

```bash
# One-time build, runs make with default target
docker run --rm -v "$(pwd):/src" webhdx/devkitppc-libogc2

# Interactive development
docker run --rm -it -v "$(pwd):/src" webhdx/devkitppc-libogc2 -s bash
```

## ccache Support

All images include ccache for faster compilation. It's disabled by default. Control it with the `USE_CCACHE` environment variable:

```bash
# Enable ccache (recommended)
docker run --rm -v "$(pwd):/src" -e USE_CCACHE=1 webhdx/devkitppc-libogc2
```

When enabled, ccache stores compilation cache in `.ccache/` directory and displays build statistics after compilation.

## Acknowledgements

Based on:
- [devkitPro Docker](https://github.com/devkitPro/docker)
- [mmake](https://github.com/nachoparker/mmake)
