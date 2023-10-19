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
IKI_DLLESPEC extern void execute_58(char*, char *);
IKI_DLLESPEC extern void execute_59(char*, char *);
IKI_DLLESPEC extern void execute_61(char*, char *);
IKI_DLLESPEC extern void execute_62(char*, char *);
IKI_DLLESPEC extern void execute_63(char*, char *);
IKI_DLLESPEC extern void execute_64(char*, char *);
IKI_DLLESPEC extern void execute_157(char*, char *);
IKI_DLLESPEC extern void execute_223(char*, char *);
IKI_DLLESPEC extern void execute_651(char*, char *);
IKI_DLLESPEC extern void execute_652(char*, char *);
IKI_DLLESPEC extern void execute_660(char*, char *);
IKI_DLLESPEC extern void execute_668(char*, char *);
IKI_DLLESPEC extern void execute_669(char*, char *);
IKI_DLLESPEC extern void execute_228(char*, char *);
IKI_DLLESPEC extern void execute_230(char*, char *);
IKI_DLLESPEC extern void execute_255(char*, char *);
IKI_DLLESPEC extern void execute_233(char*, char *);
IKI_DLLESPEC extern void execute_234(char*, char *);
IKI_DLLESPEC extern void execute_258(char*, char *);
IKI_DLLESPEC extern void execute_262(char*, char *);
IKI_DLLESPEC extern void execute_272(char*, char *);
IKI_DLLESPEC extern void execute_268(char*, char *);
IKI_DLLESPEC extern void execute_269(char*, char *);
IKI_DLLESPEC extern void execute_658(char*, char *);
IKI_DLLESPEC extern void execute_655(char*, char *);
IKI_DLLESPEC extern void execute_656(char*, char *);
IKI_DLLESPEC extern void execute_664(char*, char *);
IKI_DLLESPEC extern void execute_665(char*, char *);
IKI_DLLESPEC extern void execute_666(char*, char *);
IKI_DLLESPEC extern void execute_175(char*, char *);
IKI_DLLESPEC extern void execute_176(char*, char *);
IKI_DLLESPEC extern void execute_190(char*, char *);
IKI_DLLESPEC extern void execute_166(char*, char *);
IKI_DLLESPEC extern void execute_172(char*, char *);
IKI_DLLESPEC extern void execute_173(char*, char *);
IKI_DLLESPEC extern void execute_170(char*, char *);
IKI_DLLESPEC extern void execute_178(char*, char *);
IKI_DLLESPEC extern void execute_180(char*, char *);
IKI_DLLESPEC extern void execute_182(char*, char *);
IKI_DLLESPEC extern void execute_184(char*, char *);
IKI_DLLESPEC extern void execute_186(char*, char *);
IKI_DLLESPEC extern void execute_188(char*, char *);
IKI_DLLESPEC extern void execute_251(char*, char *);
IKI_DLLESPEC extern void execute_252(char*, char *);
IKI_DLLESPEC extern void execute_254(char*, char *);
IKI_DLLESPEC extern void execute_243(char*, char *);
IKI_DLLESPEC extern void execute_248(char*, char *);
IKI_DLLESPEC extern void execute_249(char*, char *);
IKI_DLLESPEC extern void execute_246(char*, char *);
IKI_DLLESPEC extern void execute_281(char*, char *);
IKI_DLLESPEC extern void execute_644(char*, char *);
IKI_DLLESPEC extern void execute_645(char*, char *);
IKI_DLLESPEC extern void execute_285(char*, char *);
IKI_DLLESPEC extern void execute_287(char*, char *);
IKI_DLLESPEC extern void execute_327(char*, char *);
IKI_DLLESPEC extern void execute_329(char*, char *);
IKI_DLLESPEC extern void execute_330(char*, char *);
IKI_DLLESPEC extern void execute_404(char*, char *);
IKI_DLLESPEC extern void execute_413(char*, char *);
IKI_DLLESPEC extern void execute_420(char*, char *);
IKI_DLLESPEC extern void execute_432(char*, char *);
IKI_DLLESPEC extern void execute_614(char*, char *);
IKI_DLLESPEC extern void execute_615(char*, char *);
IKI_DLLESPEC extern void execute_630(char*, char *);
IKI_DLLESPEC extern void execute_613(char*, char *);
IKI_DLLESPEC extern void execute_618(char*, char *);
IKI_DLLESPEC extern void execute_619(char*, char *);
IKI_DLLESPEC extern void execute_293(char*, char *);
IKI_DLLESPEC extern void execute_294(char*, char *);
IKI_DLLESPEC extern void execute_295(char*, char *);
IKI_DLLESPEC extern void execute_301(char*, char *);
IKI_DLLESPEC extern void execute_319(char*, char *);
IKI_DLLESPEC extern void execute_320(char*, char *);
IKI_DLLESPEC extern void execute_322(char*, char *);
IKI_DLLESPEC extern void execute_310(char*, char *);
IKI_DLLESPEC extern void execute_316(char*, char *);
IKI_DLLESPEC extern void execute_317(char*, char *);
IKI_DLLESPEC extern void execute_314(char*, char *);
IKI_DLLESPEC extern void execute_351(char*, char *);
IKI_DLLESPEC extern void execute_342(char*, char *);
IKI_DLLESPEC extern void execute_343(char*, char *);
IKI_DLLESPEC extern void execute_347(char*, char *);
IKI_DLLESPEC extern void execute_354(char*, char *);
IKI_DLLESPEC extern void execute_387(char*, char *);
IKI_DLLESPEC extern void execute_389(char*, char *);
IKI_DLLESPEC extern void execute_390(char*, char *);
IKI_DLLESPEC extern void execute_358(char*, char *);
IKI_DLLESPEC extern void execute_363(char*, char *);
IKI_DLLESPEC extern void execute_381(char*, char *);
IKI_DLLESPEC extern void execute_382(char*, char *);
IKI_DLLESPEC extern void execute_384(char*, char *);
IKI_DLLESPEC extern void execute_372(char*, char *);
IKI_DLLESPEC extern void execute_378(char*, char *);
IKI_DLLESPEC extern void execute_379(char*, char *);
IKI_DLLESPEC extern void execute_376(char*, char *);
IKI_DLLESPEC extern void execute_394(char*, char *);
IKI_DLLESPEC extern void execute_395(char*, char *);
IKI_DLLESPEC extern void execute_396(char*, char *);
IKI_DLLESPEC extern void execute_409(char*, char *);
IKI_DLLESPEC extern void execute_623(char*, char *);
IKI_DLLESPEC extern void execute_445(char*, char *);
IKI_DLLESPEC extern void execute_448(char*, char *);
IKI_DLLESPEC extern void execute_455(char*, char *);
IKI_DLLESPEC extern void execute_496(char*, char *);
IKI_DLLESPEC extern void execute_497(char*, char *);
IKI_DLLESPEC extern void execute_458(char*, char *);
IKI_DLLESPEC extern void execute_462(char*, char *);
IKI_DLLESPEC extern void execute_465(char*, char *);
IKI_DLLESPEC extern void execute_469(char*, char *);
IKI_DLLESPEC extern void execute_501(char*, char *);
IKI_DLLESPEC extern void execute_502(char*, char *);
IKI_DLLESPEC extern void execute_506(char*, char *);
IKI_DLLESPEC extern void execute_548(char*, char *);
IKI_DLLESPEC extern void execute_549(char*, char *);
IKI_DLLESPEC extern void execute_555(char*, char *);
IKI_DLLESPEC extern void execute_556(char*, char *);
IKI_DLLESPEC extern void execute_560(char*, char *);
IKI_DLLESPEC extern void execute_561(char*, char *);
IKI_DLLESPEC extern void execute_562(char*, char *);
IKI_DLLESPEC extern void execute_486(char*, char *);
IKI_DLLESPEC extern void execute_487(char*, char *);
IKI_DLLESPEC extern void execute_495(char*, char *);
IKI_DLLESPEC extern void execute_477(char*, char *);
IKI_DLLESPEC extern void execute_483(char*, char *);
IKI_DLLESPEC extern void execute_484(char*, char *);
IKI_DLLESPEC extern void execute_481(char*, char *);
IKI_DLLESPEC extern void execute_489(char*, char *);
IKI_DLLESPEC extern void execute_491(char*, char *);
IKI_DLLESPEC extern void execute_493(char*, char *);
IKI_DLLESPEC extern void execute_523(char*, char *);
IKI_DLLESPEC extern void execute_524(char*, char *);
IKI_DLLESPEC extern void execute_526(char*, char *);
IKI_DLLESPEC extern void execute_514(char*, char *);
IKI_DLLESPEC extern void execute_520(char*, char *);
IKI_DLLESPEC extern void execute_521(char*, char *);
IKI_DLLESPEC extern void execute_518(char*, char *);
IKI_DLLESPEC extern void execute_581(char*, char *);
IKI_DLLESPEC extern void execute_582(char*, char *);
IKI_DLLESPEC extern void execute_586(char*, char *);
IKI_DLLESPEC extern void execute_572(char*, char *);
IKI_DLLESPEC extern void execute_578(char*, char *);
IKI_DLLESPEC extern void execute_579(char*, char *);
IKI_DLLESPEC extern void execute_576(char*, char *);
IKI_DLLESPEC extern void execute_584(char*, char *);
IKI_DLLESPEC extern void execute_636(char*, char *);
IKI_DLLESPEC extern void execute_684(char*, char *);
IKI_DLLESPEC extern void execute_685(char*, char *);
IKI_DLLESPEC extern void execute_686(char*, char *);
IKI_DLLESPEC extern void execute_687(char*, char *);
IKI_DLLESPEC extern void execute_688(char*, char *);
IKI_DLLESPEC extern void execute_689(char*, char *);
IKI_DLLESPEC extern void execute_690(char*, char *);
IKI_DLLESPEC extern void execute_691(char*, char *);
IKI_DLLESPEC extern void execute_692(char*, char *);
IKI_DLLESPEC extern void execute_693(char*, char *);
IKI_DLLESPEC extern void execute_695(char*, char *);
IKI_DLLESPEC extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
IKI_DLLESPEC extern void transaction_53(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_54(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_57(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_58(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_64(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_65(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_68(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_69(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_70(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_77(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_91(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_95(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_102(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_111(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_238(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_255(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_256(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[175] = {(funcp)execute_58, (funcp)execute_59, (funcp)execute_61, (funcp)execute_62, (funcp)execute_63, (funcp)execute_64, (funcp)execute_157, (funcp)execute_223, (funcp)execute_651, (funcp)execute_652, (funcp)execute_660, (funcp)execute_668, (funcp)execute_669, (funcp)execute_228, (funcp)execute_230, (funcp)execute_255, (funcp)execute_233, (funcp)execute_234, (funcp)execute_258, (funcp)execute_262, (funcp)execute_272, (funcp)execute_268, (funcp)execute_269, (funcp)execute_658, (funcp)execute_655, (funcp)execute_656, (funcp)execute_664, (funcp)execute_665, (funcp)execute_666, (funcp)execute_175, (funcp)execute_176, (funcp)execute_190, (funcp)execute_166, (funcp)execute_172, (funcp)execute_173, (funcp)execute_170, (funcp)execute_178, (funcp)execute_180, (funcp)execute_182, (funcp)execute_184, (funcp)execute_186, (funcp)execute_188, (funcp)execute_251, (funcp)execute_252, (funcp)execute_254, (funcp)execute_243, (funcp)execute_248, (funcp)execute_249, (funcp)execute_246, (funcp)execute_281, (funcp)execute_644, (funcp)execute_645, (funcp)execute_285, (funcp)execute_287, (funcp)execute_327, (funcp)execute_329, (funcp)execute_330, (funcp)execute_404, (funcp)execute_413, (funcp)execute_420, (funcp)execute_432, (funcp)execute_614, (funcp)execute_615, (funcp)execute_630, (funcp)execute_613, (funcp)execute_618, (funcp)execute_619, (funcp)execute_293, (funcp)execute_294, (funcp)execute_295, (funcp)execute_301, (funcp)execute_319, (funcp)execute_320, (funcp)execute_322, (funcp)execute_310, (funcp)execute_316, (funcp)execute_317, (funcp)execute_314, (funcp)execute_351, (funcp)execute_342, (funcp)execute_343, (funcp)execute_347, (funcp)execute_354, (funcp)execute_387, (funcp)execute_389, (funcp)execute_390, (funcp)execute_358, (funcp)execute_363, (funcp)execute_381, (funcp)execute_382, (funcp)execute_384, (funcp)execute_372, (funcp)execute_378, (funcp)execute_379, (funcp)execute_376, (funcp)execute_394, (funcp)execute_395, (funcp)execute_396, (funcp)execute_409, (funcp)execute_623, (funcp)execute_445, (funcp)execute_448, (funcp)execute_455, (funcp)execute_496, (funcp)execute_497, (funcp)execute_458, (funcp)execute_462, (funcp)execute_465, (funcp)execute_469, (funcp)execute_501, (funcp)execute_502, (funcp)execute_506, (funcp)execute_548, (funcp)execute_549, (funcp)execute_555, (funcp)execute_556, (funcp)execute_560, (funcp)execute_561, (funcp)execute_562, (funcp)execute_486, (funcp)execute_487, (funcp)execute_495, (funcp)execute_477, (funcp)execute_483, (funcp)execute_484, (funcp)execute_481, (funcp)execute_489, (funcp)execute_491, (funcp)execute_493, (funcp)execute_523, (funcp)execute_524, (funcp)execute_526, (funcp)execute_514, (funcp)execute_520, (funcp)execute_521, (funcp)execute_518, (funcp)execute_581, (funcp)execute_582, (funcp)execute_586, (funcp)execute_572, (funcp)execute_578, (funcp)execute_579, (funcp)execute_576, (funcp)execute_584, (funcp)execute_636, (funcp)execute_684, (funcp)execute_685, (funcp)execute_686, (funcp)execute_687, (funcp)execute_688, (funcp)execute_689, (funcp)execute_690, (funcp)execute_691, (funcp)execute_692, (funcp)execute_693, (funcp)execute_695, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_53, (funcp)transaction_54, (funcp)transaction_57, (funcp)transaction_58, (funcp)transaction_64, (funcp)transaction_65, (funcp)transaction_68, (funcp)transaction_69, (funcp)transaction_70, (funcp)transaction_77, (funcp)transaction_91, (funcp)transaction_95, (funcp)transaction_102, (funcp)transaction_111, (funcp)transaction_238, (funcp)transaction_255, (funcp)transaction_256};
const int NumRelocateId= 175;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/Mixer_1_TB_behav/xsim.reloc",  (void **)funcTab, 175);
	iki_vhdl_file_variable_register(dp + 116136);
	iki_vhdl_file_variable_register(dp + 116192);
	iki_vhdl_file_variable_register(dp + 386144);
	iki_vhdl_file_variable_register(dp + 386248);
	iki_vhdl_file_variable_register(dp + 511440);
	iki_vhdl_file_variable_register(dp + 511544);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/Mixer_1_TB_behav/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/Mixer_1_TB_behav/xsim.reloc");

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
    iki_set_sv_type_file_path_name("xsim.dir/Mixer_1_TB_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/Mixer_1_TB_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/Mixer_1_TB_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, (void*)0, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
