qt_add_executable(circleos-browser main.cpp)
qt_add_qml_module(circleos-browser URI CircleOS.Browser VERSION 1.0 QML_FILES qml/main.qml)
target_link_libraries(circleos-browser PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Network circleos-core)
install(TARGETS circleos-browser RUNTIME DESTINATION bin)
