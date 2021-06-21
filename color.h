#ifndef _COLORS_
#define _COLORS_

/* FOREGROUND */
#define RST "\x1B[0m"
#define KRED "\x1B[31m"
#define KGRN "\x1B[32m"
#define KYEL "\x1B[33m"
#define KBLU "\x1B[34m"
#define KMAG "\x1B[35m"
#define KCYN "\x1B[36m"
#define KLGE "\x1B[37m"

#define KDGE "\x1B[90m"
#define KLRD "\x1B[91m"
#define KLGR "\x1B[92m"
#define KLYE "\x1B[93m"
#define KLBL "\x1B[94m"
#define KLMG "\x1B[95m"
#define KLCY "\x1B[96m"
#define KWHT "\x1B[97m"

#define FRED(x) KRED x RST
#define FGRN(x) KGRN x RST
#define FYEL(x) KYEL x RST
#define FBLU(x) KBLU x RST
#define FMAG(x) KMAG x RST
#define FCYN(x) KCYN x RST
#define FLGE(x) KLGE x RST

#define FDGE(x) KDGE x RST
#define FLRD(x) KLRD x RST
#define FLGR(x) KLGR x RST
#define FLYE(x) KLYE x RST
#define FLBL(x) KLBL x RST
#define FLMG(x) KLMG x RST
#define FLCY(x) KLCY x RST
#define FWHT(x) KWHT x RST

#define BOLD(x) "\x1B[1m" x RST
#define UNDL(x) "\x1B[4m" x RST

#endif /* _COLORS_ */