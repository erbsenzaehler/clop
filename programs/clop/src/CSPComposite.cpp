/////////////////////////////////////////////////////////////////////////////
//
// CSPComposite.cpp
//
// Rémi Coulom
//
// May, 2009
//
/////////////////////////////////////////////////////////////////////////////
#include "CSPComposite.h"
#include "CRegression.h"

/////////////////////////////////////////////////////////////////////////////
// sp1 at the beginning, sp2 in the end
/////////////////////////////////////////////////////////////////////////////
const double *CSPComposite::NextSample(int i)
{
 if (reg.GetCount(COutcome::Loss) < MinSamples ||
     reg.GetCount(COutcome::Win)  < MinSamples)
  return sp1.NextSample(i);
 else
  return sp2.NextSample(i);
}