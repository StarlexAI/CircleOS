add_library(circleos-session SHARED
    SessionManager.cpp
)

target_link_libraries(circleos-session
    Qt6::Core
    Qt6::DBus
    ${SYSTEMD_LIBRARIES}
)

install(TARGETS circleos-session LIBRARY DESTINATION lib)
