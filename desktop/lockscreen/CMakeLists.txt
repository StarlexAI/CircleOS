qt_add_executable(circleos-lockscreen
    main.cpp
)

qt_add_qml_module(circleos-lockscreen
    URI CircleOS.LockScreen
    VERSION 1.0
    QML_FILES
        qml/LockScreen.qml
)

target_link_libraries(circleos-lockscreen PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    circleos-core
)

install(TARGETS circleos-lockscreen RUNTIME DESTINATION bin)
