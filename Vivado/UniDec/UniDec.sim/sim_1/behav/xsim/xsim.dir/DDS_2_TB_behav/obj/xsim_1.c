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
IKI_DLLESPEC extern void execute_45(char*, char *);
IKI_DLLESPEC extern void execute_46(char*, char *);
IKI_DLLESPEC extern void execute_6121(char*, char *);
IKI_DLLESPEC extern void execute_48(char*, char *);
IKI_DLLESPEC extern void execute_49(char*, char *);
IKI_DLLESPEC extern void execute_50(char*, char *);
IKI_DLLESPEC extern void execute_68(char*, char *);
IKI_DLLESPEC extern void execute_69(char*, char *);
IKI_DLLESPEC extern void execute_70(char*, char *);
IKI_DLLESPEC extern void execute_71(char*, char *);
IKI_DLLESPEC extern void execute_6119(char*, char *);
IKI_DLLESPEC extern void execute_6120(char*, char *);
IKI_DLLESPEC extern void execute_154(char*, char *);
IKI_DLLESPEC extern void execute_220(char*, char *);
IKI_DLLESPEC extern void execute_722(char*, char *);
IKI_DLLESPEC extern void execute_723(char*, char *);
IKI_DLLESPEC extern void execute_731(char*, char *);
IKI_DLLESPEC extern void execute_739(char*, char *);
IKI_DLLESPEC extern void execute_740(char*, char *);
IKI_DLLESPEC extern void execute_225(char*, char *);
IKI_DLLESPEC extern void execute_227(char*, char *);
IKI_DLLESPEC extern void execute_252(char*, char *);
IKI_DLLESPEC extern void execute_230(char*, char *);
IKI_DLLESPEC extern void execute_231(char*, char *);
IKI_DLLESPEC extern void execute_255(char*, char *);
IKI_DLLESPEC extern void execute_258(char*, char *);
IKI_DLLESPEC extern void execute_260(char*, char *);
IKI_DLLESPEC extern void execute_270(char*, char *);
IKI_DLLESPEC extern void execute_266(char*, char *);
IKI_DLLESPEC extern void execute_267(char*, char *);
IKI_DLLESPEC extern void execute_729(char*, char *);
IKI_DLLESPEC extern void execute_726(char*, char *);
IKI_DLLESPEC extern void execute_727(char*, char *);
IKI_DLLESPEC extern void execute_735(char*, char *);
IKI_DLLESPEC extern void execute_736(char*, char *);
IKI_DLLESPEC extern void execute_737(char*, char *);
IKI_DLLESPEC extern void execute_172(char*, char *);
IKI_DLLESPEC extern void execute_173(char*, char *);
IKI_DLLESPEC extern void execute_187(char*, char *);
IKI_DLLESPEC extern void execute_163(char*, char *);
IKI_DLLESPEC extern void execute_169(char*, char *);
IKI_DLLESPEC extern void execute_170(char*, char *);
IKI_DLLESPEC extern void execute_167(char*, char *);
IKI_DLLESPEC extern void execute_175(char*, char *);
IKI_DLLESPEC extern void execute_177(char*, char *);
IKI_DLLESPEC extern void execute_179(char*, char *);
IKI_DLLESPEC extern void execute_181(char*, char *);
IKI_DLLESPEC extern void execute_183(char*, char *);
IKI_DLLESPEC extern void execute_185(char*, char *);
IKI_DLLESPEC extern void execute_204(char*, char *);
IKI_DLLESPEC extern void execute_205(char*, char *);
IKI_DLLESPEC extern void execute_219(char*, char *);
IKI_DLLESPEC extern void execute_195(char*, char *);
IKI_DLLESPEC extern void execute_201(char*, char *);
IKI_DLLESPEC extern void execute_202(char*, char *);
IKI_DLLESPEC extern void execute_199(char*, char *);
IKI_DLLESPEC extern void execute_207(char*, char *);
IKI_DLLESPEC extern void execute_209(char*, char *);
IKI_DLLESPEC extern void execute_211(char*, char *);
IKI_DLLESPEC extern void execute_213(char*, char *);
IKI_DLLESPEC extern void execute_215(char*, char *);
IKI_DLLESPEC extern void execute_217(char*, char *);
IKI_DLLESPEC extern void execute_248(char*, char *);
IKI_DLLESPEC extern void execute_249(char*, char *);
IKI_DLLESPEC extern void execute_251(char*, char *);
IKI_DLLESPEC extern void execute_240(char*, char *);
IKI_DLLESPEC extern void execute_245(char*, char *);
IKI_DLLESPEC extern void execute_246(char*, char *);
IKI_DLLESPEC extern void execute_243(char*, char *);
IKI_DLLESPEC extern void execute_279(char*, char *);
IKI_DLLESPEC extern void execute_715(char*, char *);
IKI_DLLESPEC extern void execute_716(char*, char *);
IKI_DLLESPEC extern void execute_283(char*, char *);
IKI_DLLESPEC extern void execute_285(char*, char *);
IKI_DLLESPEC extern void execute_323(char*, char *);
IKI_DLLESPEC extern void execute_326(char*, char *);
IKI_DLLESPEC extern void execute_327(char*, char *);
IKI_DLLESPEC extern void execute_325(char*, char *);
IKI_DLLESPEC extern void execute_329(char*, char *);
IKI_DLLESPEC extern void execute_330(char*, char *);
IKI_DLLESPEC extern void execute_331(char*, char *);
IKI_DLLESPEC extern void execute_352(char*, char *);
IKI_DLLESPEC extern void execute_479(char*, char *);
IKI_DLLESPEC extern void execute_488(char*, char *);
IKI_DLLESPEC extern void execute_495(char*, char *);
IKI_DLLESPEC extern void execute_507(char*, char *);
IKI_DLLESPEC extern void execute_685(char*, char *);
IKI_DLLESPEC extern void execute_686(char*, char *);
IKI_DLLESPEC extern void execute_701(char*, char *);
IKI_DLLESPEC extern void execute_684(char*, char *);
IKI_DLLESPEC extern void execute_689(char*, char *);
IKI_DLLESPEC extern void execute_690(char*, char *);
IKI_DLLESPEC extern void execute_291(char*, char *);
IKI_DLLESPEC extern void execute_292(char*, char *);
IKI_DLLESPEC extern void execute_293(char*, char *);
IKI_DLLESPEC extern void execute_296(char*, char *);
IKI_DLLESPEC extern void execute_313(char*, char *);
IKI_DLLESPEC extern void execute_314(char*, char *);
IKI_DLLESPEC extern void execute_316(char*, char *);
IKI_DLLESPEC extern void execute_304(char*, char *);
IKI_DLLESPEC extern void execute_310(char*, char *);
IKI_DLLESPEC extern void execute_311(char*, char *);
IKI_DLLESPEC extern void execute_308(char*, char *);
IKI_DLLESPEC extern void execute_337(char*, char *);
IKI_DLLESPEC extern void execute_338(char*, char *);
IKI_DLLESPEC extern void execute_339(char*, char *);
IKI_DLLESPEC extern void execute_343(char*, char *);
IKI_DLLESPEC extern void execute_344(char*, char *);
IKI_DLLESPEC extern void execute_345(char*, char *);
IKI_DLLESPEC extern void execute_396(char*, char *);
IKI_DLLESPEC extern void execute_360(char*, char *);
IKI_DLLESPEC extern void execute_361(char*, char *);
IKI_DLLESPEC extern void execute_362(char*, char *);
IKI_DLLESPEC extern void execute_368(char*, char *);
IKI_DLLESPEC extern void execute_369(char*, char *);
IKI_DLLESPEC extern void execute_393(char*, char *);
IKI_DLLESPEC extern void execute_399(char*, char *);
IKI_DLLESPEC extern void execute_432(char*, char *);
IKI_DLLESPEC extern void execute_436(char*, char *);
IKI_DLLESPEC extern void execute_437(char*, char *);
IKI_DLLESPEC extern void execute_388(char*, char *);
IKI_DLLESPEC extern void execute_389(char*, char *);
IKI_DLLESPEC extern void execute_391(char*, char *);
IKI_DLLESPEC extern void execute_379(char*, char *);
IKI_DLLESPEC extern void execute_385(char*, char *);
IKI_DLLESPEC extern void execute_386(char*, char *);
IKI_DLLESPEC extern void execute_383(char*, char *);
IKI_DLLESPEC extern void execute_403(char*, char *);
IKI_DLLESPEC extern void execute_408(char*, char *);
IKI_DLLESPEC extern void execute_426(char*, char *);
IKI_DLLESPEC extern void execute_427(char*, char *);
IKI_DLLESPEC extern void execute_429(char*, char *);
IKI_DLLESPEC extern void execute_417(char*, char *);
IKI_DLLESPEC extern void execute_423(char*, char *);
IKI_DLLESPEC extern void execute_424(char*, char *);
IKI_DLLESPEC extern void execute_421(char*, char *);
IKI_DLLESPEC extern void execute_441(char*, char *);
IKI_DLLESPEC extern void execute_442(char*, char *);
IKI_DLLESPEC extern void execute_443(char*, char *);
IKI_DLLESPEC extern void execute_451(char*, char *);
IKI_DLLESPEC extern void execute_452(char*, char *);
IKI_DLLESPEC extern void execute_473(char*, char *);
IKI_DLLESPEC extern void execute_484(char*, char *);
IKI_DLLESPEC extern void execute_694(char*, char *);
IKI_DLLESPEC extern void execute_516(char*, char *);
IKI_DLLESPEC extern void execute_519(char*, char *);
IKI_DLLESPEC extern void execute_526(char*, char *);
IKI_DLLESPEC extern void execute_567(char*, char *);
IKI_DLLESPEC extern void execute_568(char*, char *);
IKI_DLLESPEC extern void execute_529(char*, char *);
IKI_DLLESPEC extern void execute_533(char*, char *);
IKI_DLLESPEC extern void execute_536(char*, char *);
IKI_DLLESPEC extern void execute_540(char*, char *);
IKI_DLLESPEC extern void execute_572(char*, char *);
IKI_DLLESPEC extern void execute_573(char*, char *);
IKI_DLLESPEC extern void execute_577(char*, char *);
IKI_DLLESPEC extern void execute_619(char*, char *);
IKI_DLLESPEC extern void execute_620(char*, char *);
IKI_DLLESPEC extern void execute_626(char*, char *);
IKI_DLLESPEC extern void execute_627(char*, char *);
IKI_DLLESPEC extern void execute_631(char*, char *);
IKI_DLLESPEC extern void execute_632(char*, char *);
IKI_DLLESPEC extern void execute_633(char*, char *);
IKI_DLLESPEC extern void execute_557(char*, char *);
IKI_DLLESPEC extern void execute_558(char*, char *);
IKI_DLLESPEC extern void execute_566(char*, char *);
IKI_DLLESPEC extern void execute_548(char*, char *);
IKI_DLLESPEC extern void execute_554(char*, char *);
IKI_DLLESPEC extern void execute_555(char*, char *);
IKI_DLLESPEC extern void execute_552(char*, char *);
IKI_DLLESPEC extern void execute_560(char*, char *);
IKI_DLLESPEC extern void execute_562(char*, char *);
IKI_DLLESPEC extern void execute_564(char*, char *);
IKI_DLLESPEC extern void execute_594(char*, char *);
IKI_DLLESPEC extern void execute_595(char*, char *);
IKI_DLLESPEC extern void execute_597(char*, char *);
IKI_DLLESPEC extern void execute_585(char*, char *);
IKI_DLLESPEC extern void execute_591(char*, char *);
IKI_DLLESPEC extern void execute_592(char*, char *);
IKI_DLLESPEC extern void execute_589(char*, char *);
IKI_DLLESPEC extern void execute_652(char*, char *);
IKI_DLLESPEC extern void execute_653(char*, char *);
IKI_DLLESPEC extern void execute_657(char*, char *);
IKI_DLLESPEC extern void execute_643(char*, char *);
IKI_DLLESPEC extern void execute_649(char*, char *);
IKI_DLLESPEC extern void execute_650(char*, char *);
IKI_DLLESPEC extern void execute_647(char*, char *);
IKI_DLLESPEC extern void execute_655(char*, char *);
IKI_DLLESPEC extern void execute_707(char*, char *);
IKI_DLLESPEC extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
IKI_DLLESPEC extern void transaction_70(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_71(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_74(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_75(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_81(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_82(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_85(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_86(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_87(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_94(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_108(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_112(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_119(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_128(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_255(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_272(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_279(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_286(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_296(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_297(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_472(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_473(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_476(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_477(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_483(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_484(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_487(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_488(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_489(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_496(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_510(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_514(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_521(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_530(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_628(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_645(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_652(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_659(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_669(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_670(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_845(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_846(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_849(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_850(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_856(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_857(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_860(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_861(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_862(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_869(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_883(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_887(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_894(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_903(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1001(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1018(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1025(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1032(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1042(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1043(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1218(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1219(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1222(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1223(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1229(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1230(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1233(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1234(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1235(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1242(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1256(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1260(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1267(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1276(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1374(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1391(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1398(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1405(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1415(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1416(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1591(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1592(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1595(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1596(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1602(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1603(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1606(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1607(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1608(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1615(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1629(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1633(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1640(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1649(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1747(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1764(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1771(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1778(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1788(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1789(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1964(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1965(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1968(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1969(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1975(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1976(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1979(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1980(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1981(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1988(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2002(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2006(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2013(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2022(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2120(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2137(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2144(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2151(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2161(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2162(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2337(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2338(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2341(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2342(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2348(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2349(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2352(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2353(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2354(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2361(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2375(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2379(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2386(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2395(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2493(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2510(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2517(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2524(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2534(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2535(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2710(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2711(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2714(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2715(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2721(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2722(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2725(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2726(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2727(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2734(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2748(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2752(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2759(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2768(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2866(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2883(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2890(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2897(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2907(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_2908(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3083(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3084(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3087(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3088(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3094(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3095(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3098(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3099(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3100(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3107(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3121(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3125(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3132(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3141(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3239(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3256(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3263(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3270(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3280(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3281(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3456(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3457(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3460(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3461(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3467(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3468(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3471(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3472(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3473(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3480(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3494(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3498(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3505(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3514(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3612(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3629(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3636(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3643(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3653(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3654(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[391] = {(funcp)execute_45, (funcp)execute_46, (funcp)execute_6121, (funcp)execute_48, (funcp)execute_49, (funcp)execute_50, (funcp)execute_68, (funcp)execute_69, (funcp)execute_70, (funcp)execute_71, (funcp)execute_6119, (funcp)execute_6120, (funcp)execute_154, (funcp)execute_220, (funcp)execute_722, (funcp)execute_723, (funcp)execute_731, (funcp)execute_739, (funcp)execute_740, (funcp)execute_225, (funcp)execute_227, (funcp)execute_252, (funcp)execute_230, (funcp)execute_231, (funcp)execute_255, (funcp)execute_258, (funcp)execute_260, (funcp)execute_270, (funcp)execute_266, (funcp)execute_267, (funcp)execute_729, (funcp)execute_726, (funcp)execute_727, (funcp)execute_735, (funcp)execute_736, (funcp)execute_737, (funcp)execute_172, (funcp)execute_173, (funcp)execute_187, (funcp)execute_163, (funcp)execute_169, (funcp)execute_170, (funcp)execute_167, (funcp)execute_175, (funcp)execute_177, (funcp)execute_179, (funcp)execute_181, (funcp)execute_183, (funcp)execute_185, (funcp)execute_204, (funcp)execute_205, (funcp)execute_219, (funcp)execute_195, (funcp)execute_201, (funcp)execute_202, (funcp)execute_199, (funcp)execute_207, (funcp)execute_209, (funcp)execute_211, (funcp)execute_213, (funcp)execute_215, (funcp)execute_217, (funcp)execute_248, (funcp)execute_249, (funcp)execute_251, (funcp)execute_240, (funcp)execute_245, (funcp)execute_246, (funcp)execute_243, (funcp)execute_279, (funcp)execute_715, (funcp)execute_716, (funcp)execute_283, (funcp)execute_285, (funcp)execute_323, (funcp)execute_326, (funcp)execute_327, (funcp)execute_325, (funcp)execute_329, (funcp)execute_330, (funcp)execute_331, (funcp)execute_352, (funcp)execute_479, (funcp)execute_488, (funcp)execute_495, (funcp)execute_507, (funcp)execute_685, (funcp)execute_686, (funcp)execute_701, (funcp)execute_684, (funcp)execute_689, (funcp)execute_690, (funcp)execute_291, (funcp)execute_292, (funcp)execute_293, (funcp)execute_296, (funcp)execute_313, (funcp)execute_314, (funcp)execute_316, (funcp)execute_304, (funcp)execute_310, (funcp)execute_311, (funcp)execute_308, (funcp)execute_337, (funcp)execute_338, (funcp)execute_339, (funcp)execute_343, (funcp)execute_344, (funcp)execute_345, (funcp)execute_396, (funcp)execute_360, (funcp)execute_361, (funcp)execute_362, (funcp)execute_368, (funcp)execute_369, (funcp)execute_393, (funcp)execute_399, (funcp)execute_432, (funcp)execute_436, (funcp)execute_437, (funcp)execute_388, (funcp)execute_389, (funcp)execute_391, (funcp)execute_379, (funcp)execute_385, (funcp)execute_386, (funcp)execute_383, (funcp)execute_403, (funcp)execute_408, (funcp)execute_426, (funcp)execute_427, (funcp)execute_429, (funcp)execute_417, (funcp)execute_423, (funcp)execute_424, (funcp)execute_421, (funcp)execute_441, (funcp)execute_442, (funcp)execute_443, (funcp)execute_451, (funcp)execute_452, (funcp)execute_473, (funcp)execute_484, (funcp)execute_694, (funcp)execute_516, (funcp)execute_519, (funcp)execute_526, (funcp)execute_567, (funcp)execute_568, (funcp)execute_529, (funcp)execute_533, (funcp)execute_536, (funcp)execute_540, (funcp)execute_572, (funcp)execute_573, (funcp)execute_577, (funcp)execute_619, (funcp)execute_620, (funcp)execute_626, (funcp)execute_627, (funcp)execute_631, (funcp)execute_632, (funcp)execute_633, (funcp)execute_557, (funcp)execute_558, (funcp)execute_566, (funcp)execute_548, (funcp)execute_554, (funcp)execute_555, (funcp)execute_552, (funcp)execute_560, (funcp)execute_562, (funcp)execute_564, (funcp)execute_594, (funcp)execute_595, (funcp)execute_597, (funcp)execute_585, (funcp)execute_591, (funcp)execute_592, (funcp)execute_589, (funcp)execute_652, (funcp)execute_653, (funcp)execute_657, (funcp)execute_643, (funcp)execute_649, (funcp)execute_650, (funcp)execute_647, (funcp)execute_655, (funcp)execute_707, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_70, (funcp)transaction_71, (funcp)transaction_74, (funcp)transaction_75, (funcp)transaction_81, (funcp)transaction_82, (funcp)transaction_85, (funcp)transaction_86, (funcp)transaction_87, (funcp)transaction_94, (funcp)transaction_108, (funcp)transaction_112, (funcp)transaction_119, (funcp)transaction_128, (funcp)transaction_255, (funcp)transaction_272, (funcp)transaction_279, (funcp)transaction_286, (funcp)transaction_296, (funcp)transaction_297, (funcp)transaction_472, (funcp)transaction_473, (funcp)transaction_476, (funcp)transaction_477, (funcp)transaction_483, (funcp)transaction_484, (funcp)transaction_487, (funcp)transaction_488, (funcp)transaction_489, (funcp)transaction_496, (funcp)transaction_510, (funcp)transaction_514, (funcp)transaction_521, (funcp)transaction_530, (funcp)transaction_628, (funcp)transaction_645, (funcp)transaction_652, (funcp)transaction_659, (funcp)transaction_669, (funcp)transaction_670, (funcp)transaction_845, (funcp)transaction_846, (funcp)transaction_849, (funcp)transaction_850, (funcp)transaction_856, (funcp)transaction_857, (funcp)transaction_860, (funcp)transaction_861, (funcp)transaction_862, (funcp)transaction_869, (funcp)transaction_883, (funcp)transaction_887, (funcp)transaction_894, (funcp)transaction_903, (funcp)transaction_1001, (funcp)transaction_1018, (funcp)transaction_1025, (funcp)transaction_1032, (funcp)transaction_1042, (funcp)transaction_1043, (funcp)transaction_1218, (funcp)transaction_1219, (funcp)transaction_1222, (funcp)transaction_1223, (funcp)transaction_1229, (funcp)transaction_1230, (funcp)transaction_1233, (funcp)transaction_1234, (funcp)transaction_1235, (funcp)transaction_1242, (funcp)transaction_1256, (funcp)transaction_1260, (funcp)transaction_1267, (funcp)transaction_1276, (funcp)transaction_1374, (funcp)transaction_1391, (funcp)transaction_1398, (funcp)transaction_1405, (funcp)transaction_1415, (funcp)transaction_1416, (funcp)transaction_1591, (funcp)transaction_1592, (funcp)transaction_1595, (funcp)transaction_1596, (funcp)transaction_1602, (funcp)transaction_1603, (funcp)transaction_1606, (funcp)transaction_1607, (funcp)transaction_1608, (funcp)transaction_1615, (funcp)transaction_1629, (funcp)transaction_1633, (funcp)transaction_1640, (funcp)transaction_1649, (funcp)transaction_1747, (funcp)transaction_1764, (funcp)transaction_1771, (funcp)transaction_1778, (funcp)transaction_1788, (funcp)transaction_1789, (funcp)transaction_1964, (funcp)transaction_1965, (funcp)transaction_1968, (funcp)transaction_1969, (funcp)transaction_1975, (funcp)transaction_1976, (funcp)transaction_1979, (funcp)transaction_1980, (funcp)transaction_1981, (funcp)transaction_1988, (funcp)transaction_2002, (funcp)transaction_2006, (funcp)transaction_2013, (funcp)transaction_2022, (funcp)transaction_2120, (funcp)transaction_2137, (funcp)transaction_2144, (funcp)transaction_2151, (funcp)transaction_2161, (funcp)transaction_2162, (funcp)transaction_2337, (funcp)transaction_2338, (funcp)transaction_2341, (funcp)transaction_2342, (funcp)transaction_2348, (funcp)transaction_2349, (funcp)transaction_2352, (funcp)transaction_2353, (funcp)transaction_2354, (funcp)transaction_2361, (funcp)transaction_2375, (funcp)transaction_2379, (funcp)transaction_2386, (funcp)transaction_2395, (funcp)transaction_2493, (funcp)transaction_2510, (funcp)transaction_2517, (funcp)transaction_2524, (funcp)transaction_2534, (funcp)transaction_2535, (funcp)transaction_2710, (funcp)transaction_2711, (funcp)transaction_2714, (funcp)transaction_2715, (funcp)transaction_2721, (funcp)transaction_2722, (funcp)transaction_2725, (funcp)transaction_2726, (funcp)transaction_2727, (funcp)transaction_2734, (funcp)transaction_2748, (funcp)transaction_2752, (funcp)transaction_2759, (funcp)transaction_2768, (funcp)transaction_2866, (funcp)transaction_2883, (funcp)transaction_2890, (funcp)transaction_2897, (funcp)transaction_2907, (funcp)transaction_2908, (funcp)transaction_3083, (funcp)transaction_3084, (funcp)transaction_3087, (funcp)transaction_3088, (funcp)transaction_3094, (funcp)transaction_3095, (funcp)transaction_3098, (funcp)transaction_3099, (funcp)transaction_3100, (funcp)transaction_3107, (funcp)transaction_3121, (funcp)transaction_3125, (funcp)transaction_3132, (funcp)transaction_3141, (funcp)transaction_3239, (funcp)transaction_3256, (funcp)transaction_3263, (funcp)transaction_3270, (funcp)transaction_3280, (funcp)transaction_3281, (funcp)transaction_3456, (funcp)transaction_3457, (funcp)transaction_3460, (funcp)transaction_3461, (funcp)transaction_3467, (funcp)transaction_3468, (funcp)transaction_3471, (funcp)transaction_3472, (funcp)transaction_3473, (funcp)transaction_3480, (funcp)transaction_3494, (funcp)transaction_3498, (funcp)transaction_3505, (funcp)transaction_3514, (funcp)transaction_3612, (funcp)transaction_3629, (funcp)transaction_3636, (funcp)transaction_3643, (funcp)transaction_3653, (funcp)transaction_3654};
const int NumRelocateId= 391;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/DDS_2_TB_behav/xsim.reloc",  (void **)funcTab, 391);
	iki_vhdl_file_variable_register(dp + 1144984);
	iki_vhdl_file_variable_register(dp + 1145040);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/DDS_2_TB_behav/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/DDS_2_TB_behav/xsim.reloc");

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
    iki_set_sv_type_file_path_name("xsim.dir/DDS_2_TB_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/DDS_2_TB_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/DDS_2_TB_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, (void*)0, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
