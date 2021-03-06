(* Code automatically generated by 'PreSARAH' *) 
(* Expressions for amplitudes are obtained by FeynArts/FormCalc *) 
(* This file is supposed to be loaded and used by SARAH *) 
(* Created at 15:46 on 16.12.2015 *) 
 
 
PrintDebug["   ... ",TreeV2L2u]; 
NamesParticles =  {ChargedLepton, bar[ChargedLepton], UpQuark, bar[UpQuark]}; 
 NamesOperators =  {TVOlluuSLL, TVOlluuSRR, TVOlluuSRL, TVOlluuSLR, TVOlluuVRR, TVOlluuVLL, TVOlluuVRL, TVOlluuVLR, TVOlluuTLL, TVOlluuTLR, TVOlluuTRL, TVOlluuTRR}; 
 NeglectInsertionOrderTree[TreeV2L2u] =  {}; 
NeglectCrossedDiagrams[TreeV2L2u] = False; 
NameProcess = TreeV2L2u; 
 
Generate[TreeV2L2u][file_]:=Block[{i,j,k}, 
 

 (* Creating all possible processes; extract information about involved masses/couplings *) 


(* ------------------------------- *)
(* {ChargedLepton, bar[ChargedLepton], UpQuark, bar[UpQuark]} *)
(* ------------------------------- *)
 
GetInformtion4FermionProcess[ChargedLepton,bar[ChargedLepton],UpQuark,bar[UpQuark],TreeV2L2u,file]; 
NeededMassesAll=Intersection[NeededMasses];
NeededCouplingsAll=Intersection[NeededCouplings];
WriteCodeObservablePreSARAH[TreeV2L2u][NeededMassesAll,NeededCouplingsAll,TreeContributionsScalar,TreeContributionsVector,WaveContributionsScalar,WaveContributionsVector,WaveContributionsPhoton,PenguinContributionsScalar,PenguinContributionsVector,PenguinContributionsPhoton,BoxContributions,file]; 
NeededMassAllSaved[TreeV2L2u] = masses 
]; 

WriteCodeObservablePreSARAH[TreeV2L2u][masses_,couplings_,treeScalar_,treeVector_,waveScalar_,waveVector_,wavePhoton_,penguinScalar_,penguinVector_,penguinPhoton_,box_,file_] :=Block[{i,j,k,fermions,scalars}, 
 
NeededMassesAllSaved[TreeV2L2u] = masses; 
NeededCouplingsAllSaved[TreeV2L2u] = couplings; 
NeededCombinations[TreeV2L2u] = {{2, 1, 1, 1}, {3, 1, 1, 1}, {3, 2, 1, 1}}; 
PrintDebug["     writing SPheno code for ",TreeV2L2u]; 
MakeSubroutineTitle["CalculateTreeV2L2u",Flatten[{masses,couplings}],{"gt1","gt2","gt3","gt4","OnlySM"}, 
{"TVOlluuSLL", "TVOlluuSRR", "TVOlluuSRL", "TVOlluuSLR", "TVOlluuVRR", "TVOlluuVLL", "TVOlluuVRL", "TVOlluuVLR", "TVOlluuTLL", "TVOlluuTLR", "TVOlluuTRL", "TVOlluuTRR"},file]; 
WriteString[file,"! ---------------------------------------------------------------- \n"]; 
WriteString[file,"! Code based on automatically generated SARAH extensions by 'PreSARAH' \n"]; 
WriteString[file,"! Expressions for amplitudes are obtained by FeynArts/FormCalc \n"]; 
WriteString[file,"! Based on user input for process TreeV2L2u \n"]; 
WriteString[file,"! 'PreSARAH' output has been generated  at 15:46 on 16.12.2015 \n"]; 
WriteString[file,"! ---------------------------------------------------------------- \n \n"]; 
 
 
WriteString[file,"Implicit None \n"]; 
MakeVariableList[Flatten[{couplings,masses}],",Intent(in)",file];
WriteString[file,"Integer,Intent(in) :: gt1, gt2,gt3,gt4 \n"];
WriteString[file,"Logical, Intent(in) :: OnlySM \n"];
WriteString[file,"Integer :: iprop, i1, i2, i3, i4 \n"];
WriteString[file,"Real(dp) :: MassEx1,MassEx2,MassEx3,MassEx4, MassEx12,MassEx22,MassEx32,MassEx42 \n"];
WriteString[file,"Complex(dp), Intent(out) :: TVOlluuSLL \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVOlluuSRR \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVOlluuSRL \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVOlluuSLR \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVOlluuVRR \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVOlluuVLL \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVOlluuVRL \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVOlluuVLR \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVOlluuTLL \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVOlluuTLR \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVOlluuTRL \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVOlluuTRR \n"]; 
WriteString[file,"Complex(dp) :: vertex1L, vertex1R, vertex2L, vertex2R \n"];
WriteString[file,"Real(dp) ::  MP, MP2, IMP2, IMP, MFin, MFin2, IMFin, IMFin2, Finite  \n"];
WriteString[file,"Real(dp) ::  MS1, MS12, MS2, MS22, MF1, MF12, MF2, MF22, MV1, MV12, MV2, MV22  \n"];
WriteString[file,"Complex(dp) ::  chargefactor  \n"];
WriteString[file,"Complex(dp) ::  coup1L, coup1R, coup2L, coup2R, coup3L, coup3R, coup3, coup4L, coup4R \n\n"];

WriteString[file,"Complex(dp) ::  int1,int2,int3,int4,int5,int6,int7,int8 \n\n"];

WriteString[file,"Iname=Iname+1 \n"];
WriteString[file,"NameOfUnit(Iname)='CalculateTreeV2L2u' \n
"];
 
AddCalcSquaredMasses[masses,file]; 
(* Initaliziation *)
WriteString[file,"Finite=1._dp \n"];
WriteString[file,"MassEx1="<>SPhenoMass[ChargedLepton,gt1]<>"  \n"];
WriteString[file,"MassEx12="<>SPhenoMassSq[ChargedLepton,gt1]<>" \n"];
WriteString[file,"MassEx2="<>SPhenoMass[bar[ChargedLepton],gt2]<>"  \n"];
WriteString[file,"MassEx22="<>SPhenoMassSq[bar[ChargedLepton],gt2]<>" \n"];
WriteString[file,"MassEx3="<>SPhenoMass[UpQuark,gt3]<>"  \n"];
WriteString[file,"MassEx32="<>SPhenoMassSq[UpQuark,gt3]<>" \n"];
WriteString[file,"MassEx4="<>SPhenoMass[bar[UpQuark],gt4]<>"  \n"];
WriteString[file,"MassEx42="<>SPhenoMassSq[bar[UpQuark],gt4]<>" \n"];
WriteString[file,"! ------------------------------ \n "];
WriteString[file,"! Amplitudes for external states \n "];
WriteString[file,"! {ChargedLepton, bar[ChargedLepton], UpQuark, bar[UpQuark]} \n "];
WriteString[file,"! ------------------------------ \n \n"];
WriteString[sphenoTeX,"\\section{External states: $"<>TeXOutput[{ChargedLepton[{gt1}], bar[ChargedLepton][{gt2}], UpQuark[{gt3}], bar[UpQuark][{gt4}]}]<>"$} \n"];
WriteString[file,"TVOlluuSLL=0._dp \n"]; 
WriteString[file,"TVOlluuSRR=0._dp \n"]; 
WriteString[file,"TVOlluuSRL=0._dp \n"]; 
WriteString[file,"TVOlluuSLR=0._dp \n"]; 
WriteString[file,"TVOlluuVRR=0._dp \n"]; 
WriteString[file,"TVOlluuVLL=0._dp \n"]; 
WriteString[file,"TVOlluuVRL=0._dp \n"]; 
WriteString[file,"TVOlluuVLR=0._dp \n"]; 
WriteString[file,"TVOlluuTLL=0._dp \n"]; 
WriteString[file,"TVOlluuTLR=0._dp \n"]; 
WriteString[file,"TVOlluuTRL=0._dp \n"]; 
WriteString[file,"TVOlluuTRR=0._dp \n"]; 
WriteDiagramsObservable[TreeV2L2u,{}, treeVector, {},  {}, {}, {}, {}, file];
WriteString[file,"Iname=Iname-1\n\n"]; 
WriteString[file,"End Subroutine CalculateTreeV2L2u \n\n"]; 
]; 
AddTreeResultPreSARAH[TreeV2L2u][prop_,top_,type_,file_]:=Block[{}, 

 (* This routine returns the generic expression for the amplitude of a given triangle diagram *) 
 
Switch[prop,
V, (* Vector penguins *) 
 Switch[top,  (* Check topology *) 
  1, 
	 	 WriteStringFLB[file,"  TVOlluuSLL=TVOlluuSLL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuSLL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuSLL,0}, " ];
	 	 WriteStringFLB[file,"  TVOlluuSRR=TVOlluuSRR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuSRR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuSRR,0}, " ];
	 	 WriteStringFLB[file,"  TVOlluuSRL=TVOlluuSRL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuSRL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuSRL,0}, " ];
	 	 WriteStringFLB[file,"  TVOlluuSLR=TVOlluuSLR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuSLR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuSLR,0} " ];
	 	 WriteStringFLB[file,"  TVOlluuVRR=TVOlluuVRR+ -1.*coup1R*coup2R*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuVRR= & "<> StringReplace["-(coup1R coup2R IMP2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuVRR,-(coup1R*coup2R*IMP2)} " ];
	 	 WriteStringFLB[file,"  TVOlluuVLL=TVOlluuVLL+ -1.*coup1L*coup2L*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuVLL= & "<> StringReplace["-(coup1L coup2L IMP2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuVLL,-(coup1L*coup2L*IMP2)} " ];
	 	 WriteStringFLB[file,"  TVOlluuVRL=TVOlluuVRL+ -1.*coup1R*coup2L*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuVRL= & "<> StringReplace["-(coup1R coup2L IMP2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuVRL,-(coup1R*coup2L*IMP2)} " ];
	 	 WriteStringFLB[file,"  TVOlluuVLR=TVOlluuVLR+ -1.*coup1L*coup2R*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuVLR= & "<> StringReplace["-(coup1L coup2R IMP2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuVLR,-(coup1L*coup2R*IMP2)} " ];
	 	 WriteStringFLB[file,"  TVOlluuTLL=TVOlluuTLL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuTLL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuTLL,0} " ];
	 	 WriteStringFLB[file,"  TVOlluuTLR=TVOlluuTLR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuTLR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuTLR,0} " ];
	 	 WriteStringFLB[file,"  TVOlluuTRL=TVOlluuTRL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuTRL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuTRL,0} " ];
	 	 WriteStringFLB[file,"  TVOlluuTRR=TVOlluuTRR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuTRR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuTRR,0} " ];
,
  2, 
	 	 WriteStringFLB[file,"  TVOlluuSLL=TVOlluuSLL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuSLL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuSLL,0}, " ];
	 	 WriteStringFLB[file,"  TVOlluuSRR=TVOlluuSRR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuSRR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuSRR,0}, " ];
	 	 WriteStringFLB[file,"  TVOlluuSRL=TVOlluuSRL+ -2.*coup1L*coup2L*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuSRL= & "<> StringReplace["-2 coup1L coup2L IMP2",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuSRL,-2*coup1L*coup2L*IMP2}, " ];
	 	 WriteStringFLB[file,"  TVOlluuSLR=TVOlluuSLR+ -2.*coup1R*coup2R*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuSLR= & "<> StringReplace["-2 coup1R coup2R IMP2",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuSLR,-2*coup1R*coup2R*IMP2} " ];
	 	 WriteStringFLB[file,"  TVOlluuVRR=TVOlluuVRR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuVRR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuVRR,0} " ];
	 	 WriteStringFLB[file,"  TVOlluuVLL=TVOlluuVLL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuVLL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuVLL,0} " ];
	 	 WriteStringFLB[file,"  TVOlluuVRL=TVOlluuVRL+ -1.*coup1L*coup2R*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuVRL= & "<> StringReplace["-(coup1L coup2R IMP2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuVRL,-(coup1L*coup2R*IMP2)} " ];
	 	 WriteStringFLB[file,"  TVOlluuVLR=TVOlluuVLR+ -1.*coup1R*coup2L*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuVLR= & "<> StringReplace["-(coup1R coup2L IMP2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuVLR,-(coup1R*coup2L*IMP2)} " ];
	 	 WriteStringFLB[file,"  TVOlluuTLL=TVOlluuTLL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuTLL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuTLL,0} " ];
	 	 WriteStringFLB[file,"  TVOlluuTLR=TVOlluuTLR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuTLR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuTLR,0} " ];
	 	 WriteStringFLB[file,"  TVOlluuTRL=TVOlluuTRL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuTRL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuTRL,0} " ];
	 	 WriteStringFLB[file,"  TVOlluuTRR=TVOlluuTRR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuTRR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuTRR,0} " ];
,
  3, 
	 	 WriteStringFLB[file,"  TVOlluuSLL=TVOlluuSLL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuSLL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuSLL,0}, " ];
	 	 WriteStringFLB[file,"  TVOlluuSRR=TVOlluuSRR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuSRR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuSRR,0}, " ];
	 	 WriteStringFLB[file,"  TVOlluuSRL=TVOlluuSRL+ 2.*coup1R*coup2L*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuSRL= & "<> StringReplace["2 coup1R coup2L IMP2",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuSRL,2*coup1R*coup2L*IMP2}, " ];
	 	 WriteStringFLB[file,"  TVOlluuSLR=TVOlluuSLR+ 2.*coup1L*coup2R*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuSLR= & "<> StringReplace["2 coup1L coup2R IMP2",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuSLR,2*coup1L*coup2R*IMP2} " ];
	 	 WriteStringFLB[file,"  TVOlluuVRR=TVOlluuVRR+ -1.*coup1R*coup2R*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuVRR= & "<> StringReplace["-(coup1R coup2R IMP2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuVRR,-(coup1R*coup2R*IMP2)} " ];
	 	 WriteStringFLB[file,"  TVOlluuVLL=TVOlluuVLL+ -1.*coup1L*coup2L*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuVLL= & "<> StringReplace["-(coup1L coup2L IMP2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuVLL,-(coup1L*coup2L*IMP2)} " ];
	 	 WriteStringFLB[file,"  TVOlluuVRL=TVOlluuVRL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuVRL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuVRL,0} " ];
	 	 WriteStringFLB[file,"  TVOlluuVLR=TVOlluuVLR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuVLR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuVLR,0} " ];
	 	 WriteStringFLB[file,"  TVOlluuTLL=TVOlluuTLL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuTLL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuTLL,0} " ];
	 	 WriteStringFLB[file,"  TVOlluuTLR=TVOlluuTLR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuTLR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuTLR,0} " ];
	 	 WriteStringFLB[file,"  TVOlluuTRL=TVOlluuTRL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuTRL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuTRL,0} " ];
	 	 WriteStringFLB[file,"  TVOlluuTRR=TVOlluuTRR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVOlluuTRR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVOlluuTRR,0} " ];
];,
S, (* Scalar penguins *) 
Return[]; (* not necessary *) ]; 
]; 


