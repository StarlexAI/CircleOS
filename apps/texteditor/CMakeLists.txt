qt_add_executable(circleos-texteditor main.cpp)
qt_add_qml_module(circleos-texteditor URI CircleOS.TextEditor VERSION 1.0 QML_FILES qml/main.qml)
target_link_libraries(circleos-texteditor PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick circleos-core)
install(TARGETS circleos-texteditor RUNTIME DESTINATION bin)
