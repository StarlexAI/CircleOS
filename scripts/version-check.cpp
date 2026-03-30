#include <iostream>
#include <string>

#ifndef CIRCLEOS_VERSION
#define CIRCLEOS_VERSION "1.0.0"
#endif

int main() {
    std::cout << "🔵 CircleOS Build System Check\n";
    std::cout << "==============================\n\n";
    std::cout << "Version: " << CIRCLEOS_VERSION << "\n";
    std::cout << "Build system: CMake\n";
    std::cout << "C++ Standard: C++20\n\n";
    std::cout << "✅ Build system is working correctly!\n\n";
    std::cout << "Next steps:\n";
    std::cout << "1. Install Qt6 dependencies:\n";
    std::cout << "   ./scripts/setup-dev.sh\n\n";
    std::cout << "2. Build full project:\n";
    std::cout << "   ./build.sh\n\n";
    std::cout << "3. Test in QEMU:\n";
    std::cout << "   ./scripts/run-qemu.sh\n\n";
    
    return 0;
}
