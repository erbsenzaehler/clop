////////////////////////////////////////////////////////////////////////////
//
// mybeep.cpp
//
// Remi Coulom
//
// September, 1998
//
////////////////////////////////////////////////////////////////////////////
#include "mybeep.h"

#if defined(BEEP_WIN32) ////////////////////////////////////////////////////

#include <windows.h>

void mybeep()
{
 MessageBeep(MB_ICONASTERISK);
}

#else //////////////////////////////////////////////////////////////////////

#include <iostream>

void mybeep()
{
 (std::cerr << '\7').flush();
}

#endif