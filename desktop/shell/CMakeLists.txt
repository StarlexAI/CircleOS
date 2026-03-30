set(SHELL_SOURCES
    main.cpp
)

set(SHELL_QML_FILES
    qml/main.qml
    qml/components/TopPanel.qml
    qml/components/Dock.qml
    qml/components/AppLauncher.qml
    qml/components/NotificationCenter.qml
    qml/components/CircularButton.qml
    qml/components/DockIcon.qml
    qml/components/DesktopIcon.qml
    qml/components/AppIcon.qml
)

qt_add_executable(circleos-shell
    ${SHELL_SOURCES}
)

qt_add_qml_module(circleos-shell
    URI CircleOS.Shell
    VERSION 1.0
    QML_FILES ${SHELL_QML_FILES}
    RESOURCES
        resources/qml.qrc
)

target_link_libraries(circleos-shell PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::DBus
    circleos-core
)

install(TARGETS circleos-shell RUNTIME DESTINATION bin)
