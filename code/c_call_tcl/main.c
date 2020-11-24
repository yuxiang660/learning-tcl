#include <tcl.h>

int main(int argc, char **argv)
{
   char *my_string;
   Tcl_Interp *interp;

   my_string = "MagicWord";
   printf("The secret is '%s'.\n", my_string);
   interp = Tcl_CreateInterp();
   (void) Tcl_SetVar(interp, "my_string", my_string, 0);
   (void) Tcl_EvalFile(interp, "./myscript.tcl");

   return 0;
}
