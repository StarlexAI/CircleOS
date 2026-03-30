add_library(circleos-settings-backend SHARED
    SettingsBackend.cpp
)

target_link_libraries(circleos-settings-backend
    Qt6::Core
    Qt6::DBus
)

install(TARGETS circleos-settings-backend LIBRARY DESTINATION lib)
