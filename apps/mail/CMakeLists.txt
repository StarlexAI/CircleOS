qt_add_executable(circleos-mail main.cpp)
qt_add_qml_module(circleos-mail URI CircleOS.Mail VERSION 1.0 QML_FILES qml/main.qml)
target_link_libraries(circleos-mail PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Network circleos-core)
install(TARGETS circleos-mail RUNTIME DESTINATION bin)
