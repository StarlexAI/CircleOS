add_library(circleos-input SHARED InputManager.cpp)
target_link_libraries(circleos-input Qt6::Core Qt6::DBus Qt6::Gui)
install(TARGETS circleos-input LIBRARY DESTINATION lib)
