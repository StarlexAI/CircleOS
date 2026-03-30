add_library(circleos-bluetooth SHARED BluetoothManager.cpp)
target_link_libraries(circleos-bluetooth Qt6::Core Qt6::DBus)
install(TARGETS circleos-bluetooth LIBRARY DESTINATION lib)
