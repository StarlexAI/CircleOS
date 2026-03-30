qt_add_executable(circleos-weather main.cpp)
qt_add_qml_module(circleos-weather URI CircleOS.Weather VERSION 1.0 QML_FILES qml/main.qml)
target_link_libraries(circleos-weather PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Network circleos-core)
install(TARGETS circleos-weather RUNTIME DESTINATION bin)
