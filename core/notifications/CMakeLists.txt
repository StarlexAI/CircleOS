add_library(circleos-notifications SHARED NotificationManager.cpp)
target_link_libraries(circleos-notifications Qt6::Core Qt6::DBus)
install(TARGETS circleos-notifications LIBRARY DESTINATION lib)
