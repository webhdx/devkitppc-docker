# DevkitPPC Docker Images

Docker images for Wii/GameCube homebrew development. My images are based on [devkitpro/devkitppc](https://hub.docker.com/r/devkitpro/devkitppc) image with the addition of cccache. 

* `webhdx/devkitppc-libogc2`, it comes with libogc2 compiled in. Great for developing [iplboot](https://github.com/redolution/iplboot) or Swiss although it requires installing additional dependencies.

All images are currently only compiled for arm64 architecture. In the future I plan to move updating the images to CI and also enable cross compilation for x86 arch.

## How to use?

Pull the image:
```bash
docker pull webhdx/devkitppc-libogc2
```

Add below aliases to your shell for convenience:
```bash
alias gcrunmake='docker run --rm -d -v "$(pwd):/src" --entrypoint /bg.sh -t --name devkitppc-libogc2 webhdx/devkitppc-libogc2'
alias gcmake='docker exec -t devkitppc-libogc2 /run.sh'
```

Spin up the container:
```bash
gcrunmake
```

Now you can compile the project by running below command in the main project directory:
```bash
gcmake install # or whatever target from Makefile you'd like to run
```

## Acknowledgements
Based on:
* https://github.com/devkitPro/docker
* https://github.com/nachoparker/mmake