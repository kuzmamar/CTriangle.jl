using BinDeps

#Remove deps.jl before build.
isfile("deps.jl") && rm("deps.jl")

@BinDeps.setup
    deps = [lib = library_dependency("lib", aliases = ["triangle.so"], runtime = false, os = :Unix)]
    rootdir = BinDeps.depsdir(lib)
    srcdir = joinpath(rootdir, "src")
    prefix = joinpath(rootdir, "usr")
    libdir = joinpath(prefix, "lib")
    headerdir = joinpath(prefix, "include")
    libfile = joinpath(libdir, "triangle.so")
    provides(BinDeps.BuildProcess, (@build_steps begin
                FileRule(libfile, @build_steps begin
                    BinDeps.ChangeDirectory(srcdir)
                    `gcc -O -DLINUX -DANSI_DECLARATORS -fpic -DTRILIBRARY -o triangle.o -c triangle.c`
                    `gcc -shared -o triangle.so triangle.o`
                    `cp triangle.so $libdir`
                    `cp triangle.h $headerdir`
                    `rm triangle.so`
                    `rm triangle.o`
                end)
             end), lib)

@BinDeps.install Dict([(:lib, :_jl_libtriangle)])
