qt_add_executable(circleos-music main.cpp)
qt_add_qml_module(circleos-music URI CircleOS.Music VERSION 1.0 QML_FILES qml/main.qml)
target_link_libraries(circleos-music PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick circleos-core)
install(TARGETS circleos-music RUNTIME DESTINATION bin)
