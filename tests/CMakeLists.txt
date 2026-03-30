enable_testing()

find_package(Qt6 REQUIRED COMPONENTS Test)

# Core tests
add_executable(test_core test_core.cpp)
target_link_libraries(test_core
    Qt6::Test
    Qt6::Core
    circleos-core
)
add_test(NAME CoreTests COMMAND test_core)

# Add more test executables here
