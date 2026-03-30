qt_add_executable(circleos-store main.cpp)
qt_add_qml_module(circleos-store URI CircleOS.Store VERSION 1.0 QML_FILES qml/main.qml)
target_link_libraries(circleos-store PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Network circleos-core)
install(TARGETS circleos-store RUNTIME DESTINATION bin)
