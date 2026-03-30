qt_add_executable(circleos-settings
    main.cpp
)

qt_add_qml_module(circleos-settings
    URI CircleOS.Settings
    VERSION 1.0
    QML_FILES
        qml/main.qml
)

target_link_libraries(circleos-settings PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    circleos-core
)

install(TARGETS circleos-settings RUNTIME DESTINATION bin)
