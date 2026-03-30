add_library(circleos-network SHARED
    NetworkManager.cpp
)

target_link_libraries(circleos-network
    Qt6::Core
    Qt6::DBus
    Qt6::Network
)

install(TARGETS circleos-network LIBRARY DESTINATION lib)
