#include <QCoreApplication>
#include <QDebug>
#include <iostream>

int main(int argc, char *argv[]) {
    QCoreApplication app(argc, argv);
    
    std::cout << "✅ Qt6 is working!" << std::endl;
    std::cout << "Qt version: " << qVersion() << std::endl;
    
    qDebug() << "QDebug also works!";
    
    return 0;
}
