#include <tcl.h>
#include <stdio.h>

Tcl_Interp *interp;

// Application-specific command procedures
int RandomCmd(ClientData clientData, Tcl_Interp *interp, int argc, const char *argv[]) {
   printf("hello random command\n");
   return 0;
}

int Tcl_AppInit(Tcl_Interp *interp) {
   if (Tcl_Init(interp) == TCL_ERROR) {
      printf("Tcl_Init Error!\n");
      return TCL_ERROR;
   }
   Tcl_CreateCommand(interp, "random", RandomCmd, (ClientData)NULL, (Tcl_CmdDeleteProc *)NULL);
   return TCL_OK;
}

int main(int argc, char *argv[]) {
   Tcl_Main(argc, argv, Tcl_AppInit);
   return 0;
}

