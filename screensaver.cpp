#include <stdlib.h>
#include <string.h>
#include <fstream>
#include <iostream>

using namespace std;

string settings[3];

void getConfig () {

    // TODO config file path
    ifstream inConfig ("screensaver-config");
    int i = -1;

    std::string sLine;
    while( std::getline(inConfig, sLine ) ) {
        std::cout<<sLine<<'\n';
        settings[++i] = sLine;
    }

    inConfig.close();
}

void fadeIn () {
    system((char*)settings[0].c_str());
}

void fadeOut () {
    system((char*)settings[1].c_str());
}

int main(void) {
    getConfig();
    fadeOut();
    return 0;
}
