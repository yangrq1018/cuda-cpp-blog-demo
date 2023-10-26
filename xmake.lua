add_includedirs("include")

target("gpu")
    set_kind("binary")
    add_files("src/add.cu", "src/main.cpp")
target_end()

target("cpu")
    set_kind("binary")
    add_files("src/add.cpp", "src/main.cpp")
target_end()

target("unified_mem")
    set_kind("binary")
    add_files("src/unified_mem.cu")
target_end()
