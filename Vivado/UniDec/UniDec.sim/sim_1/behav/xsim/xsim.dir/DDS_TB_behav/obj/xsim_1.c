/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
IKI_DLLESPEC extern void execute_44(char*, char *);
IKI_DLLESPEC extern void execute_45(char*, char *);
IKI_DLLESPEC extern void execute_2478(char*, char *);
IKI_DLLESPEC extern void execute_47(char*, char *);
IKI_DLLESPEC extern void execute_48(char*, char *);
IKI_DLLESPEC extern void execute_49(char*, char *);
IKI_DLLESPEC extern void execute_67(char*, char *);
IKI_DLLESPEC extern void execute_68(char*, char *);
IKI_DLLESPEC extern void execute_69(char*, char *);
IKI_DLLESPEC extern void execute_2476(char*, char *);
IKI_DLLESPEC extern void execute_2477(char*, char *);
IKI_DLLESPEC extern void execute_152(char*, char *);
IKI_DLLESPEC extern void execute_218(char*, char *);
IKI_DLLESPEC extern void execute_703(char*, char *);
IKI_DLLESPEC extern void execute_704(char*, char *);
IKI_DLLESPEC extern void execute_712(char*, char *);
IKI_DLLESPEC extern void execute_720(char*, char *);
IKI_DLLESPEC extern void execute_721(char*, char *);
IKI_DLLESPEC extern void execute_223(char*, char *);
IKI_DLLESPEC extern void execute_225(char*, char *);
IKI_DLLESPEC extern void execute_250(char*, char *);
IKI_DLLESPEC extern void execute_228(char*, char *);
IKI_DLLESPEC extern void execute_229(char*, char *);
IKI_DLLESPEC extern void execute_253(char*, char *);
IKI_DLLESPEC extern void execute_256(char*, char *);
IKI_DLLESPEC extern void execute_258(char*, char *);
IKI_DLLESPEC extern void execute_268(char*, char *);
IKI_DLLESPEC extern void execute_264(char*, char *);
IKI_DLLESPEC extern void execute_265(char*, char *);
IKI_DLLESPEC extern void execute_710(char*, char *);
IKI_DLLESPEC extern void execute_707(char*, char *);
IKI_DLLESPEC extern void execute_708(char*, char *);
IKI_DLLESPEC extern void execute_716(char*, char *);
IKI_DLLESPEC extern void execute_717(char*, char *);
IKI_DLLESPEC extern void execute_718(char*, char *);
IKI_DLLESPEC extern void execute_170(char*, char *);
IKI_DLLESPEC extern void execute_171(char*, char *);
IKI_DLLESPEC extern void execute_185(char*, char *);
IKI_DLLESPEC extern void execute_161(char*, char *);
IKI_DLLESPEC extern void execute_167(char*, char *);
IKI_DLLESPEC extern void execute_168(char*, char *);
IKI_DLLESPEC extern void execute_165(char*, char *);
IKI_DLLESPEC extern void execute_173(char*, char *);
IKI_DLLESPEC extern void execute_175(char*, char *);
IKI_DLLESPEC extern void execute_177(char*, char *);
IKI_DLLESPEC extern void execute_179(char*, char *);
IKI_DLLESPEC extern void execute_181(char*, char *);
IKI_DLLESPEC extern void execute_183(char*, char *);
IKI_DLLESPEC extern void execute_246(char*, char *);
IKI_DLLESPEC extern void execute_247(char*, char *);
IKI_DLLESPEC extern void execute_249(char*, char *);
IKI_DLLESPEC extern void execute_238(char*, char *);
IKI_DLLESPEC extern void execute_243(char*, char *);
IKI_DLLESPEC extern void execute_244(char*, char *);
IKI_DLLESPEC extern void execute_241(char*, char *);
IKI_DLLESPEC extern void execute_277(char*, char *);
IKI_DLLESPEC extern void execute_696(char*, char *);
IKI_DLLESPEC extern void execute_697(char*, char *);
IKI_DLLESPEC extern void execute_281(char*, char *);
IKI_DLLESPEC extern void execute_283(char*, char *);
IKI_DLLESPEC extern void execute_321(char*, char *);
IKI_DLLESPEC extern void execute_324(char*, char *);
IKI_DLLESPEC extern void execute_325(char*, char *);
IKI_DLLESPEC extern void execute_323(char*, char *);
IKI_DLLESPEC extern void execute_327(char*, char *);
IKI_DLLESPEC extern void execute_328(char*, char *);
IKI_DLLESPEC extern void execute_329(char*, char *);
IKI_DLLESPEC extern void execute_339(char*, char *);
IKI_DLLESPEC extern void execute_456(char*, char *);
IKI_DLLESPEC extern void execute_465(char*, char *);
IKI_DLLESPEC extern void execute_472(char*, char *);
IKI_DLLESPEC extern void execute_484(char*, char *);
IKI_DLLESPEC extern void execute_666(char*, char *);
IKI_DLLESPEC extern void execute_667(char*, char *);
IKI_DLLESPEC extern void execute_682(char*, char *);
IKI_DLLESPEC extern void execute_665(char*, char *);
IKI_DLLESPEC extern void execute_670(char*, char *);
IKI_DLLESPEC extern void execute_671(char*, char *);
IKI_DLLESPEC extern void execute_289(char*, char *);
IKI_DLLESPEC extern void execute_290(char*, char *);
IKI_DLLESPEC extern void execute_291(char*, char *);
IKI_DLLESPEC extern void execute_294(char*, char *);
IKI_DLLESPEC extern void execute_311(char*, char *);
IKI_DLLESPEC extern void execute_312(char*, char *);
IKI_DLLESPEC extern void execute_314(char*, char *);
IKI_DLLESPEC extern void execute_302(char*, char *);
IKI_DLLESPEC extern void execute_308(char*, char *);
IKI_DLLESPEC extern void execute_309(char*, char *);
IKI_DLLESPEC extern void execute_306(char*, char *);
IKI_DLLESPEC extern void execute_335(char*, char *);
IKI_DLLESPEC extern void execute_336(char*, char *);
IKI_DLLESPEC extern void execute_337(char*, char *);
IKI_DLLESPEC extern void execute_383(char*, char *);
IKI_DLLESPEC extern void execute_347(char*, char *);
IKI_DLLESPEC extern void execute_348(char*, char *);
IKI_DLLESPEC extern void execute_349(char*, char *);
IKI_DLLESPEC extern void execute_355(char*, char *);
IKI_DLLESPEC extern void execute_356(char*, char *);
IKI_DLLESPEC extern void execute_380(char*, char *);
IKI_DLLESPEC extern void execute_386(char*, char *);
IKI_DLLESPEC extern void execute_419(char*, char *);
IKI_DLLESPEC extern void execute_422(char*, char *);
IKI_DLLESPEC extern void execute_423(char*, char *);
IKI_DLLESPEC extern void execute_375(char*, char *);
IKI_DLLESPEC extern void execute_376(char*, char *);
IKI_DLLESPEC extern void execute_378(char*, char *);
IKI_DLLESPEC extern void execute_366(char*, char *);
IKI_DLLESPEC extern void execute_372(char*, char *);
IKI_DLLESPEC extern void execute_373(char*, char *);
IKI_DLLESPEC extern void execute_370(char*, char *);
IKI_DLLESPEC extern void execute_390(char*, char *);
IKI_DLLESPEC extern void execute_395(char*, char *);
IKI_DLLESPEC extern void execute_413(char*, char *);
IKI_DLLESPEC extern void execute_414(char*, char *);
IKI_DLLESPEC extern void execute_416(char*, char *);
IKI_DLLESPEC extern void execute_404(char*, char *);
IKI_DLLESPEC extern void execute_410(char*, char *);
IKI_DLLESPEC extern void execute_411(char*, char *);
IKI_DLLESPEC extern void execute_408(char*, char *);
IKI_DLLESPEC extern void execute_447(char*, char *);
IKI_DLLESPEC extern void execute_448(char*, char *);
IKI_DLLESPEC extern void execute_449(char*, char *);
IKI_DLLESPEC extern void execute_461(char*, char *);
IKI_DLLESPEC extern void execute_675(char*, char *);
IKI_DLLESPEC extern void execute_497(char*, char *);
IKI_DLLESPEC extern void execute_500(char*, char *);
IKI_DLLESPEC extern void execute_507(char*, char *);
IKI_DLLESPEC extern void execute_548(char*, char *);
IKI_DLLESPEC extern void execute_549(char*, char *);
IKI_DLLESPEC extern void execute_510(char*, char *);
IKI_DLLESPEC extern void execute_514(char*, char *);
IKI_DLLESPEC extern void execute_517(char*, char *);
IKI_DLLESPEC extern void execute_521(char*, char *);
IKI_DLLESPEC extern void execute_553(char*, char *);
IKI_DLLESPEC extern void execute_554(char*, char *);
IKI_DLLESPEC extern void execute_558(char*, char *);
IKI_DLLESPEC extern void execute_600(char*, char *);
IKI_DLLESPEC extern void execute_601(char*, char *);
IKI_DLLESPEC extern void execute_607(char*, char *);
IKI_DLLESPEC extern void execute_608(char*, char *);
IKI_DLLESPEC extern void execute_612(char*, char *);
IKI_DLLESPEC extern void execute_613(char*, char *);
IKI_DLLESPEC extern void execute_614(char*, char *);
IKI_DLLESPEC extern void execute_538(char*, char *);
IKI_DLLESPEC extern void execute_539(char*, char *);
IKI_DLLESPEC extern void execute_547(char*, char *);
IKI_DLLESPEC extern void execute_529(char*, char *);
IKI_DLLESPEC extern void execute_535(char*, char *);
IKI_DLLESPEC extern void execute_536(char*, char *);
IKI_DLLESPEC extern void execute_533(char*, char *);
IKI_DLLESPEC extern void execute_541(char*, char *);
IKI_DLLESPEC extern void execute_543(char*, char *);
IKI_DLLESPEC extern void execute_545(char*, char *);
IKI_DLLESPEC extern void execute_575(char*, char *);
IKI_DLLESPEC extern void execute_576(char*, char *);
IKI_DLLESPEC extern void execute_578(char*, char *);
IKI_DLLESPEC extern void execute_566(char*, char *);
IKI_DLLESPEC extern void execute_572(char*, char *);
IKI_DLLESPEC extern void execute_573(char*, char *);
IKI_DLLESPEC extern void execute_570(char*, char *);
IKI_DLLESPEC extern void execute_633(char*, char *);
IKI_DLLESPEC extern void execute_634(char*, char *);
IKI_DLLESPEC extern void execute_638(char*, char *);
IKI_DLLESPEC extern void execute_624(char*, char *);
IKI_DLLESPEC extern void execute_630(char*, char *);
IKI_DLLESPEC extern void execute_631(char*, char *);
IKI_DLLESPEC extern void execute_628(char*, char *);
IKI_DLLESPEC extern void execute_636(char*, char *);
IKI_DLLESPEC extern void execute_688(char*, char *);
IKI_DLLESPEC extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
IKI_DLLESPEC extern void transaction_57(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_58(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_61(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_62(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_68(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_69(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_72(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_73(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_74(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_81(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_95(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_99(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_106(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_115(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_242(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_259(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_269(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_270(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_443(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_444(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_447(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_448(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_454(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_455(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_458(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_459(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_460(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_467(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_481(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_485(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_492(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_501(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_599(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_616(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_626(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_627(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_800(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_801(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_804(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_805(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_811(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_812(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_815(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_816(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_817(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_824(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_838(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_842(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_849(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_858(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_956(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_973(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_983(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_984(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1157(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1158(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1161(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1162(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1168(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1169(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1172(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1173(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1174(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1181(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1195(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1199(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1206(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1215(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1313(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1330(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1340(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1341(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[243] = {(funcp)execute_44, (funcp)execute_45, (funcp)execute_2478, (funcp)execute_47, (funcp)execute_48, (funcp)execute_49, (funcp)execute_67, (funcp)execute_68, (funcp)execute_69, (funcp)execute_2476, (funcp)execute_2477, (funcp)execute_152, (funcp)execute_218, (funcp)execute_703, (funcp)execute_704, (funcp)execute_712, (funcp)execute_720, (funcp)execute_721, (funcp)execute_223, (funcp)execute_225, (funcp)execute_250, (funcp)execute_228, (funcp)execute_229, (funcp)execute_253, (funcp)execute_256, (funcp)execute_258, (funcp)execute_268, (funcp)execute_264, (funcp)execute_265, (funcp)execute_710, (funcp)execute_707, (funcp)execute_708, (funcp)execute_716, (funcp)execute_717, (funcp)execute_718, (funcp)execute_170, (funcp)execute_171, (funcp)execute_185, (funcp)execute_161, (funcp)execute_167, (funcp)execute_168, (funcp)execute_165, (funcp)execute_173, (funcp)execute_175, (funcp)execute_177, (funcp)execute_179, (funcp)execute_181, (funcp)execute_183, (funcp)execute_246, (funcp)execute_247, (funcp)execute_249, (funcp)execute_238, (funcp)execute_243, (funcp)execute_244, (funcp)execute_241, (funcp)execute_277, (funcp)execute_696, (funcp)execute_697, (funcp)execute_281, (funcp)execute_283, (funcp)execute_321, (funcp)execute_324, (funcp)execute_325, (funcp)execute_323, (funcp)execute_327, (funcp)execute_328, (funcp)execute_329, (funcp)execute_339, (funcp)execute_456, (funcp)execute_465, (funcp)execute_472, (funcp)execute_484, (funcp)execute_666, (funcp)execute_667, (funcp)execute_682, (funcp)execute_665, (funcp)execute_670, (funcp)execute_671, (funcp)execute_289, (funcp)execute_290, (funcp)execute_291, (funcp)execute_294, (funcp)execute_311, (funcp)execute_312, (funcp)execute_314, (funcp)execute_302, (funcp)execute_308, (funcp)execute_309, (funcp)execute_306, (funcp)execute_335, (funcp)execute_336, (funcp)execute_337, (funcp)execute_383, (funcp)execute_347, (funcp)execute_348, (funcp)execute_349, (funcp)execute_355, (funcp)execute_356, (funcp)execute_380, (funcp)execute_386, (funcp)execute_419, (funcp)execute_422, (funcp)execute_423, (funcp)execute_375, (funcp)execute_376, (funcp)execute_378, (funcp)execute_366, (funcp)execute_372, (funcp)execute_373, (funcp)execute_370, (funcp)execute_390, (funcp)execute_395, (funcp)execute_413, (funcp)execute_414, (funcp)execute_416, (funcp)execute_404, (funcp)execute_410, (funcp)execute_411, (funcp)execute_408, (funcp)execute_447, (funcp)execute_448, (funcp)execute_449, (funcp)execute_461, (funcp)execute_675, (funcp)execute_497, (funcp)execute_500, (funcp)execute_507, (funcp)execute_548, (funcp)execute_549, (funcp)execute_510, (funcp)execute_514, (funcp)execute_517, (funcp)execute_521, (funcp)execute_553, (funcp)execute_554, (funcp)execute_558, (funcp)execute_600, (funcp)execute_601, (funcp)execute_607, (funcp)execute_608, (funcp)execute_612, (funcp)execute_613, (funcp)execute_614, (funcp)execute_538, (funcp)execute_539, (funcp)execute_547, (funcp)execute_529, (funcp)execute_535, (funcp)execute_536, (funcp)execute_533, (funcp)execute_541, (funcp)execute_543, (funcp)execute_545, (funcp)execute_575, (funcp)execute_576, (funcp)execute_578, (funcp)execute_566, (funcp)execute_572, (funcp)execute_573, (funcp)execute_570, (funcp)execute_633, (funcp)execute_634, (funcp)execute_638, (funcp)execute_624, (funcp)execute_630, (funcp)execute_631, (funcp)execute_628, (funcp)execute_636, (funcp)execute_688, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_57, (funcp)transaction_58, (funcp)transaction_61, (funcp)transaction_62, (funcp)transaction_68, (funcp)transaction_69, (funcp)transaction_72, (funcp)transaction_73, (funcp)transaction_74, (funcp)transaction_81, (funcp)transaction_95, (funcp)transaction_99, (funcp)transaction_106, (funcp)transaction_115, (funcp)transaction_242, (funcp)transaction_259, (funcp)transaction_269, (funcp)transaction_270, (funcp)transaction_443, (funcp)transaction_444, (funcp)transaction_447, (funcp)transaction_448, (funcp)transaction_454, (funcp)transaction_455, (funcp)transaction_458, (funcp)transaction_459, (funcp)transaction_460, (funcp)transaction_467, (funcp)transaction_481, (funcp)transaction_485, (funcp)transaction_492, (funcp)transaction_501, (funcp)transaction_599, (funcp)transaction_616, (funcp)transaction_626, (funcp)transaction_627, (funcp)transaction_800, (funcp)transaction_801, (funcp)transaction_804, (funcp)transaction_805, (funcp)transaction_811, (funcp)transaction_812, (funcp)transaction_815, (funcp)transaction_816, (funcp)transaction_817, (funcp)transaction_824, (funcp)transaction_838, (funcp)transaction_842, (funcp)transaction_849, (funcp)transaction_858, (funcp)transaction_956, (funcp)transaction_973, (funcp)transaction_983, (funcp)transaction_984, (funcp)transaction_1157, (funcp)transaction_1158, (funcp)transaction_1161, (funcp)transaction_1162, (funcp)transaction_1168, (funcp)transaction_1169, (funcp)transaction_1172, (funcp)transaction_1173, (funcp)transaction_1174, (funcp)transaction_1181, (funcp)transaction_1195, (funcp)transaction_1199, (funcp)transaction_1206, (funcp)transaction_1215, (funcp)transaction_1313, (funcp)transaction_1330, (funcp)transaction_1340, (funcp)transaction_1341};
const int NumRelocateId= 243;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/DDS_TB_behav/xsim.reloc",  (void **)funcTab, 243);
	iki_vhdl_file_variable_register(dp + 444424);
	iki_vhdl_file_variable_register(dp + 444480);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/DDS_TB_behav/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/DDS_TB_behav/xsim.reloc");

	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/DDS_TB_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/DDS_TB_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/DDS_TB_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, (void*)0, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
