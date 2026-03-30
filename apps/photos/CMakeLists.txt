qt_add_executable(circleos-photos main.cpp)
qt_add_qml_module(circleos-photos URI CircleOS.Photos VERSION 1.0 QML_FILES qml/main.qml)
target_link_libraries(circleos-photos PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick circleos-core)
install(TARGETS circleos-photos RUNTIME DESTINATION bin)
