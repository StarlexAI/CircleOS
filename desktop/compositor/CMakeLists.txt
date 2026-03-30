find_package(Qt6 REQUIRED COMPONENTS WaylandCompositor)

qt_add_executable(circleos-compositor
    main.cpp
)

target_link_libraries(circleos-compositor PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::WaylandCompositor
    circleos-core
)

install(TARGETS circleos-compositor RUNTIME DESTINATION bin)
