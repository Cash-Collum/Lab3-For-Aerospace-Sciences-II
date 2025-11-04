function err = modelErrorAlpha(XB,YB,ALPHA, CLWant)
    % Find CL
    [CL] = Vortex_Panel(XB,YB,ALPHA);
 
    % Find difference (what's being minimized)
    err = CLWant-CL;
end