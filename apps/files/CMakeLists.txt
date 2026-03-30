qt_add_executable(circleos-files
    main.cpp
)

qt_add_qml_module(circleos-files
    URI CircleOS.Files
    VERSION 1.0
    QML_FILES
        qml/main.qml
)

target_link_libraries(circleos-files PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    circleos-core
)

install(TARGETS circleos-files RUNTIME DESTINATION bin)
