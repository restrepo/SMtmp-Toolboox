modname = SMHighScale  # as an example  
PreDef = -DGENERATIONMIXING -DONLYDOUBLE
# setting various paths  
InDir = ../include
Mdir = ${InDir}
name = ../lib/libSPhenoSMHighScale.a
 
# check if SARAH module and SPheno are compatibel  
minV=330.00 
cVersion =$(shell expr $(version) \>= $(minV))
#  
# options for various compilers  
#  
# Default Compiler  
F90=gfortran
comp= -c -O -module ${Mdir} -I${InDir}  
LFlagsB= -O  
# Intels ifort,debug modus  
ifeq (${F90},ifortg)  
F90=ifort  
comp= -c -g -module ${Mdir} -I${InDir}  
LFlagsB= -g  
endif  
# gfortran  
ifeq (${F90},gfortran)  
comp= -c -g -ffree-line-length-none -J${Mdir} -I${InDir}  
LFlagsB= -g  
endif  
# g95  
ifeq (${F90},g95)  
comp= -c -O -fmod=${Mdir} -I${InDir}  
LFlagsB= -O  
endif  
# Lahey F95 compiler  
ifeq (${F90},lf95)  
comp=-c -O -M ${Mdir} -I${InDir}  
LFlagsB=-O  
endif  
# NAG f95/2003  
ifeq (${F90},nagfor)  
comp= -c -O -mdir ${Mdir} -I${InDir}  
LFlagsB= -O -DONLYDOUBLE -mdir ${MDir} -I${InDir}  
endif   
.SUFFIXES : .o .ps .f90 .F90 .a 
bin/SPhenoSMHighScale:
ifeq (${cVersion},1)
	 cd ../src ; ${MAKE} F90=${F90} 
	 ${MAKE} F90=${F90} ${name} 
	 ${MAKE} F90=${F90} SPhenoSMHighScale.o 
	 ${F90} -o SPhenoSMHighScale ${LFlagsB} SPhenoSMHighScale.o ../lib/libSPhenoSMHighScale.a ../lib/libSPheno.a
	 mv SPhenoSMHighScale ../bin
	 rm SPhenoSMHighScale.o  
${name}:  ${name}(Model_Data_SMHighScale.o)  \
 ${name}(RGEs_SMHighScale.o)   \
 ${name}(Couplings_SMHighScale.o) ${name}(SusyMasses_SMHighScale.o) ${name}(TadpoleEquations_SMHighScale.o) \
 ${name}(LoopCouplings_SMHighScale.o) ${name}(CouplingsForDecays_SMHighScale.o) \
 ${name}(SusyDecays_SMHighScale.o) \
 ${name}(Fu.o)  ${name}(Fe.o)  ${name}(Fd.o)  \
 ${name}(BranchingRatios_SMHighScale.o) ${name}(LoopMasses_SMHighScale.o) \
 ${name}(HiggsCS_SMHighScale.o) ${name}(RunSM_SMHighScale.o) \
 ${name}(LowEnergy_SMHighScale.o) \
${name}(FlavorKit_LFV_SMHighScale.o) ${name}(FlavorKit_QFV_SMHighScale.o) ${name}(FlavorKit_Observables_SMHighScale.o)\
 ${name}(SugraRuns_SMHighScale.o)  ${name}(InputOutput_SMHighScale.o) 
else 
	 @echo -------------------------------------------------------------------  
	 @echo ERROR:  
	 @echo The installed SPheno is version not compatibel with this module 
	 @echo Please, upgrade at least to SPheno version 3.3.0.  
	 @echo The current SPheno version can be downloaded from 
	 @echo http://www.hepforge.org/downloads/spheno 
	 @echo ------------------------------------------------------------------- 
endif 
clean: 
	 rm -f *.o *~ */*.o */*~
cleanall: 
	 rm -f bin/SPheno3 lib/*.a *~ */*.o */*~ include/*
#
# Suffix rules
#
.f90.a:
	 ${F90} ${comp} $< 
	 ar -ruc $@ $*.o
	 rm -f $*.o
.F90.a:
	 ${F90} ${comp} ${PreDef} $< 
	 ar -ruc $@ $*.o
	 rm -f $*.o
.f90.o:
	 ${F90} ${comp} $<
.f90.ps:
	 a2ps -o $*.ps $<
.h.ps:
	 a2ps -o $*.ps $<
