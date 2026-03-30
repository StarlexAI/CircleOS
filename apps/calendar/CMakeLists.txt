qt_add_executable(circleos-calendar main.cpp)
qt_add_qml_module(circleos-calendar URI CircleOS.Calendar VERSION 1.0 QML_FILES qml/main.qml)
target_link_libraries(circleos-calendar PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick circleos-core)
install(TARGETS circleos-calendar RUNTIME DESTINATION bin)
