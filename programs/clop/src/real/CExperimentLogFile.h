/////////////////////////////////////////////////////////////////////////////
//
// CExperimentLogFile.h
//
// Rémi Coulom
//
// May, 2010
//
/////////////////////////////////////////////////////////////////////////////
#ifndef CExperimentLogFile_Declared
#define CExperimentLogFile_Declared

#include <QObject>
#include <fstream>
#include <string>

class CExperimentLogFile: public QObject
{
 Q_OBJECT

 private: ///////////////////////////////////////////////////////////////////
  std::ofstream ofs;
  void WriteMessage(const std::string &sMessage);

 public: ////////////////////////////////////////////////////////////////////
  CExperimentLogFile(const char *szFileName);

 public slots: //////////////////////////////////////////////////////////////
  void OnMessage(std::string sMessage);
};

#endif // CExperimentLogFile_Declared