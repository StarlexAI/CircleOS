qt_add_executable(circleos-terminal
    main.cpp
)

qt_add_qml_module(circleos-terminal
    URI CircleOS.Terminal
    VERSION 1.0
    QML_FILES
        qml/main.qml
)

target_link_libraries(circleos-terminal PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    circleos-core
)

install(TARGETS circleos-terminal RUNTIME DESTINATION bin)
