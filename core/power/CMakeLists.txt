add_library(circleos-power SHARED
    PowerManager.cpp
)

target_link_libraries(circleos-power
    Qt6::Core
    Qt6::DBus
    ${SYSTEMD_LIBRARIES}
)

install(TARGETS circleos-power LIBRARY DESTINATION lib)
