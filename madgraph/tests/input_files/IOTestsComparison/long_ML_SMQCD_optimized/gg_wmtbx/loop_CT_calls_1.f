      SUBROUTINE ML5_0_LOOP_CT_CALLS_1(P,NHEL,H,IC)
C     
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INTEGER NBORNAMPS
      PARAMETER (NBORNAMPS=8)
      INTEGER    NEXTERNAL
      PARAMETER (NEXTERNAL=5)
      INTEGER    NCOMB
      PARAMETER (NCOMB=48)
      INTEGER    NLOOPS, NLOOPGROUPS, NCTAMPS
      PARAMETER (NLOOPS=162, NLOOPGROUPS=77, NCTAMPS=252)
      INTEGER    NWAVEFUNCS,NLOOPWAVEFUNCS
      PARAMETER (NWAVEFUNCS=28,NLOOPWAVEFUNCS=300)
      INTEGER MAXLWFSIZE
      PARAMETER (MAXLWFSIZE=4)
      INTEGER LOOPMAXCOEFS, VERTEXMAXCOEFS
      PARAMETER (LOOPMAXCOEFS=70, VERTEXMAXCOEFS=5)
      REAL*8     ZERO
      PARAMETER (ZERO=0D0)
      REAL*16     MP__ZERO
      PARAMETER (MP__ZERO=0.0E0_16)
C     These are constants related to the split orders
      INTEGER    NSO, NSQUAREDSO, NAMPSO
      PARAMETER (NSO=0, NSQUAREDSO=0, NAMPSO=0)
C     
C     ARGUMENTS
C     
      REAL*8 P(0:3,NEXTERNAL)
      INTEGER NHEL(NEXTERNAL), IC(NEXTERNAL)
      INTEGER H
C     
C     LOCAL VARIABLES
C     
      INTEGER I,J,K
      COMPLEX*16 COEFS(MAXLWFSIZE,0:VERTEXMAXCOEFS-1,MAXLWFSIZE)

      LOGICAL DUMMYFALSE
      DATA DUMMYFALSE/.FALSE./
C     
C     GLOBAL VARIABLES
C     
      INCLUDE 'coupl.inc'
      INCLUDE 'mp_coupl.inc'

      INTEGER HELOFFSET
      INTEGER GOODHEL(NCOMB)
      LOGICAL GOODAMP(NSQUAREDSO,NLOOPGROUPS)
      COMMON/ML5_0_FILTERS/GOODAMP,GOODHEL,HELOFFSET

      LOGICAL CHECKPHASE
      LOGICAL HELDOUBLECHECKED
      COMMON/ML5_0_INIT/CHECKPHASE, HELDOUBLECHECKED

      INTEGER SQSO_TARGET
      COMMON/ML5_0_SOCHOICE/SQSO_TARGET

      LOGICAL UVCT_REQ_SO_DONE,MP_UVCT_REQ_SO_DONE,CT_REQ_SO_DONE
     $ ,MP_CT_REQ_SO_DONE,LOOP_REQ_SO_DONE,MP_LOOP_REQ_SO_DONE
     $ ,CTCALL_REQ_SO_DONE,FILTER_SO
      COMMON/ML5_0_SO_REQS/UVCT_REQ_SO_DONE,MP_UVCT_REQ_SO_DONE
     $ ,CT_REQ_SO_DONE,MP_CT_REQ_SO_DONE,LOOP_REQ_SO_DONE,MP_LOOP_REQ_S
     $ O_DONE,CTCALL_REQ_SO_DONE,FILTER_SO

      INTEGER I_SO
      COMMON/ML5_0_I_SO/I_SO
      INTEGER I_LIB
      COMMON/ML5_0_I_LIB/I_LIB

      COMPLEX*16 AMP(NBORNAMPS)
      COMMON/ML5_0_AMPS/AMP
      COMPLEX*16 W(20,NWAVEFUNCS)
      COMMON/ML5_0_W/W

      COMPLEX*16 WL(MAXLWFSIZE,0:LOOPMAXCOEFS-1,MAXLWFSIZE,0:NLOOPWAVEF
     $ UNCS)
      COMPLEX*16 PL(0:3,0:NLOOPWAVEFUNCS)
      COMMON/ML5_0_WL/WL,PL

      COMPLEX*16 LOOPCOEFS(0:LOOPMAXCOEFS-1,NSQUAREDSO,NLOOPGROUPS)
      COMMON/ML5_0_LCOEFS/LOOPCOEFS

      COMPLEX*16 AMPL(3,NCTAMPS)
      COMMON/ML5_0_AMPL/AMPL

      COMPLEX*16 LOOPRES(3,NSQUAREDSO,NLOOPGROUPS)
      LOGICAL S(NSQUAREDSO,NLOOPGROUPS)
      COMMON/ML5_0_LOOPRES/LOOPRES,S
C     
C     ----------
C     BEGIN CODE
C     ----------

C     The target squared split order contribution is already reached
C      if true.
      IF (FILTER_SO.AND.CTCALL_REQ_SO_DONE) THEN
        GOTO 1001
      ENDIF

C     CutTools call for loop numbers 1,2,7,8,13,14,19,20,135,136,157,15
C     8,151,152,153,154,155,156
      CALL ML5_0_LOOP_2(6,13,DCMPLX(ZERO),DCMPLX(ZERO),2,I_SO,1)
C     CutTools call for loop numbers 3,4,5,6,9,10,11,12,15,16,17,18,21,
C     22,23,24,137,138,159,160,161,162
      CALL ML5_0_LOOP_3(1,2,13,DCMPLX(ZERO),DCMPLX(ZERO),DCMPLX(ZERO)
     $ ,3,I_SO,2)
C     CutTools call for loop numbers 25,47,73
      CALL ML5_0_LOOP_2(7,15,DCMPLX(ZERO),DCMPLX(MDL_MB),1,I_SO,3)
C     CutTools call for loop numbers 26,29
      CALL ML5_0_LOOP_2(6,13,DCMPLX(MDL_MB),DCMPLX(MDL_MB),2,I_SO,4)
C     CutTools call for loop numbers 27
      CALL ML5_0_LOOP_3(5,6,7,DCMPLX(MDL_MB),DCMPLX(MDL_MB),DCMPLX(ZERO
     $ ),2,I_SO,5)
C     CutTools call for loop numbers 28,87,88,89
      CALL ML5_0_LOOP_3(5,6,7,DCMPLX(ZERO),DCMPLX(ZERO),DCMPLX(MDL_MB)
     $ ,2,I_SO,6)
C     CutTools call for loop numbers 30,50,76
      CALL ML5_0_LOOP_3(3,4,15,DCMPLX(MDL_MT),DCMPLX(ZERO),DCMPLX(MDL_M
     $ B),2,I_SO,7)
C     CutTools call for loop numbers 31
      CALL ML5_0_LOOP_4(3,4,5,6,DCMPLX(MDL_MT),DCMPLX(ZERO),DCMPLX(MDL_
     $ MB),DCMPLX(MDL_MB),3,I_SO,8)
C     CutTools call for loop numbers 32
      CALL ML5_0_LOOP_4(3,5,4,6,DCMPLX(MDL_MB),DCMPLX(ZERO),DCMPLX(MDL_
     $ MT),DCMPLX(MDL_MT),3,I_SO,9)
C     CutTools call for loop numbers 33,39,69
      CALL ML5_0_LOOP_3(3,5,16,DCMPLX(MDL_MB),DCMPLX(ZERO),DCMPLX(MDL_M
     $ T),2,I_SO,10)
C     CutTools call for loop numbers 34,96,97,98
      CALL ML5_0_LOOP_4(3,4,6,5,DCMPLX(MDL_MT),DCMPLX(ZERO),DCMPLX(ZERO
     $ ),DCMPLX(MDL_MB),3,I_SO,11)
C     CutTools call for loop numbers 35,74
      CALL ML5_0_LOOP_2(10,17,DCMPLX(ZERO),DCMPLX(MDL_MB),1,I_SO,12)
C     CutTools call for loop numbers 36
      CALL ML5_0_LOOP_3(3,9,10,DCMPLX(MDL_MT),DCMPLX(ZERO),DCMPLX(MDL_M
     $ B),2,I_SO,13)
C     CutTools call for loop numbers 37,79
      CALL ML5_0_LOOP_3(2,5,17,DCMPLX(MDL_MB),DCMPLX(ZERO),DCMPLX(MDL_M
     $ B),2,I_SO,14)
C     CutTools call for loop numbers 38
      CALL ML5_0_LOOP_4(2,3,9,5,DCMPLX(MDL_MB),DCMPLX(MDL_MT)
     $ ,DCMPLX(ZERO),DCMPLX(MDL_MB),3,I_SO,15)
C     CutTools call for loop numbers 40
      CALL ML5_0_LOOP_4(2,5,3,9,DCMPLX(ZERO),DCMPLX(MDL_MB),DCMPLX(MDL_
     $ MT),DCMPLX(ZERO),3,I_SO,16)
C     CutTools call for loop numbers 41
      CALL ML5_0_LOOP_4(2,3,5,9,DCMPLX(MDL_MT),DCMPLX(MDL_MB)
     $ ,DCMPLX(ZERO),DCMPLX(MDL_MT),3,I_SO,17)
C     CutTools call for loop numbers 42,83
      CALL ML5_0_LOOP_3(2,5,17,DCMPLX(ZERO),DCMPLX(MDL_MB),DCMPLX(ZERO
     $ ),2,I_SO,18)
C     CutTools call for loop numbers 43,48
      CALL ML5_0_LOOP_2(11,19,DCMPLX(ZERO),DCMPLX(MDL_MB),1,I_SO,19)
C     CutTools call for loop numbers 44
      CALL ML5_0_LOOP_3(3,12,11,DCMPLX(MDL_MT),DCMPLX(ZERO),DCMPLX(MDL_
     $ MB),2,I_SO,20)
C     CutTools call for loop numbers 45
      CALL ML5_0_LOOP_3(2,7,11,DCMPLX(MDL_MB),DCMPLX(ZERO),DCMPLX(MDL_M
     $ B),2,I_SO,21)
C     CutTools call for loop numbers 46
      CALL ML5_0_LOOP_4(2,3,4,11,DCMPLX(MDL_MB),DCMPLX(MDL_MT)
     $ ,DCMPLX(ZERO),DCMPLX(MDL_MB),3,I_SO,22)
C     CutTools call for loop numbers 49
      CALL ML5_0_LOOP_3(2,7,11,DCMPLX(ZERO),DCMPLX(MDL_MB),DCMPLX(ZERO
     $ ),2,I_SO,23)
C     CutTools call for loop numbers 51
      CALL ML5_0_LOOP_4(2,3,11,4,DCMPLX(MDL_MT),DCMPLX(MDL_MB)
     $ ,DCMPLX(ZERO),DCMPLX(MDL_MT),3,I_SO,24)
C     CutTools call for loop numbers 52
      CALL ML5_0_LOOP_4(2,4,3,11,DCMPLX(ZERO),DCMPLX(MDL_MT),DCMPLX(MDL
     $ _MB),DCMPLX(ZERO),3,I_SO,25)
C     CutTools call for loop numbers 53,63
      CALL ML5_0_LOOP_3(1,5,19,DCMPLX(MDL_MB),DCMPLX(ZERO),DCMPLX(MDL_M
     $ B),2,I_SO,26)
C     CutTools call for loop numbers 54
      CALL ML5_0_LOOP_4(1,3,12,5,DCMPLX(MDL_MB),DCMPLX(MDL_MT)
     $ ,DCMPLX(ZERO),DCMPLX(MDL_MB),3,I_SO,27)
C     CutTools call for loop numbers 55
      CALL ML5_0_LOOP_3(1,7,10,DCMPLX(MDL_MB),DCMPLX(ZERO),DCMPLX(MDL_M
     $ B),2,I_SO,28)
C     CutTools call for loop numbers 56
      CALL ML5_0_LOOP_4(1,3,4,10,DCMPLX(MDL_MB),DCMPLX(MDL_MT)
     $ ,DCMPLX(ZERO),DCMPLX(MDL_MB),3,I_SO,29)
C     CutTools call for loop numbers 57
      CALL ML5_0_LOOP_5(1,2,3,4,5,DCMPLX(MDL_MB),DCMPLX(MDL_MB)
     $ ,DCMPLX(MDL_MT),DCMPLX(ZERO),DCMPLX(MDL_MB),4,I_SO,30)
C     CutTools call for loop numbers 58,60,61,65
      CALL ML5_0_LOOP_3(1,2,13,DCMPLX(MDL_MB),DCMPLX(MDL_MB),DCMPLX(MDL
     $ _MB),3,I_SO,31)
C     CutTools call for loop numbers 59
      CALL ML5_0_LOOP_4(1,2,7,5,DCMPLX(MDL_MB),DCMPLX(MDL_MB)
     $ ,DCMPLX(ZERO),DCMPLX(MDL_MB),3,I_SO,32)
C     CutTools call for loop numbers 62
      CALL ML5_0_LOOP_4(1,2,5,7,DCMPLX(MDL_MB),DCMPLX(MDL_MB)
     $ ,DCMPLX(ZERO),DCMPLX(MDL_MB),3,I_SO,33)
C     CutTools call for loop numbers 64
      CALL ML5_0_LOOP_4(1,5,2,7,DCMPLX(MDL_MB),DCMPLX(ZERO),DCMPLX(ZERO
     $ ),DCMPLX(MDL_MB),3,I_SO,34)
C     CutTools call for loop numbers 66
      CALL ML5_0_LOOP_5(1,2,5,4,3,DCMPLX(MDL_MB),DCMPLX(MDL_MB)
     $ ,DCMPLX(ZERO),DCMPLX(MDL_MT),DCMPLX(MDL_MB),4,I_SO,35)
C     CutTools call for loop numbers 67
      CALL ML5_0_LOOP_5(1,3,2,4,5,DCMPLX(MDL_MB),DCMPLX(MDL_MT)
     $ ,DCMPLX(MDL_MT),DCMPLX(ZERO),DCMPLX(MDL_MB),4,I_SO,36)
C     CutTools call for loop numbers 68
      CALL ML5_0_LOOP_5(1,3,4,2,5,DCMPLX(MDL_MB),DCMPLX(MDL_MT)
     $ ,DCMPLX(ZERO),DCMPLX(ZERO),DCMPLX(MDL_MB),4,I_SO,37)
C     CutTools call for loop numbers 70
      CALL ML5_0_LOOP_4(1,3,5,12,DCMPLX(MDL_MT),DCMPLX(MDL_MB)
     $ ,DCMPLX(ZERO),DCMPLX(MDL_MT),3,I_SO,38)
C     CutTools call for loop numbers 71
      CALL ML5_0_LOOP_4(1,5,3,12,DCMPLX(ZERO),DCMPLX(MDL_MB),DCMPLX(MDL
     $ _MT),DCMPLX(ZERO),3,I_SO,39)
C     CutTools call for loop numbers 72,84
      CALL ML5_0_LOOP_3(1,5,19,DCMPLX(ZERO),DCMPLX(MDL_MB),DCMPLX(ZERO
     $ ),2,I_SO,40)
C     CutTools call for loop numbers 75
      CALL ML5_0_LOOP_3(1,7,10,DCMPLX(ZERO),DCMPLX(MDL_MB),DCMPLX(ZERO
     $ ),2,I_SO,41)
C     CutTools call for loop numbers 77
      CALL ML5_0_LOOP_4(1,3,10,4,DCMPLX(MDL_MT),DCMPLX(MDL_MB)
     $ ,DCMPLX(ZERO),DCMPLX(MDL_MT),3,I_SO,42)
C     CutTools call for loop numbers 78
      CALL ML5_0_LOOP_4(1,4,3,10,DCMPLX(ZERO),DCMPLX(MDL_MT),DCMPLX(MDL
     $ _MB),DCMPLX(ZERO),3,I_SO,43)
C     CutTools call for loop numbers 80
      CALL ML5_0_LOOP_4(1,5,2,7,DCMPLX(ZERO),DCMPLX(MDL_MB),DCMPLX(MDL_
     $ MB),DCMPLX(ZERO),3,I_SO,44)
C     CutTools call for loop numbers 81
      CALL ML5_0_LOOP_5(1,3,2,5,4,DCMPLX(MDL_MT),DCMPLX(MDL_MB)
     $ ,DCMPLX(MDL_MB),DCMPLX(ZERO),DCMPLX(MDL_MT),4,I_SO,45)
C     CutTools call for loop numbers 82
      CALL ML5_0_LOOP_5(1,4,3,2,5,DCMPLX(ZERO),DCMPLX(MDL_MT)
     $ ,DCMPLX(MDL_MB),DCMPLX(MDL_MB),DCMPLX(ZERO),4,I_SO,46)
C     CutTools call for loop numbers 85
      CALL ML5_0_LOOP_4(1,2,7,5,DCMPLX(ZERO),DCMPLX(ZERO),DCMPLX(MDL_MB
     $ ),DCMPLX(ZERO),3,I_SO,47)
C     CutTools call for loop numbers 86
      CALL ML5_0_LOOP_4(1,2,5,7,DCMPLX(ZERO),DCMPLX(ZERO),DCMPLX(MDL_MB
     $ ),DCMPLX(ZERO),3,I_SO,48)
C     CutTools call for loop numbers 90
      CALL ML5_0_LOOP_5(1,3,5,2,4,DCMPLX(MDL_MT),DCMPLX(MDL_MB)
     $ ,DCMPLX(ZERO),DCMPLX(ZERO),DCMPLX(MDL_MT),4,I_SO,49)
C     CutTools call for loop numbers 91
      CALL ML5_0_LOOP_5(1,2,4,5,3,DCMPLX(MDL_MT),DCMPLX(MDL_MT)
     $ ,DCMPLX(ZERO),DCMPLX(MDL_MB),DCMPLX(MDL_MT),4,I_SO,50)
C     CutTools call for loop numbers 92
      CALL ML5_0_LOOP_5(1,4,2,3,5,DCMPLX(ZERO),DCMPLX(MDL_MT)
     $ ,DCMPLX(MDL_MT),DCMPLX(MDL_MB),DCMPLX(ZERO),4,I_SO,51)
C     CutTools call for loop numbers 93
      CALL ML5_0_LOOP_5(1,2,4,3,5,DCMPLX(ZERO),DCMPLX(ZERO),DCMPLX(MDL_
     $ MT),DCMPLX(MDL_MB),DCMPLX(ZERO),4,I_SO,52)
C     CutTools call for loop numbers 94
      CALL ML5_0_LOOP_5(1,2,3,5,4,DCMPLX(MDL_MT),DCMPLX(MDL_MT)
     $ ,DCMPLX(MDL_MB),DCMPLX(ZERO),DCMPLX(MDL_MT),4,I_SO,53)
C     CutTools call for loop numbers 95
      CALL ML5_0_LOOP_5(1,2,5,3,4,DCMPLX(ZERO),DCMPLX(ZERO),DCMPLX(MDL_
     $ MB),DCMPLX(MDL_MT),DCMPLX(ZERO),4,I_SO,54)
C     CutTools call for loop numbers 99,101
      CALL ML5_0_LOOP_2(6,13,DCMPLX(MDL_MT),DCMPLX(MDL_MT),2,I_SO,55)
C     CutTools call for loop numbers 100,106,122
      CALL ML5_0_LOOP_2(8,16,DCMPLX(ZERO),DCMPLX(MDL_MT),1,I_SO,56)
C     CutTools call for loop numbers 102
      CALL ML5_0_LOOP_3(4,6,8,DCMPLX(MDL_MT),DCMPLX(MDL_MT),DCMPLX(ZERO
     $ ),2,I_SO,57)
C     CutTools call for loop numbers 103,132,133,134
      CALL ML5_0_LOOP_3(4,6,8,DCMPLX(ZERO),DCMPLX(ZERO),DCMPLX(MDL_MT)
     $ ,2,I_SO,58)
C     CutTools call for loop numbers 104,107
      CALL ML5_0_LOOP_2(9,25,DCMPLX(ZERO),DCMPLX(MDL_MT),1,I_SO,59)
C     CutTools call for loop numbers 105
      CALL ML5_0_LOOP_3(2,9,8,DCMPLX(MDL_MT),DCMPLX(ZERO),DCMPLX(MDL_MT
     $ ),2,I_SO,60)
C     CutTools call for loop numbers 108
      CALL ML5_0_LOOP_3(2,9,8,DCMPLX(ZERO),DCMPLX(MDL_MT),DCMPLX(ZERO)
     $ ,2,I_SO,61)
C     CutTools call for loop numbers 109,123
      CALL ML5_0_LOOP_2(12,27,DCMPLX(ZERO),DCMPLX(MDL_MT),1,I_SO,62)
C     CutTools call for loop numbers 110,126
      CALL ML5_0_LOOP_3(2,4,27,DCMPLX(MDL_MT),DCMPLX(ZERO),DCMPLX(MDL_M
     $ T),2,I_SO,63)
C     CutTools call for loop numbers 111,128
      CALL ML5_0_LOOP_3(2,4,27,DCMPLX(ZERO),DCMPLX(MDL_MT),DCMPLX(ZERO
     $ ),2,I_SO,64)
C     CutTools call for loop numbers 112
      CALL ML5_0_LOOP_3(1,12,8,DCMPLX(MDL_MT),DCMPLX(ZERO),DCMPLX(MDL_M
     $ T),2,I_SO,65)
C     CutTools call for loop numbers 113,121
      CALL ML5_0_LOOP_3(1,4,25,DCMPLX(MDL_MT),DCMPLX(ZERO),DCMPLX(MDL_M
     $ T),2,I_SO,66)
C     CutTools call for loop numbers 114,115,117,118
      CALL ML5_0_LOOP_3(1,2,13,DCMPLX(MDL_MT),DCMPLX(MDL_MT),DCMPLX(MDL
     $ _MT),3,I_SO,67)
C     CutTools call for loop numbers 116
      CALL ML5_0_LOOP_4(1,2,4,8,DCMPLX(MDL_MT),DCMPLX(MDL_MT)
     $ ,DCMPLX(ZERO),DCMPLX(MDL_MT),3,I_SO,68)
C     CutTools call for loop numbers 119
      CALL ML5_0_LOOP_4(1,2,8,4,DCMPLX(MDL_MT),DCMPLX(MDL_MT)
     $ ,DCMPLX(ZERO),DCMPLX(MDL_MT),3,I_SO,69)
C     CutTools call for loop numbers 120
      CALL ML5_0_LOOP_4(1,4,2,8,DCMPLX(MDL_MT),DCMPLX(ZERO),DCMPLX(ZERO
     $ ),DCMPLX(MDL_MT),3,I_SO,70)
C     CutTools call for loop numbers 124
      CALL ML5_0_LOOP_3(1,12,8,DCMPLX(ZERO),DCMPLX(MDL_MT),DCMPLX(ZERO
     $ ),2,I_SO,71)
C     CutTools call for loop numbers 125,129
      CALL ML5_0_LOOP_3(1,4,25,DCMPLX(ZERO),DCMPLX(MDL_MT),DCMPLX(ZERO
     $ ),2,I_SO,72)
C     CutTools call for loop numbers 127
      CALL ML5_0_LOOP_4(1,4,2,8,DCMPLX(ZERO),DCMPLX(MDL_MT),DCMPLX(MDL_
     $ MT),DCMPLX(ZERO),3,I_SO,73)
C     CutTools call for loop numbers 130
      CALL ML5_0_LOOP_4(1,2,8,4,DCMPLX(ZERO),DCMPLX(ZERO),DCMPLX(MDL_MT
     $ ),DCMPLX(ZERO),3,I_SO,74)
C     CutTools call for loop numbers 131
      CALL ML5_0_LOOP_4(1,2,4,8,DCMPLX(ZERO),DCMPLX(ZERO),DCMPLX(MDL_MT
     $ ),DCMPLX(ZERO),3,I_SO,75)
C     CutTools call for loop numbers 139,140,141,142,143,144
      CALL ML5_0_LOOP_2_3(1,2,1,13,2,DCMPLX(ZERO),DCMPLX(ZERO),1,I_SO
     $ ,76)
C     CutTools call for loop numbers 145,146,147,148,149,150
      CALL ML5_0_LOOP_2_3(1,2,2,13,1,DCMPLX(ZERO),DCMPLX(ZERO),1,I_SO
     $ ,77)

      GOTO 1001
 5000 CONTINUE
      CTCALL_REQ_SO_DONE=.TRUE.
 1001 CONTINUE
      END

