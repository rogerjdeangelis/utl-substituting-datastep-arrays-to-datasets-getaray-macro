%let pgm=utl-substituting-datastep-arrays-to-datasets-getaray-macro;

%stop_submission;

see github for complete solution

Programmatically load a rectangular sas dataset into 2d temporary array

You probably should use a hash (associative array) (I have 128gb ram)

data dts;
 array dts %utl_getary(imp1(drop=enddt));
 array eos %utl_getary(imp1(keep=enddt));
 call sortn(of eos[*];
run;quit;

Create these arrays programmatically;

dts[1836,2]

 obs      cdt      enddt
  1    dts[1,1]  dts[1,2]
  2    dts[2,1]  dts[2,2]
 ..

 Similarly for EOS

 eos[1836]

 Obs  enddt
  1   eos[1]
  2   eos[2]

macro on end

github
https://github.com/rogerjdeangelis/utl-substituting-datastep-arrays-to-datasets-getaray-macro

macros
https://tinyurl.com/y9nfugth
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories

SAS-L
https://listserv.uga.edu/scripts/wa-UGA.exe?A2=SAS-L;15ee19b5.2509A&S=

/**************************************************************************************************************************/
/*INPUT                                       | PROCESS                                    | OUTPUT                       */
/*=====                                       | =======                                    | ======                       */
/*   C_SDT     C_EDT    ENRLDT     ENDDT      | data imp1;                                 | dts[1836,2] _temporary_ (... */
/*                                            |  set have;                                 |                              */
/* 13JUL2016 29SEP2016 23SEP2016 07OCT2021    |  do i=c_sdt to c_edt;                      |  obs      cdt      enddt     */
/* 16DEC2016 23AUG2017 23SEP2016 07OCT2021    |  cdt=i;                                    |   1    dts[1,1]  dts[1,2]    */
/* 24AUG2017 07SEP2017 23SEP2016 07OCT2021    |  med='a';                                  |   2    dts[2,1]  dts[2,2]    */
/* 08SEP2017 07OCT2021 23SEP2016 07OCT2021    |  output;                                   |  ..                          */
/*                                            |  end;                                      |                              */
/*                                            |  format i cdt date9.;                      |  1836   ...       ...        */
/* data have;                                 |  keep cdt enrldt enddt;                    |                              */
/*  informat c_sdt c_edt enrldt enddt date9.; | run;                                       |  Similarly for EOS           */
/*    format c_sdt c_edt enrldt enddt date9.; |                                            |                              */
/* input                                      | proc sort data=imp1 out=imp2 ;             |  eos[1836] _temporary_ (...  */
/*   pt c_sdt c_edt enrldt enddt;             |    by cdt ;                                |                              */
/* cards4;                                    | run;                                       |  Obs  enddt                  */
/* 127 13-Jul-16 29-Sep-16 23-Sep-16 07-Oct-21|                                            |   1   eos[1]                 */
/* 127 16-Dec-16 23-Aug-17 23-Sep-16 07-Oct-21|                                            |   2   eos[2]                 */
/* 127 24-Aug-17 07-Sep-17 23-Sep-16 07-Oct-21| * CREATE ARRAYS;                           | 1836   ...                   */
/* 127 08-Sep-17 07-Oct-21 23-Sep-16 07-Oct-21| data dts;                                  |                              */
/* ;;;;                                       |  array dts %utl_getary(imp2(drop=enddt)    |                              */
/* run;quit;                                  |      ,type=_temporary_);                   |                              */
/*                                            |  array eos %utl_getary(imp2(keep=enddt)    |                              */
/*                                            |      ,type=_temporary_);                   |                              */
/* data imp1;                                 |  call sortn(of eos[*]);                    |                              */
/*  set have;                                 | run;quit;                                  |                              */
/*  do i=c_sdt to c_edt;                      |                                            |                              */
/*  cdt=i;                                    | OR YOU CAN GET PERMANENT ARRAYS.           |                              */
/*  med='a';                                  | JUST DO NOT SPECIFY _TEMPORARY_            |                              */
/*  output;                                   |                                            |                              */
/*  end;                                      |                                            |                              */
/*  format i cdt date9.;                      |                                            |                              */
/*  keep cdt enrldt enddt;                    |                                            |                              */
/* run;                                       |                                            |                              */
/*                                            |                                            |                              */
/* proc sort data=imp1 out=imp2 ;             |                                            |                              */
/*    by cdt ;                                |                                            |                              */
/* run;                                       |                                            |                              */
/*                                            |                                            |                              */
/* I removed constants which can be dded      |                                            |                              */
/* ie pt=127,med='a'. i is just the row indes |                                            |                              */
/*                                            |                                            |                              */
/* data dts;                                  |                                            |                              */
/*  array dts %utl_getary(imp1(drop=enddt));  |                                            |                              */
/*  array eos %utl_getary(imp1(keep=enddt));  |                                            |                              */
/*  call sortn(of eos[*];                     |                                            |                              */
/* run;quit;                                  |                                            |                              */
/******************************************************|*******************************************************************/

data have;
 informat c_sdt c_edt enrldt enddt date9.;
   format c_sdt c_edt enrldt enddt date9.;           NOTE: The data set WORK.DTS has 1
input                                                observations and 5508 variables.
  pt c_sdt c_edt enrldt enddt;
cards4;
127 13-Jul-16 29-Sep-16 23-Sep-16 07-Oct-21
127 16-Dec-16 23-Aug-17 23-Sep-16 07-Oct-21
127 24-Aug-17 07-Sep-17 23-Sep-16 07-Oct-21
127 08-Sep-17 07-Oct-21 23-Sep-16 07-Oct-21
;;;;
run;quit;

/**************************************************************************************************************************/
/*  PT   C_SDT        C_EDT       ENRLDT        ENDDT                                                                     */
/*                                                                                                                        */
/* 127 13JUL2016    29SEP2016    23SEP2016    07OCT2021                                                                   */
/* 127 16DEC2016    23AUG2017    23SEP2016    07OCT2021                                                                   */
/* 127 24AUG2017    07SEP2017    23SEP2016    07OCT2021                                                                   */
/* 127 08SEP2017    07OCT2021    23SEP2016    07OCT2021                                                                   */
/**************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

data imp1;
 set have;
 do i=c_sdt to c_edt;
 cdt=i;
 med='a';
 output;
 end;
 format i cdt date9.;
 keep cdt enrldt enddt;
run;

proc sort data=imp1 out=imp2 ;
   by cdt ;
run;

* CREATE ARRAYS;
data dts;
 array dts %utl_getary(imp2(drop=enddt)
     ,type=_temporary_);
 array eos %utl_getary(imp2(keep=enddt)
     ,type=_temporary_);
 call sortn(of eos[*]);
run;quit;


/**************************************************************************************************************************/
/*  dts[1836,2] _temporary_ (...                                                                                          */
/*                                                                                                                        */
/*   obs      cdt      enddt                                                                                              */
/*    1    dts[1,1]  dts[1,2]                                                                                             */
/*    2    dts[2,1]  dts[2,2]                                                                                             */
/*   ..                                                                                                                   */
/*   1836   ...       ...                                                                                                 */
/*                                                                                                                        */
/*   Similarly for EOS                                                                                                    */
/*                                                                                                                        */
/*   eos[1836] _temporary_ (...                                                                                           */
/*                                                                                                                        */
/*   Obs  enddt                                                                                                           */
/*    1   eos[1]                                                                                                          */
/*    2   eos[2]                                                                                                          */
/*  ...    ...                                                                                                            */
/*  1836                                                                                                                  */
/**************************************************************************************************************************/
/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

dts[1836,2]
-----------
SYMBOLGEN:  Macro variable ARY resolves to [1836,2] _temporary_ (
            20720,20648,20720,20649,20720,20650,20720,20651,20720,20652,20720,20653, ...
            20,20661,20720,20662,20720,20663,20720,20664,20720,20665,20720,20666,207 ...
            20674,20720,20675,20720,20676,20720,20677,20720,20678,20720,20679,20720, ...
            87,20720,20688,20720,20689,20720,20690,20720,20691,20720,20692,20720,206 ...

eos[1838]
---------
SYMBOLGEN:  Macro variable ARY resolves to [1836,1] _temporary_ (
            22560,22560,22560,22560,22560,22560,22560,22560,22560,22560,22560,22560, ...
            60,22560,22560,22560,22560,22560,22560,22560,22560,22560,22560,22560,225 ...
            22560,22560,22560,22560,22560,22560,22560,22560,22560,22560,22560,22560, ...

/*
 _ __ ___   __ _  ___ _ __ ___
| `_ ` _ \ / _` |/ __| `__/ _ \
| | | | | | (_| | (__| | | (_) |
|_| |_| |_|\__,_|\___|_|  \___/

*/

filename ft15f001 "c:/oto/utl_getary.sas";
parmcards4;
%macro utl_getary(dsn,type=);
%symdel ary/nowarn;
%dosubl('
%symdel ary/nowarn;
data _null_;
  set &dsn end=eof;
  array vars[*] _numeric_;
  length allvals $32756;
  length array_str $32756;
  length prefix $44;
  retain allvals;
  length temp $32;
  do i = 1 to dim(vars);
    temp = strip(put(vars[i], best32.));
    if missing(allvals) then allvals = temp;
    else allvals = catx(",", allvals, temp);
  end;
  if eof then do;
    r = _n_;
    c = dim(vars);
    prefix = cats("[",r,",",c,"] &type (");
    suffix = ");";
    array_str = catx(" ",prefix,allvals,suffix);
    put array_str=;
    call symputx("ary",array_str);
  end;
run;quit;
')
&ary
%mend utl_getary;
;;;;
run;quit;

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
