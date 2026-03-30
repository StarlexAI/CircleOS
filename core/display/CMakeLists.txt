add_library(circleos-display SHARED DisplayManager.cpp)
target_link_libraries(circleos-display Qt6::Core Qt6::DBus Qt6::Gui)
install(TARGETS circleos-display LIBRARY DESTINATION lib)
