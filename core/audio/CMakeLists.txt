add_library(circleos-audio SHARED
    AudioManager.cpp
)

target_link_libraries(circleos-audio
    Qt6::Core
    Qt6::DBus
)

install(TARGETS circleos-audio LIBRARY DESTINATION lib)
