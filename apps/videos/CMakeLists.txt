qt_add_executable(circleos-videos main.cpp)
qt_add_qml_module(circleos-videos URI CircleOS.Videos VERSION 1.0 QML_FILES qml/main.qml)
target_link_libraries(circleos-videos PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick circleos-core)
install(TARGETS circleos-videos RUNTIME DESTINATION bin)
