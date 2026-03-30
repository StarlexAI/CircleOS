add_subdirectory(session)
add_subdirectory(settings)
add_subdirectory(power)
add_subdirectory(audio)
add_subdirectory(network)
add_subdirectory(bluetooth)
add_subdirectory(display)
add_subdirectory(notifications)
add_subdirectory(input)

# Core library
add_library(circleos-core SHARED
    include/Application.h
    include/SystemInfo.h
    include/DBusService.h
    include/ConfigManager.h
    src/Application.cpp
    src/SystemInfo.cpp
    src/DBusService.cpp
    src/ConfigManager.cpp
)

set_target_properties(circleos-core PROPERTIES
    AUTOMOC ON
)

target_include_directories(circleos-core
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)

target_link_libraries(circleos-core
    Qt6::Core
    Qt6::DBus
    ${SYSTEMD_LIBRARIES}
    ${DBUS_LIBRARIES}
)

install(TARGETS circleos-core LIBRARY DESTINATION lib)
install(DIRECTORY include/ DESTINATION include/circleos)
